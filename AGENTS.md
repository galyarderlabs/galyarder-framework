# AGENTS.md — Galyarder Framework Agent Instructions

This file is the root instruction guide for agents working in **Galyarder Framework**, the Intelligence Layer for Autonomous Goal Integration inside the Galyarder Labs ecosystem.

## Product Context

Galyarder Framework converts high-level operator intent into blueprints, tickets, SOPs, workflows, agent runtime, tests, audits, and execution proof.

In this repository, **AGI means Autonomous Goal Integration**. Do not frame it as artificial general intelligence.

The Framework serves the 1-Man Army, agentic companies, AI-native builders, founders, operators, researchers, technical strategists, and small elite teams who need leverage without bureaucracy.

## Required Reading Order

Before changing code, agents, skills, commands, docs, releases, or marketplace assets:

1. `README.md` — product orientation and public positioning.
2. `AGENTS.md` — this execution guide.
3. `CLAUDE.md` / `GEMINI.md` only when working inside those hosts or changing host-specific integration behavior.
4. Relevant department docs under `docs/`, `Executive/`, `Engineering/`, `Product/`, `Growth/`, `Security/`, `Infrastructure/`, `Legal-Finance/`, or `Knowledge`.
5. Relevant agent, skill, command, or integration file before editing it.

## Brand And Product Rules

- Lead with operator intent, deterministic execution, verification, and institutional-grade leverage for the single operator.
- Do not call Framework a prompt pack.
- Do not present AGI as artificial general intelligence.
- Do not lead public copy with cheap AI hype, Web3, crypto, SMB, Enterprise SaaS, or chatbot language.
- Do not remove controlled product-truth terms merely to sound safer. `agentic companies`, `AI-native builders`, and `AGI` as Autonomous Goal Integration are valid when tied to Framework behavior.
- Do not imply effortless fully autonomous execution without risk.
- Every major claim must connect to workflow behavior, agent capability, tests, audits, reports, evidence, or measurable output.
- Preserve the relationship to Galyarder Labs: Framework is the Intelligence Layer; Ledger is the Ledger Layer; HQ is the Command Layer; Galyarder Agent is the Continuity Layer.

## Execution Rules

- Keep changes surgical. Touch only files required by the mission.
- Prefer vertical-slice plans and tracer bullets for implementation work.
- Preserve existing agent/skill/command compatibility unless the task explicitly removes it.
- Do not rewrite root docs wholesale when a targeted patch is enough.
- Use the existing department structure instead of inventing new top-level organizational systems.
- Durable decisions, plans, and reports belong in the relevant docs/department path.

## Build And Verification

Use the repository’s package manager and scripts. When a package-specific command exists, prefer it.

Common gates:

```bash
pnpm install
pnpm lint
pnpm test
pnpm build
```

For focused work, run the narrowest meaningful test first, then the broader verification before handoff.

If a command cannot be run, report exactly what was skipped and why.

## Host Integration Rules

- `CLAUDE.md` is for Claude-family behavior.
- `GEMINI.md` is for Gemini CLI behavior.
- `.codex`, `.opencode`, `.cursor`, and marketplace folders are host-specific integration surfaces.
- Do not let host-specific rules contradict the Framework product identity.
- Keep host-specific bootloaders department-scoped; avoid returning to monolithic root-only behavior unless explicitly required.

## Rejection Gates

Reject or revise work if:

- It reduces Framework to prompts, loose assistants, or vague AGI hype.
- It removes verification discipline from implementation workflows.
- It invents unsupported agent counts, skill counts, platform support, or release claims.
- It breaks compatibility for a host integration without documenting the migration.
- It creates new public positioning that contradicts Galyarder Labs brand rules.
- Tests/build/lint fail for touched behavior and the failure is not explicitly reported.

---

© 2026 Galyarder Labs. Galyarder Framework.
