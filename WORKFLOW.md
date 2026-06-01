# Galyarder Framework: Agentic Company Workflow

The workflow turns founder/operator intent into reviewed work across departments. It is designed for software, product, growth, finance, sales, documentation, legal, security, operations, and strategy. Coding is one surface area; the framework is broader than coding.

## Foundation Protocols

Every workflow should keep these operating constraints visible:

1. **Traceability** — work maps to a scoped issue, brief, plan, decision, report, or PR.
2. **Grounding** — agents inspect the repo, source docs, user context, and relevant APIs before acting.
3. **Routing** — work moves to the correct department, agent, skill, command, or tool path.
4. **Planning** — non-trivial work gets a blueprint with constraints, risks, success criteria, and proof gates.
5. **Verification** — completion claims require tests, builds, reviews, citations, screenshots, logs, workflow runs, or other evidence.
6. **Persistence** — useful results become durable artifacts: docs, reports, release notes, campaigns, financial models, decision logs, or reusable skills.
7. **Human approval** — public, external, financial, irreversible, access, or production-sensitive actions require the operator's approval.

---

## Operational Modes

| Mode | Use case | Rules |
| :--- | :--- | :--- |
| **BUILD** | Normal product, docs, growth, finance, or engineering work | Use planning, implementation, review, and verification gates. |
| **INCIDENT** | Urgent breakage or production risk | Move faster, document the incident, and create follow-up cleanup work. |
| **EXPERIMENT** | Timeboxed exploration or prototype | Keep it reversible, mark assumptions, and avoid merging throwaway work into stable paths. |

---

## Verification Ladder

Use the cheapest proof that actually verifies the claim.

1. **Logic-level checks**: unit tests, schema validation, lint, typecheck, calculations, or static scans.
2. **Interface checks**: API contracts, CLI output, generated files, markdown/docs rendering, or tool-response shape.
3. **System checks**: smoke tests, browser tests, workflow runs, deploy checks, or live artifact verification.
4. **Human review gates**: approval for public posts, external sends, security changes, production deploys, account access, and irreversible actions.

---

## Phase 1: Intent and Context

**Typical owners:** `galyarder-ceo`, `galyarder-cmo`, `product-manager`, `growth-strategist`

**Common skills:** `brainstorming`, `write-a-prd`, `competitor-alternatives`, `market-research`, `founder-context`

1. Clarify the operator's goal and the real outcome.
2. Identify the buyer, user, stakeholder, system, or workflow affected.
3. Define success criteria, constraints, assumptions, risks, and kill conditions.
4. Create a PRD, issue, planning note, or short execution brief when needed.

## Phase 2: Architecture and Blueprinting

**Typical owners:** `galyarder-cto`, `super-architect`, `architect`, `planner`

**Common skills:** `prd-to-plan`, `writing-plans`, `ubiquitous-language`, `design-an-interface`

1. Inspect the current codebase, docs, data, or workflow surface.
2. Pull current official references for APIs and platform behavior.
3. Choose the smallest viable implementation path.
4. Break work into vertical slices or domain-specific deliverables.
5. Write decisions as ADRs, plans, or reviewable notes when the tradeoff matters.

## Phase 3: Specialist Execution

**Typical owners:** `elite-developer`, `ui-ux-designer`, `security-guardian`, `legal-counsel`, `financial-analyst`, `growth-engineer`, `sales-engineer`

**Common skills:** `subagent-driven-development`, `test-driven-development`, `systematic-debugging`, `copywriting`, `financial-analyst`, `legal-tos-privacy`, `social-content`

1. Move the active issue, brief, or task into progress.
2. Execute through the correct specialist, command, tool, or subagent.
3. Keep changes scoped to the outcome.
4. Preserve useful technical content instead of replacing it with generic messaging.
5. Leave enough context for another maintainer to inspect the result.

## Phase 4: Review, Compliance, and QA

**Typical owners:** `qa-automation-engineer`, `code-reviewer`, `security-reviewer`, `devops-engineer`, `legal-counsel`, `galyarder-cfo-coo`

**Common skills:** `requesting-code-review`, `verification-before-completion`, `security-reviewer`, `devops-engineer`, `gdpr-ccpa-privacy-auditor`

1. Run the relevant test, build, lint, render, security, or source-verification checks.
2. Review for overreach, unsafe automation, secrets, fragile assumptions, and unverified claims.
3. Confirm external/public actions are approved before sending, posting, inviting, deploying, or changing access.
4. Record evidence and blockers instead of hiding uncertainty.

## Phase 5: Distribution and Memory

**Typical owners:** `galyarder-cmo`, `docs`, `social-strategist`, `release-manager`, `obsidian-architect`

**Common skills:** `seo-audit`, `schema-markup`, `copywriting`, `social-content`, `docs`, `release-manager`, `obsidian`

1. Prepare release notes, documentation, launch copy, or a distribution plan when the work is meant to ship.
2. Save reusable knowledge into docs, skills, decisions, or reports.
3. Update the issue/task state and name the evidence used.
4. Hand the final decision back to the operator when public, external, financial, or irreversible action is involved.

**Core rule:** do not call work complete until the relevant artifact exists and the verification path has been exercised.
