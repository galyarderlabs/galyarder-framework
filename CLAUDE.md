# Claude Code: Implementation Protocol

This guide defines the high-integrity integration of Galyarder Framework within the **Claude Code** (Anthropic) environment.

# BOOTSTRAP: Load core system intelligence
@AGENTS.md
@WORKFLOW.md
@BRAND.md
@DESIGN.md
@docs/galyarder-labs/BRAND.md
@docs/galyarder-labs/DESIGN.md

Load behavior must stay department-scoped while reading the selected plugin's `personas/`,
`agents/`, `commands/`, and `skills/` surfaces. Do not rely on root-level monolithic rule files
or legacy extension bundle paths such as `.marketplace/full/`. Project reports may still write to scaffolded `docs/departments/*` folders.

---

## 1. THE 1-MAN ARMY GLOBAL PROTOCOLS (MANDATORY)

Every operation within this session is governed by the 1-Man Army execution gate. You are hardcoded to enforce:

### Operational Modes
- **BUILD (Default)**: Heavy ceremony. Requires PRD, Blueprinting, and full TDD gating.
- **INCIDENT**: Emergency hotfix mode. Bypasses planning but requires post-mortem and 48h conversion to BUILD.
- **EXPERIMENT**: Timeboxed spike. No tests required; code must be quarantined.

### Mandatory Loop
1. **Traceability**: All computational labor must occur within a project-scoped Linear issue.
2. **Cognitive Integrity**: Explicit `sequentialthinking` MCP loop before any high-impact action.
3. **Technical Integrity**: Think Before Coding, Simplicity First, Surgical Changes, and Goal-Driven Execution (Karpathy).
4. **Validation**: Real-time fetch of official references via `context7`.
5. **Token Economy**: Mandatory use of the `rtk` proxy for all terminal operations.
6. **Persistence**: Every task must result in a durable markdown report in `docs/departments/` (The Obsidian Loop).

---

## 2. Command Triggers

Claude Code supports instant mission triggers via slash commands:

| Command | Department | Mission |
| :--- | :--- | :--- |
| `/graph` | Knowledge | Rebuild the Galyarder Neural Link and Obsidian Map. |
| `/tdd` | Engineering | Strict Test-Driven Development workflow. |
| `/plan` | Product | Vertical Slice (Tracer Bullet) architecture mapping. |
| `/marketing` | Growth | CRO audit and behavioral copywriting. |
| `/cybersecurity` | Security | Advanced offensive/defensive security audit. |
| `/review` | Engineering | Principal-level code review. |
| `/incident` | Engineering | Switch to INCIDENT mode for hotfixes. |
| `/experiment` | Product | Switch to EXPERIMENT mode for spikes. |

---
© 2026 Galyarder Labs. Galyarder Framework.
