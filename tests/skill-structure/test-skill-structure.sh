#!/usr/bin/env bash
# Repo-wide structural checks for every skill in skills/. Behavior is tested
# by scenario evals and the skill tests under tests/; this script only checks
# the things a shell can check: frontmatter, referenced files exist, and no
# local paths leaked into shipped files.
#
# Adapted from superpowers' tests/diagnosing-superpowers/test-skill-structure.sh,
# which checked one skill. The checks that do not generalize are dropped here:
# - "description starts with 'Use when'" and the workflow-word ban are
#   superpowers style rules; most Forge Anything descriptions do not follow
#   them, and "then"/"step" are ordinary words.
# - The 1000-word body budget does not fit this repo: 61 of 100 skills exceed
#   it. Byte size is covered by tests/skill-size/test-skill-size.sh instead.
# - Required sections ("## Hard rules", "## Red Flags") are specific to one
#   skill, not a repo-wide requirement.
# - "the user" never appearing is a superpowers voice rule; Forge Anything
#   skills address "the operator".
#
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

PASSES=0
FAILURES=0

pass() { echo "  [PASS] $1"; PASSES=$((PASSES + 1)); }
fail() { echo "  [FAIL] $1"; FAILURES=$((FAILURES + 1)); }

echo "skill structure (repo-wide)"

for skill_dir in "$SKILLS_DIR"/*/; do
  name="$(basename "$skill_dir")"
  skill_md="$skill_dir/SKILL.md"
  [ -f "$skill_md" ] || continue

  # --- frontmatter name matches the directory ------------------------------
  frontmatter="$(awk 'NR==1 && $0!="---"{exit} NR>1 && $0=="---"{exit} NR>1{print}' "$skill_md")"
  fm_name="$(printf '%s\n' "$frontmatter" | awk -F': *' '/^name:/{print $2; exit}' | tr -d '"' | tr -d "'")"
  if [[ "$fm_name" == "$name" ]]; then
    pass "$name: frontmatter name matches directory"
  else
    fail "$name: frontmatter name is '$fm_name', expected '$name'"
  fi

  # --- description present and under 1024 characters -----------------------
  description="$(printf '%s\n' "$frontmatter" | awk '/^description:/{sub(/^description:[ ]*/,""); print; found=1; next} found && /^[ ]/{print} found && !/^[ ]/{exit}' | tr '\n' ' ')"
  if [[ -n "${description// /}" ]]; then
    if [[ "${#description}" -le 1024 ]]; then
      pass "$name: description present and under 1024 characters"
    else
      fail "$name: description under 1024 characters (${#description})"
    fi
  else
    fail "$name: description present"
  fi

  # --- every referenced file exists ---------------------------------------
  # Local references: a path starting with references/, prompts/, templates/,
  # agents/ or scripts/ at a word boundary, ending in a file extension.
  # The PCRE lookbehind keeps cross-skill "using-references/..." paths from
  # matching as a substring, and the extension requirement keeps bare
  # directory mentions (agents/, references/templates/) from being treated
  # as file references.
  # Resolution: references/, prompts/, templates/, agents/ are skill-local.
  # scripts/ is both: most skills ship Python helpers in their own
  # scripts/ directory, but the repo-root scripts/ directory holds the
  # maintainer shell scripts (release.sh and friends) that skills invoke
  # from the repo root as ./scripts/<name>. A scripts/ reference passes
  # when the file exists in either location; it fails only when it exists
  # in neither.
  while IFS= read -r ref; do
    if [[ -f "$skill_dir/$ref" ]]; then
      pass "$name: referenced file exists: $ref"
    elif [[ "$ref" == scripts/* && -f "$REPO_ROOT/$ref" ]]; then
      pass "$name: referenced file exists: $ref (repo-root scripts/)"
    else
      fail "$name: referenced file exists: $ref"
    fi
  done < <(grep -oP '(?<![A-Za-z0-9_-])(references|prompts|templates|agents|scripts)/[A-Za-z0-9._/-]*\.[A-Za-z0-9]+' "$skill_md" | sort -u)
  # Cross-skill references: using-references/<file> resolves to the
  # using-forge-anything skill's references/ directory.
  while IFS= read -r ref; do
    local_file="${ref#using-references/}"
    if [[ -f "$SKILLS_DIR/using-forge-anything/references/$local_file" ]]; then
      pass "$name: cross-skill reference exists: $ref"
    else
      fail "$name: cross-skill reference exists: $ref"
    fi
  done < <(grep -oP 'using-references/[A-Za-z0-9._/-]*\.[A-Za-z0-9]+' "$skill_md" | sort -u)
done

# --- no local paths leaked into shipped files ------------------------------
# Absolute home directories of real machines. The generic example path
# /home/project/... is not a leak and is not matched here.
leaks="$(grep -rn -E '/Users/[^ /]+|/home/(galyarder|hatch|root|ubuntu)[^ /]*' "$SKILLS_DIR" --include='*.md' 2>/dev/null || true)"
if [[ -z "$leaks" ]]; then
  pass "no machine-specific home paths in shipped skill files"
else
  fail "no machine-specific home paths in shipped skill files"
  printf '%s\n' "$leaks" | head -10 | sed 's/^/    /'
fi

echo
echo "Passed: $PASSES  Failed: $FAILURES"
[[ "$FAILURES" -eq 0 ]]
