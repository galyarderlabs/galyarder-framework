# Galyarder Stack: Framework, Agent, HQ, and Ledger

The Galyarder ecosystem is an agentic-company stack. Each layer has a different job: intelligence, continuity, command, and financial execution.

## 1. Galyarder Framework — Intelligence Layer

- **Repository:** [galyarder-framework](https://github.com/galyarderlabs/galyarder-framework)
- **Role:** Provides specialized agents, skills, commands, SOPs, and review gates.
- **Function:** Defines how work is planned, routed, executed, verified, and documented.
- **Usage:** Runs inside AI assistants and coding tools such as Claude Code, Gemini CLI, Cursor, Hermes Agent, OpenClaw, Codex-style setups, and OpenCode-style setups.

## 2. Galyarder Agent — Continuity Layer

- **Repository:** [galyarder-agent](https://github.com/galyarderlabs/galyarder-agent)
- **Role:** Gives the framework an interface across chat, CLI, email, and other channels.
- **Function:** Provides memory, profile identity, tools, scheduled jobs, and multi-channel communication.
- **Usage:** Runs as a local or server-side runtime that keeps the operator connected to the agentic company.

## 3. Galyarder HQ — Command Layer

- **Repository:** [galyarder-hq](https://github.com/galyarderlabs/galyarder-hq)
- **Role:** Provides operating visibility and governance.
- **Function:** Shows projects, goals, reports, departments, task queues, approvals, and agent activity.
- **Usage:** A self-hosted web app that reads project state and gives the operator a command surface.

## 4. Galyarder Ledger — Financial Execution Layer

- **Role:** Turns operational and financial work into agent-assisted, ledger-backed execution.
- **Function:** Preserves financial evidence, approvals, reports, and role-based G-Agent workflows.
- **Usage:** Used when finance, sales, accounting, audit, tax, and evidence visibility need structured state.

## How they work together

```text
[ Operator Intent ]
        |
        v
[ Galyarder Agent ] <---- uses ----> [ Galyarder Framework ]
  continuity, tools, channels          agents, skills, commands
        |                                      |
        | writes reports / evidence           | produces plans / artifacts
        v                                      v
[ Project Operating Structure ] ----> [ Galyarder HQ ]
  docs, issues, decisions, reports       goals, approvals, visibility
        |
        v
[ Galyarder Ledger ]
  finance, approvals, evidence, reports
```

1. **Framework** gives agents the operating logic.
2. **Agent** gives that logic continuity and a communication surface.
3. **HQ** gives the operator visibility and control.
4. **Ledger** gives financial and operational work evidence-backed state.

The goal is not to make the operator passive. The goal is to make company execution structured, inspectable, and easier to govern.
