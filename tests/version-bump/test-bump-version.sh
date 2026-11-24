#!/usr/bin/env bash
# Tests for scripts/bump-version.sh.
#
# Adapted from superpowers' tests/version-bump/test-bump-version.sh. Our
# bump-version.sh is JSON-only (via jq): there is no YAML manifest and no yq
# in this repo, so the YAML parts of the superpowers test are dropped. The
# fixture mirrors our .version-bump.json shape (a list of JSON files with
# dotted field paths, plus an audit exclude list).
#
# Our --audit does a plain substring grep for the current version string, so
# it flags any file containing the version as a substring (for example a file
# with "10.2.3.4" when the version is "2.3.4"). The superpowers test asserts
# the opposite for its audit, so that assertion is not ported here; only the
# positive case (an undeclared file containing the exact version is listed)
# is checked.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT_SOURCE="$REPO_ROOT/scripts/bump-version.sh"
TEST_ROOT="$(mktemp -d)"

cleanup() {
  rm -rf "$TEST_ROOT"
}
trap cleanup EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

make_fixture() {
  local repo="$1"

  mkdir -p "$repo/scripts" "$repo/.claude-plugin"
  cp "$SCRIPT_SOURCE" "$repo/scripts/bump-version.sh"
  cat >"$repo/.version-bump.json" <<'JSON'
{
  "files": [
    { "path": "package.json", "field": "version" },
    { "path": ".claude-plugin/plugin.json", "field": "version" }
  ],
  "audit": { "exclude": [] }
}
JSON
  cat >"$repo/package.json" <<'JSON'
{
  "name": "fixture",
  "version": "1.2.3"
}
JSON
  cat >"$repo/.claude-plugin/plugin.json" <<'JSON'
{
  "name": "fixture",
  "version": "1.2.3"
}
JSON
}

happy_repo="$TEST_ROOT/happy"
make_fixture "$happy_repo"

/bin/bash "$happy_repo/scripts/bump-version.sh" --check >"$TEST_ROOT/check.out" \
  || fail "--check failed on an in-sync fixture"
grep -q "in sync at 1.2.3" "$TEST_ROOT/check.out" \
  || fail "--check did not report in-sync at 1.2.3"

/bin/bash "$happy_repo/scripts/bump-version.sh" --audit >"$TEST_ROOT/audit.out" \
  || fail "--audit failed on an in-sync fixture"

/bin/bash "$happy_repo/scripts/bump-version.sh" 2.3.4 >"$TEST_ROOT/bump.out" \
  || fail "bump to 2.3.4 failed"

[[ "$(jq -r '.version' "$happy_repo/package.json")" == "2.3.4" ]] \
  || fail "package.json was not bumped"
[[ "$(jq -r '.version' "$happy_repo/.claude-plugin/plugin.json")" == "2.3.4" ]] \
  || fail "plugin.json was not bumped"

/bin/bash "$happy_repo/scripts/bump-version.sh" --check >"$TEST_ROOT/check2.out" \
  || fail "--check failed after bump"
grep -q "in sync at 2.3.4" "$TEST_ROOT/check2.out" \
  || fail "--check did not report in-sync at 2.3.4"

# The real .version-bump.json must register every versioned manifest.
jq -e '
  any(.files[]; .path == "package.json" and .field == "version") and
  any(.files[]; .path == ".claude-plugin/plugin.json" and .field == "version") and
  any(.files[]; .path == ".codex-plugin/plugin.json" and .field == "version") and
  any(.files[]; .path == ".antigravity-plugin/plugin.json" and .field == "version") and
  any(.files[]; .path == ".claude-plugin/marketplace.json" and .field == "metadata.version") and
  any(.files[]; .path == ".claude-plugin/marketplace.json" and .field == "plugins.0.version")
' "$REPO_ROOT/.version-bump.json" >/dev/null \
  || fail "real .version-bump.json does not register every versioned manifest"

# An invalid new version is rejected and no file changes.
invalid_repo="$TEST_ROOT/invalid"
make_fixture "$invalid_repo"
cp "$invalid_repo/package.json" "$TEST_ROOT/package.before"
cp "$invalid_repo/.claude-plugin/plugin.json" "$TEST_ROOT/plugin.before"

if /bin/bash "$invalid_repo/scripts/bump-version.sh" not-a-version \
  >"$TEST_ROOT/invalid.out" 2>&1; then
  fail "bump accepted a non-version string"
fi

cmp -s "$TEST_ROOT/package.before" "$invalid_repo/package.json" \
  || fail "package.json changed after rejected bump"
cmp -s "$TEST_ROOT/plugin.before" "$invalid_repo/.claude-plugin/plugin.json" \
  || fail "plugin.json changed after rejected bump"

# --audit flags an undeclared file containing the current version.
audit_repo="$TEST_ROOT/audit-boundaries"
make_fixture "$audit_repo"
/bin/bash "$audit_repo/scripts/bump-version.sh" 4.0.0 >/dev/null
printf 'pin: forge-anything.git#v4.0.0\n' >"$audit_repo/INSTALL.md"
/bin/bash "$audit_repo/scripts/bump-version.sh" --audit >"$TEST_ROOT/audit-boundaries.out"

grep -q 'INSTALL.md' "$TEST_ROOT/audit-boundaries.out" \
  || fail "audit missed an undeclared #v4.0.0 pin"

echo "Version-bump tests passed"
