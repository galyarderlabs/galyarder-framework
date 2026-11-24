#!/usr/bin/env bash
# Usage:
#   ./scripts/convert.sh [--tool <name>] [--out <dir>] [--help]
#
# Tools: forge-agent, all
# Default: all
#
# Forge Agent is the only remaining generated surface. Every other harness
# (Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI,
# Hermes) is served by its native plugin manifest, which reads the canonical
# skills/, agents/, and commands/ directories directly.

set -euo pipefail

# HARDENED PATH RESOLUTION: Trace symlinks to the real framework source
REAL_PATH=$(readlink -f "$0")
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

TOOL="all"
OUT_BASE="${REPO_ROOT}/integrations"
TODAY="$(date +%F)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

ok() { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[!!]${NC} $*"; }
err() { echo -e "${RED}[ERR]${NC} $*" >&2; }
info() { echo -e "${BLUE}[*]${NC} $*"; }

usage() {
  cat <<'USAGE'
Usage:
  ./scripts/convert.sh [--tool <name>] [--out <dir>] [--help]

Tools:
  forge-agent, all

Defaults:
  --tool all
  --out  <repo-root>/integrations
USAGE
}

is_valid_tool() {
  case "$1" in
    forge-agent|all) return 0 ;;
    *) return 1 ;;
  esac
}

yaml_unquote() {
  local value="$1"
  value="${value#\"}"
  value="${value%\"}"
  value="${value#\'}"
  value="${value%\'}"
  printf '%s' "$value"
}

yaml_quote() {
  local value="$1"
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  printf '"%s"' "$value"
}

init_count_vars() {
  converted_forgeagent=0
  skipped_forgeagent=0
}

inc_converted() {
  converted_forgeagent=$((converted_forgeagent + 1))
}

inc_skipped() {
  skipped_forgeagent=$((skipped_forgeagent + 1))
}

get_converted() {
  echo "$converted_forgeagent"
}

get_skipped() {
  echo "$skipped_forgeagent"
}

extract_frontmatter() {
  local file="$1"
  awk '
    BEGIN { in_fm = 0; name = ""; desc = ""; in_desc_block = 0 }
    function trim(s) { sub(/^[[:space:]]+/, "", s); sub(/[[:space:]]+$/, "", s); return s }
    function dequote(s, first, last) {
      s = trim(s); first = substr(s, 1, 1); last = substr(s, length(s), 1)
      if ((first == "\"" && last == "\"") || (first == "\047" && last == "\047")) {
        s = substr(s, 2, length(s) - 2)
        if (first == "\"") { gsub(/\\\\/, "\\", s); gsub(/\\"/, "\"", s) } else { gsub(/\047\047/, "\047", s) }
      }
      return s
    }
    function append_desc(chunk) {
      chunk = trim(chunk); if (chunk == "") return
      if (desc == "") desc = chunk; else desc = desc " " chunk
    }
    NR == 1 {
      if ($0 == "---") { in_fm = 1; next }
      if ($0 ~ /^# /) {
          name = $0; sub(/^# /, "", name);
          desc = "Documentation and rules for " name;
          exit;
      }
    }
    in_fm == 1 {
      if ($0 == "---") { in_fm = 0; next }
      if (in_desc_block == 1) {
        if ($0 ~ /^[[:space:]]+/ || $0 == "") {
          line = $0; sub(/^[[:space:]]+/, "", line)
          append_desc(line)
          next
        }
        in_desc_block = 0
      }
      if ($0 ~ /^name:[[:space:]]*/) { line = $0; sub(/^name:[[:space:]]*/, "", line); name = dequote(line); next }
      if ($0 ~ /^description:[[:space:]]*/) {
        line = $0; sub(/^description:[[:space:]]*/, "", line); line = trim(line)
        if (line ~ /^>[+-]?$/ || line ~ /^\|[+-]?$/) { in_desc_block = 1; next }
        desc = dequote(line); next
      }
    }
    END { printf "%s\t%s\n", trim(name), trim(desc) }
  ' "$file"
}

extract_body() {
  local file="$1"
  awk '
    BEGIN { in_fm = 0 }
    NR == 1 { if ($0 == "---") { in_fm = 1; next }; print; next }
    in_fm == 1 { if ($0 == "---") { in_fm = 0; next }; next }
    { print }
  ' "$file" | sed '/^© 202/d' | sed '/^---/d' | tr -d '\000-\011\013\014\016-\037\177-\377'
}

copy_supporting_dirs() {
  local src_dir="$1"; local dst_dir="$2"; local d
  for d in scripts references templates; do
    if [[ -d "${src_dir}/${d}" ]]; then cp -R "${src_dir}/${d}" "${dst_dir}/${d}"; fi
  done
}

tool_title() {
  echo "Forge Agent"
}

write_tool_readme() {
  local tool="$1"; local count="$2"; local out_dir="${OUT_BASE}/${tool}"
  local format_line='Native Markdown assets.'
  local manual_install='Copy assets to the required tool directory.'
  local script_install="./scripts/install.sh --tool ${tool}"
  {
    printf '# %s Integration\n\n' "$(tool_title "$tool")"
    printf 'This directory contains converted Forge Anything assets for **%s**.\n\n' "$(tool_title "$tool")"
    printf '## Included Assets\n\n- **%s** assets.\n\n' "$count"
    printf '## Format\n\n%s\n\n## Install\n\n```bash\n%s\n```\n' "$format_line" "$script_install"
  } > "${out_dir}/README.md"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool) TOOL="${2:-}"; shift 2 ;;
    --out) OUT_BASE="${2:-}"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) err "Unknown argument: $1"; usage; exit 1 ;;
  esac
done

if ! is_valid_tool "$TOOL"; then err "Invalid --tool: ${TOOL}"; usage; exit 1; fi

TOOLS="forge-agent"

SKILLS_TMP="$(mktemp)"
( cd "$REPO_ROOT"
  for d in agents commands; do
    if [ -d "$d" ]; then
      find "$d" -maxdepth 1 -type f -name "*.md" -not -path './.git/*' | sort
    fi
  done
  if [ -d "skills" ]; then
    find "skills" -type f -name 'SKILL.md' -not -path '*/assets/*' -not -path '*/scripts/*' -not -path '*/references/*' -not -path './.git/*' | sort
  fi
) | sort -u > "$SKILLS_TMP"

for t in $TOOLS; do
  rm -rf "${OUT_BASE}/${t}"; mkdir -p "${OUT_BASE}/${t}/skills"
done

init_count_vars

while IFS= read -r rel_path; do
  # Skip plugin manifests
  [[ "$rel_path" =~ plugin.json$ ]] && continue

  src="${REPO_ROOT}/${rel_path#./}"; src_dir="$(dirname "$src")"

  meta="$(extract_frontmatter "$src")"; name="${meta%%$'\t'*}"; description="${meta#*$'\t'}"
  name="$(yaml_unquote "$name")"; description="$(yaml_unquote "$description")"

  if [[ -z "$name" ]]; then
    [[ "$(basename "$src")" == "SKILL.md" ]] && name=$(basename "$src_dir") || name=$(basename "$src" .md)
  fi

  if [[ -z "$name" || -z "$description" ]]; then
    for t in $TOOLS; do inc_skipped "$t"; done
    continue
  fi

  # SAFE FILENAME GENERATION
  safe_name=$(echo "$name" | sed 's/[^a-zA-Z0-9_ -]//g' | tr ' ' '-')
  body_tmp="$(mktemp)"; extract_body "$src" > "$body_tmp"

  for t in $TOOLS; do
    out_dir="${OUT_BASE}/${t}/skills/${safe_name}"; mkdir -p "$out_dir"
    { echo "---"; echo "name: $(yaml_quote "$name")"; echo "description: $(yaml_quote "$description")"; echo "---"; cat "$body_tmp"; } > "${out_dir}/SKILL.md"
    copy_supporting_dirs "$src_dir" "$out_dir"
    inc_converted "$t"
  done
  rm -f "$body_tmp"
done < "$SKILLS_TMP"

rm -f "$SKILLS_TMP"

for t in $TOOLS; do write_tool_readme "$t" "$(get_converted "$t")"; done

echo; info "Conversion summary"
for t in $TOOLS; do echo "  ${t}: $(get_converted "$t") converted, $(get_skipped "$t") skipped"; done
echo; ok "Done"
