#!/usr/bin/env bash
# Antigravity SessionStart hook tests for Forge Anything.
#
# Antigravity loads a plugin's hooks.json from the plugin root (the repo root
# here) and runs the SessionStart command with cwd = plugin root. The output
# contract is {"injectSteps": [{"systemMessage": {"systemMessage": "..."}}]}.
# A systemMessage.metadata field panics in agy and drops the whole hook
# output, so the output must not contain metadata.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG="$REPO_ROOT/hooks.json"
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

echo "Antigravity SessionStart hook tests"

# --- Config shape -----------------------------------------------------------
if ! node -e '
const fs = require("fs");
const config = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
function fail(message) { console.error(message); process.exit(1); }
const hook = config["forge-anything-session-start"];
if (!hook || typeof hook !== "object") fail("missing forge-anything-session-start hook");
const sessionStart = hook.SessionStart;
if (!Array.isArray(sessionStart) || sessionStart.length !== 1) fail("SessionStart must be an array with exactly one entry");
const handler = sessionStart[0];
if (handler.type !== "command") fail("handler type must be command, got " + JSON.stringify(handler.type));
if (handler.command !== "bash hooks/session-start antigravity") fail("command must be \"bash hooks/session-start antigravity\", got " + JSON.stringify(handler.command));
if (typeof handler.timeout !== "number" || handler.timeout <= 0) fail("timeout must be a positive number");
' "$CONFIG"; then
    fail "hook config hooks.json is not a valid Antigravity SessionStart config"
else
    pass "hook config is a valid Antigravity SessionStart config"
fi

# --- Script output the way Antigravity runs it ------------------------------
# Antigravity sends a JSON payload on stdin and runs the command with cwd =
# plugin root (repo root). The script ignores stdin and resolves the bootstrap
# from its own path, so feed it a realistic SessionStart payload.
payload='{"conversationId":"00000000-0000-0000-0000-000000000000","workspacePaths":["'"$REPO_ROOT"'"],"transcriptPath":"/tmp/transcript.jsonl","artifactDirectoryPath":"/tmp/artifacts","modelName":"gemini-test"}'

output="$(cd "$REPO_ROOT" && printf '%s' "$payload" | env -i PATH="${PATH:-}" HOME="$TEST_ROOT" bash "$HOOK_UNDER_TEST" antigravity 2>&1)"
status=$?
if [[ "$status" -ne 0 ]]; then
    fail "session-start antigravity exited non-zero ($status)"
    echo "$output" | sed 's/^/      /'
else
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
const steps = payload.injectSteps;
if (!Array.isArray(steps) || steps.length !== 1) fail("injectSteps must be an array with exactly one step");
const step = steps[0];
if (!step.systemMessage || typeof step.systemMessage.systemMessage !== "string") fail("step must carry systemMessage.systemMessage");
const text = step.systemMessage.systemMessage;
if (text.trim() === "") fail("injected systemMessage was empty");
if (!text.includes("You have forge-anything.")) fail("systemMessage did not contain the bootstrap marker");
if (Object.prototype.hasOwnProperty.call(step.systemMessage, "metadata")) fail("systemMessage included metadata, which panics in agy");
'; then
        pass "antigravity mode emits injectSteps systemMessage with the bootstrap, no metadata"
    else
        fail "antigravity mode output failed validation"
        echo "    output:"
        echo "$output" | sed 's/^/      /'
    fi
fi

if [[ "$FAILURES" -gt 0 ]]; then
    echo "STATUS: FAILED ($FAILURES failure(s))"
    exit 1
fi

echo "STATUS: PASSED"
