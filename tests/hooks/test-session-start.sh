#!/usr/bin/env bash
# SessionStart hook output tests for Forge Anything.
#
# Adapted from superpowers' tests/hooks/test-session-start.sh. This is a
# reduced version that tests what our hooks actually do: the three output
# shapes (Claude Code nested, Cursor top-level snake_case, Copilot CLI
# top-level camelCase), the run-hook.cmd wrapper dispatch, and bare-filename
# invocation from inside hooks/.
#
# Checks from the superpowers version that are DROPPED here, and why:
# - hooks.json shell:"bash" + powershell key: our hooks.json declares neither.
#   Adding them is a hook change (Windows dispatch fix), not a test port.
#   See the superpowers test for the rationale (#2189).
# - Legacy custom-skill warning removed: our session-start still emits the
#   ~/.config/skills warning by design.
# - Empty PATH still works: our session-start shells out to dirname and cat,
#   so an empty PATH breaks it. Making it builtins-only is a hook rewrite.
# - No-bash/zsh fallback and backslash-path dispatch: our run-hook.cmd Unix
#   half requires bash and does not handle backslash paths.
# - EPIPE (stdout closed early): our hook dies with SIGPIPE (rc 141) instead
#   of exiting 0 silently. Fixing it is a hook change.
# - Zero forks via strace: our hook forks (dirname, cat) on every startup.
#   Making it fork-free is a hook rewrite.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
HOOK_UNDER_TEST="$REPO_ROOT/hooks/session-start"
WRAPPER_UNDER_TEST="$REPO_ROOT/hooks/run-hook.cmd"

FAILURES=0
TEST_ROOT="$(mktemp -d)"

cleanup() {
    rm -rf "$TEST_ROOT"
}
trap cleanup EXIT

pass() {
    echo "  [PASS] $1"
}

fail() {
    echo "  [FAIL] $1"
    FAILURES=$((FAILURES + 1))
}

make_home() {
    local name="$1"
    local home="$TEST_ROOT/$name/home"
    mkdir -p "$home"
    printf '%s\n' "$home"
}

assert_command_output() {
    local description="$1"
    local shape="$2"
    local contains="$3"
    local not_contains="$4"
    local home="$5"
    shift 5

    local output
    if ! output="$(env -i PATH="${PATH:-}" HOME="$home" "$@" 2>&1)"; then
        fail "$description"
        echo "    hook exited non-zero"
        echo "$output" | sed 's/^/      /'
        return
    fi

    if printf '%s' "$output" | \
        EXPECT_SHAPE="$shape" \
        EXPECT_CONTAINS="$contains" \
        EXPECT_NOT_CONTAINS="$not_contains" \
        node -e '
const fs = require("fs");

const input = fs.readFileSync(0, "utf8");
let payload;
try {
  payload = JSON.parse(input);
} catch (error) {
  console.error(`invalid JSON: ${error.message}`);
  process.exit(1);
}

function hasOwn(object, key) {
  return Object.prototype.hasOwnProperty.call(object, key);
}

function fail(message) {
  console.error(message);
  process.exit(1);
}

const shape = process.env.EXPECT_SHAPE;
let context;

if (shape === "nested") {
  if (!hasOwn(payload, "hookSpecificOutput")) {
    fail("missing hookSpecificOutput");
  }
  if (hasOwn(payload, "additional_context") || hasOwn(payload, "additionalContext")) {
    fail("nested output also included a top-level context field");
  }
  const hookOutput = payload.hookSpecificOutput;
  if (!hookOutput || typeof hookOutput !== "object" || Array.isArray(hookOutput)) {
    fail("hookSpecificOutput is not an object");
  }
  if (hookOutput.hookEventName !== "SessionStart") {
    fail(`unexpected hookEventName: ${hookOutput.hookEventName}`);
  }
  context = hookOutput.additionalContext;
} else if (shape === "cursor") {
  if (hasOwn(payload, "hookSpecificOutput")) {
    fail("cursor output included hookSpecificOutput");
  }
  if (!hasOwn(payload, "additional_context")) {
    fail("cursor output missing additional_context");
  }
  if (hasOwn(payload, "additionalContext")) {
    fail("cursor output included additionalContext");
  }
  context = payload.additional_context;
} else if (shape === "sdk") {
  if (hasOwn(payload, "hookSpecificOutput")) {
    fail("sdk output included hookSpecificOutput");
  }
  if (!hasOwn(payload, "additionalContext")) {
    fail("sdk output missing additionalContext");
  }
  if (hasOwn(payload, "additional_context")) {
    fail("sdk output included additional_context");
  }
  context = payload.additionalContext;
} else {
  fail(`unknown expected shape: ${shape}`);
}

if (typeof context !== "string" || context.trim() === "") {
  fail("injected context was empty");
}

const expectedText = process.env.EXPECT_CONTAINS || "";
if (expectedText && !context.includes(expectedText)) {
  fail(`context did not contain expected text: ${expectedText}`);
}

const forbiddenTexts = (process.env.EXPECT_NOT_CONTAINS || "")
  .split("\u001f")
  .filter(Boolean);
for (const forbiddenText of forbiddenTexts) {
  if (context.includes(forbiddenText)) {
    fail(`context contained forbidden text: ${forbiddenText}`);
  }
}
'; then
        pass "$description"
    else
        fail "$description"
        echo "    output:"
        echo "$output" | sed 's/^/      /'
    fi
}

echo "SessionStart hook output tests"

claude_home="$(make_home claude-code)"
assert_command_output \
    "Claude Code emits nested SessionStart additionalContext" \
    "nested" \
    "You have forge-anything." \
    "" \
    "$claude_home" \
    CLAUDE_PLUGIN_ROOT="$REPO_ROOT" \
    bash "$HOOK_UNDER_TEST"

wrapper_home="$(make_home run-hook-wrapper)"
assert_command_output \
    "run-hook.cmd wrapper dispatches to the named session-start script" \
    "nested" \
    "You have forge-anything." \
    "" \
    "$wrapper_home" \
    CLAUDE_PLUGIN_ROOT="$REPO_ROOT" \
    bash "$WRAPPER_UNDER_TEST" session-start

cursor_home="$(make_home cursor)"
assert_command_output \
    "Cursor emits top-level additional_context only" \
    "cursor" \
    "You have forge-anything." \
    "" \
    "$cursor_home" \
    CURSOR_PLUGIN_ROOT="$REPO_ROOT" \
    CLAUDE_PLUGIN_ROOT="$REPO_ROOT" \
    bash "$HOOK_UNDER_TEST"

copilot_home="$(make_home copilot-cli)"
assert_command_output \
    "Copilot CLI emits top-level additionalContext only" \
    "sdk" \
    "You have forge-anything." \
    "" \
    "$copilot_home" \
    COPILOT_CLI=1 \
    CLAUDE_PLUGIN_ROOT="$REPO_ROOT" \
    bash "$HOOK_UNDER_TEST"

# Run by bare filename from inside hooks/ ($0 has no slash), the plugin root
# must still resolve.
bash_bin="$(command -v bash)"

bare_name_home="$(make_home bare-name)"
assert_command_output \
    "session-start run by bare filename from hooks/ still emits nested additionalContext" \
    "nested" \
    "You have forge-anything." \
    "" \
    "$bare_name_home" \
    CLAUDE_PLUGIN_ROOT="$REPO_ROOT" \
    "$bash_bin" -c 'cd "$1" && exec "$2" session-start' _ "$REPO_ROOT/hooks" "$bash_bin"

bare_name_wrapper_home="$(make_home bare-name-wrapper)"
assert_command_output \
    "run-hook.cmd run by bare filename from hooks/ still dispatches session-start" \
    "nested" \
    "You have forge-anything." \
    "" \
    "$bare_name_wrapper_home" \
    CLAUDE_PLUGIN_ROOT="$REPO_ROOT" \
    "$bash_bin" -c 'cd "$1" && exec "$2" run-hook.cmd session-start' _ "$REPO_ROOT/hooks" "$bash_bin"

if [[ "$FAILURES" -gt 0 ]]; then
    echo "STATUS: FAILED ($FAILURES failure(s))"
    exit 1
fi

echo "STATUS: PASSED"
