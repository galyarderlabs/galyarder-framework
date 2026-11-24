# AGENTS.md: Forge Anything

Forge anything with AI agents.

Using an AI agent should not be just generating code, and the agent should not be confused. Forge Anything gives the agent the right rules and the workflow to do the work the right way, so the work is planned, built, checked against evidence, and shipped. The loop ends at distribution. That is the value: rules plus a workflow, in your company, and in your life.

## How it works

1. **Goal**: say what you want, in plain words.
2. **Plan**: the work gets a plan, with the rules and the workflow that fit it.
3. **Build**: the agent does the work, with tests before anything ships.
4. **Verify**: every claim is checked against evidence before it counts.
5. **Ship**: the work goes out. Distribution is where the loop ends.

The full workflow is in `WORKFLOW.md`.

## What is in this repo

- `agents/`: the agents that do the work. The Forge agents coordinate the work, and each department has its lead agents.
- `skills/`: the rules the agents follow. The scaffold ships a curated essential set; the full repo holds the wider set, which is long-term curation work to bring down to essential only. The curation standard is the Essential Skill Registry (`docs/skill-registry.md`), Galih's v15 research, with a review against the current skills in `docs/skill-registry-review.md`.
- `commands/`: the shortcuts.
- `crates/forge`: the `forge` CLI, written in Rust. Subcommands: `scaffold`, `company`, `mcp`, `smoke`, `version`, `help`. `forge scaffold` drops a tidy repo into a folder. `forge company import` copies an agent-company package into `company/<slug>/` in a project. `forge mcp` runs the MCP server.
- The MCP (`forge mcp`): five tools (`list_skills`, `read_skill`, `read_agent`, `read_command`, `scaffold`), over stdio, local only, no network. It is the distribution: install the MCP and a chatbot or an agent gets the tools plus the workflow.
- The harness plugins: Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes. Everything installs via plugin, no manual setup. See `docs/INTEGRATION.md`.

## The operator

You are the operator. You are the human owner, the final decision maker, and the approval gate. Agents expand what you can do; they do not replace you. Public, external, financial, irreversible, or production-sensitive actions need your approval.

## Department map

The ten departments are how the work is organized, so agents know where work belongs and what proof it needs. The scaffold creates these ten departments in a new repo.

### Forge core

The coordinators. `forge-ceo` directs the work. `forge-cfo-coo` owns operations and finance. `forge-cmo` owns growth and message. `forge-cto` owns architecture and engineering. `forge-specialist` handles work that does not fit one department.

Core skills: `forge`, `using-forge-anything`, `writing-plans`, `executing-plans`, `verification-before-completion`, `subagent-driven-development`, `brainstorming`, `company-creator`, `writing-skills`, `doc-maintenance`.

### 1. Executive

Founder context, investor relations, board updates, and diligence readiness.

Lead: `fundraising-operator`.

Skills: `founder-context`, `pitch-deck`, `investor-research`.

### 2. Product

Product direction, requirements, scope, roadmap, and issue breakdown.

Leads: `product-manager`, `planner`.

Skills: `write-a-prd`, `prd-to-plan`, `prd-to-issues`, `ubiquitous-language`.

### 3. Engineering

Architecture, implementation, tests, code quality, delivery, and refactoring.

Leads: `elite-developer`, `super-architect`.

Skills: `test-driven-development`, `systematic-debugging`, `requesting-code-review`, `finishing-a-development-branch`, `release`, `create-agent-adapter`.

### 4. Creative

Design, video, writing, images, branding, and content creation.

Leads: `ui-ux-designer`, `interface-designer`.

Skills: `content-creator`, `social-content`, `writing-skills`.

### 5. Growth

Acquisition, conversion, retention, distribution, analytics, and messaging.

Lead: `growth-strategist`.

Skills: `seo-audit`, `copywriting`, `content-strategy`, `marketing-psychology`, `analytics-tracking`.

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

Skills: `accounting`, `financial-analyst`.

### 9. Legal

Legal review, contracts, privacy, compliance, and intellectual property.

Lead: `legal-counsel`.

Skills: `contract-review`, `legal-tos-privacy`.

### 10. Knowledge

Documentation, decision history, operating reports, and reusable workflows.

Leads: `doc-updater`, `obsidian-architect`.

Skills: `obsidian-markdown`, `obsidian-cli`, `defuddle`.

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

The direction is curation to essential only. The scaffold already ships the curated set; the full repo is long-term curation work. The standard is the Essential Skill Registry (`docs/skill-registry.md`): best-in-class per slot value from real research, cross-industry (APQC) and life (WHOQOL/PERMA), iterable by anyone. The MCP grows toward the full coding-agent tool set. The first release that ships the prebuilt `forge` binary still needs a version tag push. The plain landing page is future work, not live. See `ROADMAP.md`.

Copyright 2026 Galyarder Labs. Forge Anything.
