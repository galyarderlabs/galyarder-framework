# CLAUDE.md — Galyarder Framework

Claude-family agents working in this repository must treat `AGENTS.md` as the canonical root instruction file.

## Bootstrap

Load in order:

1. `AGENTS.md`
2. `WORKFLOW.md` when present and relevant to the task
3. The specific agent, skill, command, department, or integration file being changed

Load behavior must stay department-scoped. Use the selected plugin's personas, agents, commands, and skills; do not rely on root-level monolithic rule files when a narrower department source exists.

## Product Identity

Galyarder Framework is the Intelligence Layer for **Autonomous Goal Integration (AGI)** inside Galyarder Labs.

- AGI means Autonomous Goal Integration.
- Agentic companies and AI-native builders are valid Framework contexts when tied to real workflows, agents, skills, tests, audits, and execution proof.
- Do not frame the project as artificial general intelligence.
- Do not reduce the project to a prompt pack.
- Preserve the 1-Man Army operator context and verification-first execution model.

## Claude-Specific Execution

- Use the current repository files as source of truth before editing.
- Keep changes surgical.
- Preserve host compatibility for Claude Code commands, skills, and marketplace assets.
- Verify with the relevant package command before claiming completion.

---

© 2026 Galyarder Labs. Galyarder Framework.
