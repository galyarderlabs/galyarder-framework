# Testing Forge Anything

This document describes how Forge Anything is tested: the test gates that guard the repo, and the skill tests that run real Claude Code sessions.

## The test gates

Three gates guard the repo. A change should pass all three before it is called done.

### 1. Smoke test: `scripts/smoke.sh`

The audit-grade smoke test. Run it from the repo root:

```bash
bash scripts/smoke.sh
```

It runs 8 checks:

1. Runtime integrity: the canonical `agents/`, `skills/`, and `commands/` directories and the root `AGENTS.md` are present.
2. CLI accessibility: the `forge` binary is reachable in PATH.
3. Workspace maturity: the department structure exists in a scaffolded project.
4. Manifest parity: the plugin manifests agree with the canonical runtime.
5. Monolith-free boot: no monolithic CONVENTIONS artifacts in the runtime surface.
6. Lazy graph lookup: graph and World-Map access stays lazy, never mandatory for normal execution.
7. Broken symlinks: no broken symlinks in the runtime.
8. Marketplace manifest: the canonical marketplace manifest points at the root runtime.

In a scaffolded target project the same script runs the 4 project checks instead. `forge smoke` runs the same test through the CLI.

### 2. Rust tests: `cargo test`

The Rust workspace (`crates/forge` and `crates/forge-scaffold`) has unit tests and end-to-end acceptance tests:

```bash
cargo test --locked
```

Formatting and linting are part of the same gate:

```bash
cargo fmt --check
cargo clippy --all-targets -- -D warnings
```

### 3. CI

Three workflows run on pull requests (see `.github/workflows/`):

- `smoke-test.yml`: runs `bash scripts/smoke.sh` and checks plugin manifest versions.
- `rust.yml`: installs Rust 1.85, checks formatting, runs clippy with warnings as errors, builds, runs `cargo test`, then builds the scaffold and the CLI in release mode and verifies them end to end (`forge help` / `forge version`, scaffold through the CLI, smoke through the CLI).
- `repo-hygiene.yml`: checks that every tracked path is Windows-safe, plus the other hygiene checks.

## Skill tests: `tests/claude-code/`

The skill tests verify that skills load correctly and Claude follows them as expected. They invoke Claude Code in headless mode (`claude -p`) and verify the behavior.

### Test structure

```
tests/
  claude-code/
    run-skill-tests.sh                     # Test runner
    test-helpers.sh                        # Shared test utilities
    test-subagent-driven-development.sh
    test-subagent-driven-development-integration.sh
    test-document-review-system.sh
    analyze-token-usage.py                 # Token analysis tool
```

### Running tests

```bash
cd tests/claude-code

# Run all fast tests (recommended)
./run-skill-tests.sh

# Run integration tests (slow, 10-30 minutes)
./run-skill-tests.sh --integration

# Run a specific test
./run-skill-tests.sh --test test-subagent-driven-development.sh

# Verbose output
./run-skill-tests.sh --verbose

# Custom timeout (30 minutes for integration tests)
./run-skill-tests.sh --timeout 1800
```

### Requirements

- Claude Code must be installed and available as the `claude` command.
- Tests must run from the **forge-anything plugin directory** (not from temp directories), so the skills load.
- The local dev marketplace must be enabled: `"forge-anything@forge-anything-marketplace": true` in `~/.claude/settings.json`.

### Integration test: subagent-driven-development

The integration test verifies the `subagent-driven-development` skill correctly:

1. **Plan Loading**: reads the plan once at the beginning.
2. **Full Task Text**: provides complete task descriptions to subagents (does not make them read files).
3. **Self-Review**: ensures subagents perform self-review before reporting.
4. **Review Order**: runs spec compliance review before code quality review.
5. **Review Loops**: uses review loops when issues are found.
6. **Independent Verification**: the spec reviewer reads code independently and does not trust implementer reports.

How it works:

1. **Setup**: creates a temporary Node.js project with a minimal implementation plan, under a workspace path such as `~/workspace/forge-anything-test/`.
2. **Execution**: runs Claude Code in headless mode with the skill.
3. **Verification**: parses the session transcript (`.jsonl` file) to verify the skill tool was invoked, subagents were dispatched (Task tool), TodoWrite was used for tracking, implementation files were created, tests pass, and git commits show proper workflow.
4. **Token Analysis**: shows token usage breakdown by subagent.

Example output (abridged):

```
========================================
 Integration Test: subagent-driven-development
========================================

Test project: ~/workspace/forge-anything-test/proj.xyz123

=== Verification Tests ===

Test 1: Skill tool invoked...
  [PASS] subagent-driven-development skill was invoked

Test 2: Subagents dispatched...
  [PASS] subagents dispatched

Test 3: Task tracking...
  [PASS] TodoWrite used

Test 6: Implementation verification...
  [PASS] src/math.js created
  [PASS] add function exists
  [PASS] multiply function exists
  [PASS] test/math.test.js created
  [PASS] Tests pass

Test 7: Git commit history...
  [PASS] Multiple commits created

Test 8: No extra features added...
  [PASS] No extra features added

========================================
 Test Summary
========================================

STATUS: PASSED
```

**Note:** Integration tests can take 10-30 minutes as they execute real implementation plans with multiple subagents.

## Token analysis tool

### Usage

Analyze token usage from any Claude Code session:

```bash
python3 tests/claude-code/analyze-token-usage.py ~/.claude/projects/<project-dir>/<session-id>.jsonl
```

### Finding session files

Session transcripts are stored in `~/.claude/projects/` with the working directory path encoded in the directory name:

```bash
# Find recent sessions (last 60 minutes)
find ~/.claude/projects -name "*.jsonl" -mmin -60 | sort -r | head -5
```

### What it shows

- **Main session usage**: token usage by the coordinator (the main Claude instance).
- **Per-subagent breakdown**: each Task invocation with agent ID, description (extracted from the prompt), message count, input/output tokens, cache usage, and estimated cost.
- **Totals**: overall token usage and cost estimate.

### Understanding the output

- **High cache reads**: good, prompt caching is working.
- **High input tokens on main**: expected, the coordinator has full context.
- **Similar costs per subagent**: expected, each gets similar task complexity.
- **Cost per task**: typical range is $0.05-$0.15 per subagent depending on task.

## Troubleshooting

### Skills not loading

**Problem**: skill not found when running headless tests.

**Solutions**:
1. Ensure you are running from the forge-anything directory: `cd /path/to/forge-anything && tests/...`
2. Check `~/.claude/settings.json` has `"forge-anything@forge-anything-marketplace": true` in `enabledPlugins`.
3. Verify the skill exists in the `skills/` directory.

### Permission errors

**Problem**: Claude blocked from writing files or accessing directories.

**Solutions**:
1. Use `--permission-mode bypassPermissions` flag.
2. Use `--add-dir /path/to/test/dir` to grant access to test directories.
3. Check file permissions on test directories.

### Test timeouts

**Problem**: test takes too long and times out.

**Solutions**:
1. Increase timeout: `timeout 1800 claude ...` (30 minutes).
2. Check for infinite loops in skill logic.
3. Review subagent task complexity.

### Session file not found

**Problem**: cannot find the session transcript after a test run.

**Solutions**:
1. Check the correct project directory in `~/.claude/projects/`.
2. Use `find ~/.claude/projects -name "*.jsonl" -mmin -60` to find recent sessions.
3. Verify the test actually ran (check for errors in test output).

## Writing new integration tests

### Template

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

# Create test project under the workspace
TEST_PROJECT=$(create_test_project)
trap "cleanup_test_project $TEST_PROJECT" EXIT

# Set up test files...
cd "$TEST_PROJECT"

# Run Claude with skill
PROMPT="Your test prompt here"
cd "$SCRIPT_DIR/../.." && timeout 1800 claude -p "$PROMPT" \
  --allowed-tools=all \
  --add-dir "$TEST_PROJECT" \
  --permission-mode bypassPermissions \
  2>&1 | tee output.txt

# Find and analyze session
WORKING_DIR_ESCAPED=$(echo "$SCRIPT_DIR/../.." | sed 's/\//-/g' | sed 's/^-//')
SESSION_DIR="$HOME/.claude/projects/$WORKING_DIR_ESCAPED"
SESSION_FILE=$(find "$SESSION_DIR" -name "*.jsonl" -type f -mmin -60 | sort -r | head -1)

# Verify behavior by parsing session transcript
if grep -q '"name":"Skill".*"skill":"your-skill-name"' "$SESSION_FILE"; then
    echo "[PASS] Skill was invoked"
fi

# Show token analysis
python3 "$SCRIPT_DIR/analyze-token-usage.py" "$SESSION_FILE"
```

### Best practices

1. **Always cleanup**: use trap to cleanup temp directories.
2. **Parse transcripts**: do not grep user-facing output, parse the `.jsonl` session file.
3. **Grant permissions**: use `--permission-mode bypassPermissions` and `--add-dir`.
4. **Run from plugin dir**: skills only load when running from the forge-anything directory.
5. **Show token usage**: always include token analysis for cost visibility.
6. **Test real behavior**: verify actual files created, tests passing, commits made.

## Session transcript format

Session transcripts are JSONL (JSON Lines) files where each line is a JSON object representing a message or tool result.

### Key fields

```json
{
  "type": "assistant",
  "message": {
    "content": [...],
    "usage": {
      "input_tokens": 27,
      "output_tokens": 3996,
      "cache_read_input_tokens": 1213703
    }
  }
}
```

### Tool results

```json
{
  "type": "user",
  "toolUseResult": {
    "agentId": "3380c209",
    "usage": {
      "input_tokens": 2,
      "output_tokens": 787,
      "cache_read_input_tokens": 24989
    },
    "prompt": "You are implementing Task 1...",
    "content": [{"type": "text", "text": "..."}]
  }
}
```

The `agentId` field links to subagent sessions, and the `usage` field contains token usage for that specific subagent invocation.
