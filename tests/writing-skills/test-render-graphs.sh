#!/usr/bin/env bash
# Tests for skills/writing-skills/render-graphs.py.
#
# Adapted from superpowers' tests/writing-skills/test-render-graphs.sh. The
# missing-Graphviz case runs on every machine; the render case needs the
# `dot` binary, so when Graphviz is not installed the render assertions are
# skipped gracefully instead of failing (the render itself is not broken, the
# binary to exercise it is absent).
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SCRIPT_UNDER_TEST="$REPO_ROOT/skills/writing-skills/render-graphs.py"
# Resolve the real binary: the empty PATH used for the missing-Graphviz case
# must not hide the interpreter itself.
PYTHON_BIN="$(command -v python3)"

PASSES=0
FAILURES=0
TEST_ROOT="$(mktemp -d)"

cleanup() {
  rm -rf "$TEST_ROOT"
}
trap cleanup EXIT

pass() {
  echo "  [PASS] $1"
  PASSES=$((PASSES + 1))
}

fail() {
  echo "  [FAIL] $1"
  FAILURES=$((FAILURES + 1))
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local description="$3"

  if printf '%s' "$haystack" | grep -Fq -- "$needle"; then
    pass "$description"
  else
    fail "$description"
    echo "    expected to find: $needle"
  fi
}

assert_not_contains() {
  local haystack="$1"
  local needle="$2"
  local description="$3"

  if printf '%s' "$haystack" | grep -Fq -- "$needle"; then
    fail "$description"
    echo "    did not expect to find: $needle"
  else
    pass "$description"
  fi
}

fixture="$TEST_ROOT/fixture-skill"
mkdir -p "$fixture" "$TEST_ROOT/empty-path"
cat >"$fixture/SKILL.md" <<'EOF'
---
name: fixture-skill
---

# Fixture Skill

```dot
digraph fixture_graph {
  start -> end;
}
```
EOF

echo "Writing-skills render-graphs tests"

missing_dot_output="$(PATH="$TEST_ROOT/empty-path" "$PYTHON_BIN" "$SCRIPT_UNDER_TEST" "$fixture" 2>&1)"
missing_dot_status=$?

if [[ "$missing_dot_status" -ne 0 ]]; then
  pass "missing Graphviz exits non-zero"
else
  fail "missing Graphviz exits non-zero"
fi
assert_contains "$missing_dot_output" "Error: graphviz (dot) not found." "missing Graphviz reports install guidance"
assert_not_contains "$missing_dot_output" "Traceback" "script fails cleanly without a Python traceback"

# The render case needs the dot binary. Without Graphviz the render itself
# is not broken, only untestable here, so skip it instead of failing.
if ! command -v dot >/dev/null 2>&1; then
  echo "  [SKIP] fixture diagram renders: graphviz (dot) not installed"
  echo "  [SKIP] writes SVG output: graphviz (dot) not installed"
  echo "  [SKIP] SVG output has SVG markup: graphviz (dot) not installed"
else
  render_output="$("$PYTHON_BIN" "$SCRIPT_UNDER_TEST" "$fixture" 2>&1)"
  render_status=$?

  if [[ "$render_status" -eq 0 ]]; then
    pass "fixture diagram renders"
  else
    fail "fixture diagram renders"
    printf '%s\n' "$render_output"
  fi

  assert_contains "$render_output" "Found 1 diagram(s)" "reports discovered diagram"
  assert_contains "$render_output" "Rendered: fixture_graph.svg" "reports rendered SVG"

  if [[ -f "$fixture/diagrams/fixture_graph.svg" ]]; then
    pass "writes SVG output"
  else
    fail "writes SVG output"
  fi

  if [[ -f "$fixture/diagrams/fixture_graph.svg" ]] && grep -Fq "<svg" "$fixture/diagrams/fixture_graph.svg"; then
    pass "SVG output has SVG markup"
  else
    fail "SVG output has SVG markup"
  fi
fi

echo
echo "Results: $PASSES passed, $FAILURES failed"

if [[ "$FAILURES" -gt 0 ]]; then
  exit 1
fi
