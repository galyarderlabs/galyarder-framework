# Galyarder Agent Framework — Codebase Summary

## Project Purpose
Galyarder Agent Framework is a plugin-first system for AI coding assistants that enforces a structured "1-Man Army" workflow across planning, implementation, testing, security, release, and growth phases.

## High-Level Architecture
- **Content-driven core:** behavior is primarily defined in markdown-based skills, agents, and commands.
- **Multi-platform adapters:** manifests/integration layers target Claude, Copilot/Codex, Cursor, Gemini, and OpenCode.
- **Session bootstrap + hooks:** startup hooks inject framework context and bootstrap skill guidance at session start.

## Key Directories
- `agents/` — specialist agent definitions (e.g., orchestrator, dev, docs, security).
- `skills/` — workflow skills (`SKILL.md`) for brainstorming, planning, TDD, debugging, and execution.
- `commands/` — command entrypoints mapping user intents to skill/agent workflows.
- `hooks/` — session-start and cross-platform hook integration.
- `tests/` — behavior and integration suites (Claude, OpenCode, brainstorming server, skill triggering).
- `docs/` — platform guides, testing docs, and architecture notes.
- `scripts/` — maintenance and release helpers.

## Runtime Flow (Hooks → Skills → Commands)
1. Session starts and hook scripts inject framework context.
2. Bootstrap skill enforces "check/apply relevant skill first."
3. Commands route into specialized workflows (e.g., brainstorm, plan, tdd, docs).
4. Complex tasks are commonly delegated through subagent-driven development.
5. Brainstorming has an optional visual companion server for browser-based collaboration.

## Tooling & Scripts
- `scripts/bump-version.sh` + `.version-bump.json` synchronize version numbers across manifests.
- `.github/workflows/release.yml` publishes releases from `v*` tags.
- `.opencode/plugins/galyarder-agent-framework.js` bootstraps context and registers skills path in OpenCode.

## Testing & Validation Surface
- `tests/claude-code/` validates skill behavior in Claude harness.
- `tests/opencode/` validates plugin loading, priority, and tool behavior.
- `tests/brainstorm-server/` validates websocket/server lifecycle behavior.
- `tests/skill-triggering/` and `tests/explicit-skill-requests/` validate correct skill invocation paths.
- `tests/subagent-driven-dev/` contains end-to-end subagent execution fixtures.

## Notable Docs
- `README.md` — product overview and install matrix.
- `WORKFLOW.md` — 5-phase lifecycle.
- `CLAUDE.md` and `AGENTS.md` — contributor/agent guardrails.
- `docs/testing.md` — testing guidance.
- `CHANGELOG.md` and `RELEASE-NOTES.md` — release history.

## Source Anchors
- `README.md`
- `WORKFLOW.md`
- `hooks/session-start`
- `hooks/hooks.json`
- `hooks/hooks-cursor.json`
- `skills/using-galyarder-agent-framework/SKILL.md`
- `skills/subagent-driven-development/SKILL.md`
- `skills/brainstorming/scripts/server.cjs`
- `commands/plan.md`
- `commands/tdd.md`
- `commands/docs.md`
- `.claude-plugin/plugin.json`
- `.cursor-plugin/plugin.json`
- `gemini-extension.json`
- `.opencode/plugins/galyarder-agent-framework.js`
