#!/usr/bin/env bash
# Copilot CLI sessionStart hook tests for Forge Anything.
#
# Copilot CLI loads repo-scoped hooks from .github/hooks/*.json (official
# GitHub Copilot hooks reference: sessionStart fires when a new or resumed
# session begins, and its stdout may inject additionalContext into the
# session). This test validates the hook config shipped in this repo and
# simulates Copilot running the shared hooks/session-start script the way
# Copilot would: from the repo root, with no Claude/Cursor plugin env vars
# set, so the script emits its top-level additionalContext shape.
#
# Windows note: the powershell key invokes bash, which needs Git for Windows
# bash on PATH. That matches the repo's existing Windows dispatch
# (hooks/run-hook.cmd finds Git for Windows bash); a native PowerShell
# script is not shipped.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG="$REPO_ROOT/.github/hooks/forge-anything.json"
HOOK_UNDER_TEST="$REPO_ROOT/hooks/session-start"

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

echo "Copilot CLI sessionStart hook tests"

# --- Config shape -----------------------------------------------------------
if ! node -e '
const fs = require("fs");
const config = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
function fail(message) { console.error(message); process.exit(1); }
if (config.version !== 1) fail("version must be 1, got " + JSON.stringify(config.version));
const hooks = config.hooks;
if (!hooks || typeof hooks !== "object") fail("missing hooks object");
const sessionStart = hooks.sessionStart;
if (!Array.isArray(sessionStart) || sessionStart.length !== 1) fail("sessionStart must be an array with exactly one entry");
const entry = sessionStart[0];
if (entry.type !== "command") fail("entry type must be command, got " + JSON.stringify(entry.type));
if (typeof entry.bash !== "string" || !entry.bash.includes("hooks/session-start")) fail("bash must invoke hooks/session-start, got " + JSON.stringify(entry.bash));
if (typeof entry.powershell !== "string" || !entry.powershell.includes("hooks/session-start")) fail("powershell must invoke hooks/session-start, got " + JSON.stringify(entry.powershell));
if (entry.cwd !== ".") fail("cwd must be \".\" (repo root), got " + JSON.stringify(entry.cwd));
if (typeof entry.timeoutSec !== "number" || entry.timeoutSec <= 0) fail("timeoutSec must be a positive number");
' "$CONFIG"; then
    fail "hook config .github/hooks/forge-anything.json is not a valid Copilot sessionStart config"
else
    pass "hook config is a valid Copilot sessionStart config"
fi

# The config must point at the script that actually exists.
if [[ -x "$HOOK_UNDER_TEST" || -f "$HOOK_UNDER_TEST" ]]; then
    pass "hook config target hooks/session-start exists"
else
    fail "hook config target hooks/session-start does not exist"
fi

# --- Script output the way Copilot runs it ---------------------------------
# Copilot runs the hook command with cwd = repo root and no Claude/Cursor
# plugin env vars. The script must emit {"additionalContext": "<bootstrap>"}.
assert_copilot_output() {
    local description="$1"
    local home="$2"
    shift 2

    local output
    if ! output="$(cd "$REPO_ROOT" && env -i PATH="${PATH:-}" HOME="$home" "$@" bash "$HOOK_UNDER_TEST" 2>&1)"; then
        fail "$description"
        echo "    hook exited non-zero"
        echo "$output" | sed 's/^/      /'
        return
    fi

    if printf '%s' "$output" | node -e '
const fs = require("fs");
const input = fs.readFileSync(0, "utf8");
let payload;
try {
  payload = JSON.parse(input);
} catch (error) {
  console.error(`invalid JSON: ${error.message}`);
  process.exit(1);
}
function fail(message) { console.error(message); process.exit(1); }
if (Object.prototype.hasOwnProperty.call(payload, "hookSpecificOutput")) fail("output included hookSpecificOutput (Claude shape)");
if (Object.prototype.hasOwnProperty.call(payload, "additional_context")) fail("output included additional_context (Cursor shape)");
if (!Object.prototype.hasOwnProperty.call(payload, "additionalContext")) fail("output missing additionalContext");
const context = payload.additionalContext;
if (typeof context !== "string" || context.trim() === "") fail("injected context was empty");
if (!context.includes("You have forge-anything.")) fail("context did not contain the bootstrap marker");
'; then
        pass "$description"
    else
        fail "$description"
        echo "    output:"
        echo "$output" | sed 's/^/      /'
    fi
}

copilot_home="$TEST_ROOT/copilot/home"
mkdir -p "$copilot_home"
assert_copilot_output \
    "plain invocation from repo root emits Copilot additionalContext" \
    "$copilot_home"

copilot_env_home="$TEST_ROOT/copilot-env/home"
mkdir -p "$copilot_env_home"
assert_copilot_output \
    "invocation with COPILOT_CLI set emits the same Copilot shape" \
    "$copilot_env_home" \
    COPILOT_CLI=1

if [[ "$FAILURES" -gt 0 ]]; then
    echo "STATUS: FAILED ($FAILURES failure(s))"
    exit 1
fi

echo "STATUS: PASSED"
