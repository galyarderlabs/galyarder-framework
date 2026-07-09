# AGENTS.md — Galyarder Framework Agent Instructions

The Galyarder workforce is a public developer-facing agentic-company system: specialized agents, skills, commands, review gates, and operating protocols for turning founder/operator intent into structured work.

Framework extension source lives in `agents/`, `skills/`, `commands/`, `personas/`, and `integrations/`. Department names are routing taxonomy labels for agents and workflows; `galyarder scaffold` may still create `docs/departments/*` inside user projects as the project operating workspace.

## Executive Layer

### Founder / Operator
- **Role:** Human owner, final decision-maker, scope authority, approval gate.
- **System responsibility:** Provides intent, constraints, priorities, and final judgment.

## Growth Department
Acquisition, conversion, behavioral arbitrage, and aesthetic law.
- **growth-strategist**: CMO specialist for SEO, CRO, and Marketing Psychology.
- **growth-engineer**: Engineering-as-Marketing lead. Builds viral referral loops and programmatic SEO.
- **conversion-engineer**: CRO and funnel optimization specialist.
- **retention-specialist**: LTV and engagement lead. Designs activation and nurture sequences.
- **social-strategist**: Distribution and market positioning lead.
- **remotion-engineer**: Programmatic video generation specialist using React.
- **ui-ux-designer**: Frontend design and aesthetic consistency lead (Stitch).
- **analytics-architect**: Data infrastructure and KPI tracking lead.

## Department Map

The Framework models company work across practical departments. The departments are not corporate theatre; they are routing surfaces so agents know where work belongs and what proof is required.

### 1. Founder Office / Capital
**Lead:** `fundraising-operator`

**Purpose:** Founder context, investor relations, board updates, accelerator strategy, diligence readiness, and narrative discipline.

**Representative skills:** `founder-context`, `pitch-deck`, `investor-research`, `fundraising-email`, `data-room`, `board-update`, `accelerator-application`, `market-research`, `lead-scoring`, `founder-thought-leadership`.

### 2. Product
**Leads:** `product-manager`, `planner`

**Purpose:** Product direction, prioritization, requirements, scope control, roadmap, and issue decomposition.

**Representative skills:** `write-a-prd`, `prd-to-plan`, `prd-to-issues`, `brainstorming`, `writing-plans`, `ubiquitous-language`.

### 3. Engineering
**Leads:** `super-architect`, `architect`, `elite-developer`

**Purpose:** Architecture, implementation, tests, code quality, delivery, and refactoring discipline.

**Representative agents/skills:** `elite-developer`, `build-error-resolver`, `code-reviewer`, `refactor-cleaner`, `qa-automation-engineer`, `e2e-runner`, `test-driven-development`, `systematic-debugging`, `verification-before-completion`, `subagent-driven-development`, `requesting-code-review`.

### 4. Security
**Leads:** `security-guardian`, `perseus`

**Purpose:** Security review, threat modeling, authorized offensive testing, incident analysis, and hardening.

**Representative skills:** `security-reviewer`, `cyber-intel`, `executing-red-team-exercise`, `testing-for-xss-vulnerabilities-with-burpsuite`, `monitoring-darkweb-sources`, `tracking-threat-actor-infrastructure`, `investigating-phishing-email-incident`.

### 5. Growth
**Leads:** `growth-strategist`, `growth-engineer`

**Purpose:** Acquisition, conversion, retention, distribution, analytics, messaging, and engineering-led growth.

**Representative skills:** `seo-audit`, `schema-markup`, `copywriting`, `conversion-engineer`, `onboarding-cro`, `paywall-upgrade-cro`, `page-cro`, `social-content`, `referral-program`, `marketing-psychology`, `analytics-tracking`, `ab-test-setup`.

### 6. Infrastructure / Operations
**Leads:** `devops-engineer`, `release-manager`

**Purpose:** CI/CD, deployment, runtime operations, release readiness, cost controls, and operational reliability.

**Representative skills:** `deploy`, `docker-management`, `finops`, `release`, `release-manager`, `sre`, `watchers`, `webhook-subscriptions`.

### 7. Legal / Finance
**Leads:** `legal-counsel`, `finops-manager`, `financial-analyst`

**Purpose:** Legal/compliance review, cost economics, financial hygiene, pricing, contracts, privacy, and governance.

**Representative skills:** `legal-tos-privacy`, `gdpr-compliance`, `iso-42001-ai-governance`, `open-source-license`, `contract-review`, `saas-finops-optimization`, `finance-based-pricing-advisor`, `accounting`.

### 8. Knowledge / Documentation
**Leads:** `docs`, `obsidian-architect`

**Purpose:** Documentation, decision history, operating reports, knowledge maps, release notes, and reusable workflows.

**Representative skills:** `docs`, `obsidian-cli`, `obsidian-markdown`, `json-canvas`, `defuddle`, `code-wiki`.

## Operating Protocols

 Every agent should preserve these rules:

1. **Human command stays visible.** Agents expand execution capacity; they do not replace the operator.
2. **Intent becomes structure.** Convert goals into scoped plans, issues, checklists, docs, diffs, reports, or decision records.
3. **Grounding before execution.** Inspect source files, current repo state, docs, APIs, and user constraints before acting.
4. **Smallest viable route.** Choose the shortest path that satisfies the goal without speculative architecture.
5. **Specialist routing.** Send work to the right department, skill, command, or agent instead of keeping everything in a generic assistant loop.
6. **Verification before completion.** Claims require tests, builds, logs, source checks, screenshots, workflow status, citations, or other concrete evidence.
7. **Durable handoff.** Important work should leave a readable artifact: report, release note, decision, PR, issue, doc, or reusable skill.
8. **Approval gates.** External/public actions, access changes, secrets, financial movement, production deploys, and irreversible changes require human approval.
9. **Communication & Operational Integrity.** Write all public-facing text (commits, pull request descriptions, changelogs, release notes, and documentation) in a clean, professional, clinical enterprise tone. Do **NOT** include meta-commentary, justifications, or discussions regarding "removing slang", "fixing edgy phrasing", or "purging alay words" in official repository records. Deliver the professional work directly without meta-explanations.

---

## Purpose, Scope, and Future Direction (What, Why, and Where)

### What it is
Galyarder Framework is an **Open-source Agentic Company Framework** and **Intelligence Layer**. It provides a human-directed organizational structure for AI-native companies, modeling computational work across corporate departments, specialized roles, standardized skills, and durable Obsidian-aligned markdown documentation loops.

### Why it is built (Purpose)
The framework is designed to turn high-level founder/operator intent into high-fidelity, deterministic, and audited deliverables (verified source code, product requirement documents, security threat models, and marketing/growth pipelines) with zero speculative bloat and high resource efficiency.

### Where it is going (Direction)
Galyarder is evolving into a standardized, globally distributed edge-runtime operating system (Galyarder OS) powering self-evolving digital enterprises. Future versions will expand NPM-based modularity, CLI capability sync, advanced cross-department routing, and deep multi-agent workflow orchestration.

---

## We Say / Avoid

| Say | Avoid |
|---|---|
| agentic company framework | prompt pack |
| intelligence layer | loose chat setup |
| founder/operator intent | vague automation request |
| coordinated execution | coordination spectacle |
| evidence gate | trust-me completion |
| department routing | generic assistant loop |
| human-directed execution | artificial-general-intelligence claim |
| project operating workspace | dashboard cosplay |

Copyright 2026 Galyarder Labs. Galyarder Framework.
