# AGENTS.md: Forge Anything

Forge anything with AI agents.

Using an AI agent should not be just generating code, and the agent should not be confused. Forge Anything gives the agent the right rules and the workflow to do the work the right way, so the work is planned, built, checked against evidence, shipped, earned from, and given back. The build loop ends at distribution; the flow closes at give back, and the next cycle starts at Ideas. That is the value: rules plus a workflow, in your company, and in your life.

## How it works

One flow, five stages:

1. **Ideas**: turn sparks into something worth building.
2. **Goal**: say what you want, in plain words. The work gets a plan, with the rules and the workflow that fit it.
3. **Ship**: the agent plans it, builds it, checks every claim against evidence, and ships it. Distribution is where the build loop ends.
4. **Earn**: price it, sell it, collect it.
5. **Give back**: return what you earned, in whatever form fits (skills, content, tools, time, money), so the next person has hope to start and the next cycle starts at Ideas.

The full workflow is in `WORKFLOW.md`.

## What is in this repo

- `agents/`: the agents that do the work. Each agent is a folder with `README.md` + `SOUL.md` + `MEMORY.md`; the soul names skill names only, never skill contents. The Forge agents coordinate the work, and each department has its lead agents.
- `skills/`: the rules the agents follow. The scaffold ships a curated essential set; the full repo holds the wider set, which is long-term curation work to bring down to essential only. The curation is complete: 176 skills in the repo, organized by department. The registry research docs were removed once curation finished.
- `commands/`: the shortcuts.
- `crates/forge`: the `forge` CLI, written in Rust. Subcommands: `scaffold`, `company`, `mcp`, `smoke`, `version`, `help`. `forge scaffold` drops a tidy repo into a folder. `forge company import` copies an agent-company package into `company/<slug>/` in a project. `forge mcp` runs the MCP server.
- The MCP (`forge mcp`): four tools (`list_skills`, `read_skill`, `read_command`, `scaffold`), over stdio, local only, no network. It is the distribution: install the MCP and a chatbot or an agent gets the tools plus the workflow.
- The harness plugins: Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes. Everything installs via plugin, no manual setup. See `docs/INTEGRATION.md`.

## The operator

You are the operator. You are the human owner, the final decision maker, and the approval gate. Agents expand what you can do; they do not replace you. Public, external, financial, irreversible, or production-sensitive actions need your approval.

## Department map

The seventeen departments are how the work is organized, so agents know where work belongs and what proof it needs. The scaffold creates these seventeen departments in a new repo.

### Forge core

The coordinators. `forge-ceo` directs the work. `forge-cfo` owns finance. `forge-coo` owns operations. `forge-cmo` owns growth and message. `forge-cto` owns architecture and engineering. `forge-specialist` handles work that does not fit one department.

Core skills: `using-forge-anything`, `writing-plans`, `executing-plans`, `verification-before-completion`, `subagent-driven-development`, `brainstorming`, `company-creator`, `writing-skills`, `doc-maintenance`.

### 1. Executive

Founder context, investor relations, board updates, and diligence readiness.

Skills: `founder-context`, `pitch-deck`, `investor-research`.

### 2. Product

Product direction, requirements, scope, roadmap, and issue breakdown.

Lead: `product-manager`.

Skills: `prd-flow`, `ubiquitous-language`.

### 3. Engineering

Architecture, implementation, tests, code quality, delivery, and refactoring.

Leads: `software-engineer`, `super-architect`.

Skills: `test-driven-development`, `systematic-debugging`, `adversarial-review`, `finishing-a-development-branch`, `release`, `create-agent-adapter`.

### 4. Creative

Design, video, writing, images, branding, and content creation.

Lead: `ui-ux-designer`.

Skills: `social-production`, `writing-skills`.

### 5. Growth

Acquisition, conversion, retention, distribution, analytics, and messaging.

Lead: `growth-strategist`.

Skills: `seo-audit`, `marketing-core`, `analytics-tracking`.

### 6. Security

Security review, threat modeling, hardening, and compliance basics. The scaffold carries the defensive and compliance basics only; the specialized offensive and threat-intel skills stay in the full repo.

Lead: `security-guardian`.

Skills: `cloud-security`, `gdpr-compliance`, `open-source-license`.

### 7. Infrastructure

CI/CD, deployment, runtime operations, and release readiness.

Leads: `devops-engineer`, `release-manager`.

Skills: `release`.

### 8. Finance

Cost, budgeting, accounting, financial state, and runway.

Lead: `finops-manager`.

Skills: `accounting-core`.

### 9. Legal

Legal review, contracts, privacy, compliance, and intellectual property.

Lead: `legal-counsel`.

Skills: `contract-review`, `legal-tos-privacy`.

### 10. Knowledge

Documentation, decision history, operating reports, and reusable workflows.

Leads: `doc-updater`, `obsidian-architect`.

Skills: `obsidian-markdown`, `obsidian-cli`, `defuddle`.

### 11. Operations

Web data ops, sales, and automation.

### 12. Customer Success

Customer lifecycle, health scores, churn prevention, and support.

Lead: `support-lead`.

### 13. People

Talent acquisition, HR processes, and recruiting.

### 14. Data

Data engineering, SQL, data transformation, and business intelligence.

Skills: `data-analysis`, `data-infra`, `business-intelligence`.

### 15. Trading

Quantitative analysis, DeFi, token research, technical analysis, and trading discipline.

Skills: `exchange-data`.

### 16. External Relations

PR, media production, crisis communications, fundraising, and external partnerships.

Lead: `fundraising-operator`.

### 17. Life

Health, mind, relationships, learning, money, and home.

## Operating protocols

1. **Human command stays visible.** Agents expand what you can do; they do not replace you.
2. **Intent becomes structure.** Turn a goal into a scoped plan, issue, checklist, doc, diff, report, or decision record.
3. **Grounding before execution.** Inspect the source files, the current repo state, the docs, and the relevant references before acting.
4. **Smallest viable path.** Take the shortest path that meets the goal. Do not build speculative architecture.
5. **Specialist matching.** Send work to the department, skill, command, or agent that fits it instead of keeping it in a generic loop.
6. **Verification before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, citations, or other evidence.
7. **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.
8. **Approval gates.** Public, external, financial, irreversible, access, or production-sensitive actions need the operator's approval.

## Where it is going

The direction is curation to essential only. The scaffold already ships the curated set; the full repo is long-term curation work. The curation standard was the Essential Skill Registry (v20 research input, best-in-class per slot value from real research, cross-industry (APQC) and life (WHOQOL/PERMA)); its docs were removed once curation finished. The MCP grows toward the full coding-agent tool set. The first release that ships the prebuilt `forge` binary still needs a version tag push. The plain landing page is future work, not live. See `ROADMAP.md`.

Copyright 2026 Galyarder Labs. Forge Anything.
