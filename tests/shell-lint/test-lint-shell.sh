#!/usr/bin/env bash
# Lints every shell script in this repo with shellcheck.
#
# Adapted from superpowers' tests/shell-lint/test-lint-shell.sh, which tested
# a scripts/lint-shell.sh wrapper that this repo does not have. Instead this
# test lints the .sh files directly (scripts/*.sh, tests/**/*.sh) plus the
# extensionless hooks/session-start, which carries a bash shebang.
#
# hooks/run-hook.cmd is excluded: it is a cmd.exe/bash polyglot, not pure
# shell, so shellcheck cannot parse it.
#
# shellcheck is not installed on every machine. When it is missing the test
# skips gracefully (exit 0) and says so, rather than failing.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

if ! command -v shellcheck >/dev/null 2>&1; then
  echo "SKIP: shellcheck not installed (lint scripts/*.sh, tests/**/*.sh and hooks/session-start with shellcheck when it is available)"
  exit 0
fi

FAILURES=0

# Collect .sh files plus the extensionless bash hook.
mapfile -t files < <(
  find "$REPO_ROOT/scripts" "$REPO_ROOT/tests" -name '*.sh' -type f 2>/dev/null
  printf '%s\n' "$REPO_ROOT/hooks/session-start"
)

for file in "${files[@]}"; do
  if shellcheck --severity=warning --external-sources --source-path=SCRIPTDIR "$file"; then
    echo "  [PASS] ${file#"$REPO_ROOT"/}"
  else
    echo "  [FAIL] ${file#"$REPO_ROOT"/}"
    FAILURES=$((FAILURES + 1))
  fi
done

if [[ "$FAILURES" -gt 0 ]]; then
  echo "STATUS: FAILED ($FAILURES file(s) with shellcheck warnings)"
  exit 1
fi

echo "STATUS: PASSED (${#files[@]} shell files clean)"
