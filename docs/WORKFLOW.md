# Galyarder Framework: The Humans 3.0 Workflow

Code without distribution is worthless. Development without validation is chaos. The Galyarder Framework enforces a deterministic, high-rigor sequence modeled after the Humans 3.0 protocol: the distillation of humanity's apex strategic minds, stripped of emotional overhead and executed with mathematical precision.

## The Foundation: Global Mandatory Protocols

Every phase of the workflow is governed by the 1-Man Army Global Protocols:
1. **Token Economy**: Mandatory use of the `rtk` proxy for all terminal operations.
2. **Traceability**: All computational labor must occur within a project-scoped Linear issue via the **IssueTracker Interface**.
3. **Cognitive Integrity**: Explicit Scratchpad Reasoning and `sequentialthinking` MCP loop before any high-impact action.
4. **Technical Integrity (Karpathy)**: Think Before Coding, Simplicity First, Surgical Changes, and Goal-Driven Execution.
5. **The Obsidian Loop**: Every task must result in a durable markdown report saved to the relevant department folder in `docs/departments/` via the **MemoryStore Interface**.

---

## Operational Modes

To maintain high velocity without sacrificing institutional-grade quality, the framework operates in three distinct modes. You must explicitly declare your mode:

1. **BUILD Mode (Default)**: The standard path. High ceremony, rigid architectural blueprinting, and full TDD gating. Used for 90% of development.
2. **INCIDENT Mode**: Emergency protocol for hotfixes. Bypasses the PRD and Blueprinting phases for speed. 
   - **Governance**: Hotfixes MUST be converted into a proper `BUILD` follow-up within 48 hours to clean up technical debt.
   - **Constraint**: Requires a post-mortem ticket in Linear and a patch release note.
3. **EXPERIMENT Mode**: Timeboxed, throwaway code for rapid validation. TDD is optional. Code is quarantined and cannot be merged to `main`.

---

## The Gating Ladder (Audit Standard)

Every mission in `BUILD` or `INCIDENT` mode must pass through the following verification gates before the Obsidian Loop concludes:

1. **Gate 1: Unit Test**: Logic-level verification. Must prove **Test Oracle / Negative Control** (test fails for the correct reason via mutation/variant) before passing.
2. **Gate 2: Contract Test**: Interface-level verification of the structural exchange format (JSON schema/payload) between agents and tools. Location: `tests/contract/`.
3. **Gate 3: E2E/Smoke**: Golden path verification in a live or simulated environment (e.g., via BrowserOS).

---

## Phase 1: Market Intelligence & Discovery (The "Why")

**Executive Oversight:** `galyarder-ceo`, `galyarder-cmo`
**Agents:** `product-manager`, `growth-strategist`
**Skills:** `brainstorming`, `write-a-prd`, `competitor-alternatives`, `linear-ticket-management`

*(Bypassed in INCIDENT and EXPERIMENT modes)*

Before a single line of code is written:
1. **Intent Extraction**: The CEO clarifies the business intent and strategic advantage.
2. **Market Mapping**: The CMO analyzes the competitive landscape and identifies cognitive arbitrage opportunities.
3. **Requirement Locking**: Requirements are solidified in a PRD. Define the `ubiquitous-language`.
4. **Linear Epic Initialization**: Parse the PRD into project-scoped Linear tickets. Assign complexity and ROI.

## Phase 2: Architecture & Blueprinting (The "Blueprint")

**Executive Oversight:** `galyarder-cto`
**Agents:** `super-architect`, `interface-designer`
**Skills:** `prd-to-plan`, `design-an-interface`

*(Bypassed in INCIDENT and EXPERIMENT modes)*

Once the PRD and Linear tickets are approved:
1. **System Design**: The CTO oversees the drafting of the system architecture (DB Schema, API Contracts).
2. **Context Versioning**: Agents MUST use `context7` to verify version metadata against local dependencies before designing interfaces.
3. **Architecture Decision Records (ADR)**: Document the "Why" behind every major technical choice.
4. **Vertical Slicing**: Break work down into Tracer Bullets in a `plan.md`. Every slice must cut through all layers (DB -> UI) and be independently verifiable.

## Phase 3: Execution & Testing (The "Factory")

**Executive Oversight:** `galyarder-cto`
**Agents:** `elite-developer`, `ui-ux-designer`, `security-guardian`, `perseus`
**Skills:** `subagent-driven-development`, `test-driven-development`, `systematic-debugging`

With the blueprint finalized:
1. **Linear Transition**: Set the ticket to "In Progress".
2. **Deterministic Implementation**: The `elite-developer` implements vertical slices using the Humans 3.0 protocol.
3. **Iron Law of TDD**: Implement failing tests (Red), prove they fail for the right reason, then pass (Green), then refactor.
4. **Security Hardening**: Run offensive audits via `perseus` on authentication and data-handling logic.

## Phase 4: Integration, Compliance & QA (The "Gatekeeper")

**Executive Oversight:** `galyarder-cfo-coo`, `galyarder-cto`
**Agents:** `devops-engineer`, `qa-automation-engineer`, `legal-counsel`
**Skills:** `requesting-code-review`, `finishing-a-development-branch`, `devops-deployment`, `verification-before-completion`

After the feature is built:
1. **Live Audit**: The `qa-automation-engineer` uses **BrowserOS** to verify the live build and ensure zero regressions.
2. **Hardening**: Ensure implementation follows least privilege and web-input hygiene.
3. **Zero Waste Verification**: Ensure no orphaned code, speculative abstractions, or hardcoded secrets exist.
4. **CI/CD Deployment**: Establish IaC (Docker/Terraform) and automated deployment pipelines.

## Phase 5: Marketing, Video & Distribution (The Growth)

**Executive Oversight:** `galyarder-cmo`
**Agents:** `growth-strategist`, `remotion-engineer`, `social-strategist`
**Skills:** `seo-audit`, `schema-markup`, `copywriting`, `video-generation`, `social-content`

Once the code is merged:
1. **Cognitive Messaging**: Write high-signal marketing copy based on behavioral heuristics.
2. **SEO Topography**: Inject Schema.org markup and update programmatic SEO topic clusters.
3. **Programmatic Distribution**: The `remotion-engineer` generates data-driven marketing and changelog videos.
4. **Memetic Warfare**: Engineer social distribution threads and transition the Linear ticket to "Done".

---

**Core Rule**: Never skip phases (unless explicitly in INCIDENT or EXPERIMENT mode). Every change must trace to a verified request and conclude with a durable report. Information flows up; Vision flows down.

---
Copyright 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
