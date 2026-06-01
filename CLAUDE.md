# Claude Code Integration — Galyarder Framework

This guide explains how Claude Code should use Galyarder Framework as an agentic-company operating layer.

## Operating Gate

Every Claude Code session should follow this order:

1. **Understand intent** — restate the operator goal and constraints.
2. **Inspect before editing** — read the relevant files, docs, tests, and runtime state.
3. **Route the work** — choose the correct department, agent, skill, command, or tool path.
4. **Plan non-trivial changes** — define the smallest viable implementation slice and proof gate.
5. **Execute surgically** — preserve unrelated code and useful technical content.
6. **Verify before completion** — run the proving command/check and report evidence.
7. **Persist useful results** — leave docs, tests, reports, PR notes, or decisions when the work needs continuity.

## Technical Integrity

- Think before coding.
- Prefer simple, inspectable changes over speculative architecture.
- Keep edits scoped to the requested outcome.
- Use tests, builds, lint, logs, rendered output, or live checks as completion proof.
- Do not claim success from confidence alone.

## Human-Directed Execution

Claude Code can implement, refactor, test, document, and review. The human operator remains the source of intent and approval for external, public, financial, security-sensitive, or irreversible actions.
