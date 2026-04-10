# Galyarder Framework: The 1-Man Army Workflow

Code without distribution is worthless. Development without validation is chaos. The Galyarder Framework enforces a strict, non-negotiable sequence to guarantee that what is built is mathematically sound and market-ready.

## Phase 1: Market Intelligence & Discovery (The "Why")
**Agents:** `product-manager`, `growth-strategist`, `galyarder-specialist`
**Skills:** `brainstorming`, `write-a-prd`, `competitor-alternatives`, `linear-ticket-management`

Before a single line of code is written:
1. Clarify the business intent. Why does this feature exist?
2. Map the competitive landscape.
3. Lock down the requirements in a PRD. Define the `ubiquitous-language`.
4. Parse the PRD into Linear Epics and Issues. Assign complexity.

## Phase 2: Architecture & Blueprinting (The "Blueprint")
**Agents:** `super-architect`, `interface-designer`
**Skills:** `prd-to-plan`, `design-an-interface`

Once the PRD and Linear tickets are approved:
1. The architect drafts the system design (DB Schema, API Contracts).
2. **Aesthetic Command**: Consult the `rules/design/` directory for the relevant `DESIGN.md` specification if a brand style is required.
3. Work is broken down into **Vertical Slices** (Tracer Bullets) in a `plan.md`.
4. Every slice must cut through all layers (DB -> UI) and be independently verifiable.

## Phase 3: Execution & Testing (The "Factory")
**Agents:** `elite-developer`, `ui-ux-designer`, `security-guardian`, `perseus`
**Skills:** `subagent-driven-development`, `test-driven-development`, `systematic-debugging`, `vercel-react-best-practices`

With the plan finalized:
1. Transition the Linear ticket to "In Progress".
2. Dispatch parallel or sequential subagents to implement the vertical slices.
3. **Iron Law**: Test-Driven Development (TDD) is mandatory. Tests must fail, then pass.
4. **UI Execution**: The `ui-ux-designer` uses **Stitch** to build components following the chosen `DESIGN.md`.
5. Run security audits on authentication or data-handling logic.

## Phase 4: Integration, CI/CD, & QA (The "Gatekeeper")
**Agents:** `devops-engineer`, `qa-automation-engineer`, `elite-developer`
**Skills:** `requesting-code-review`, `finishing-a-development-branch`, `devops-deployment`, `verification-before-completion`

After the feature is built:
1. **Live Audit**: The `qa-automation-engineer` uses **BrowserOS** to verify the live build and catch regressions.
2. Self-review the code against the original PRD and the Design System.
3. Ensure no hardcoded secrets or PII leaks exist.
4. Establish infrastructure-as-code (Docker/Terraform) and CI/CD pipelines (GitHub Actions).
5. Merge the feature.

## Phase 5: Marketing, Video, & Conversion (The Growth)
**Agents:** `growth-strategist`, `remotion-engineer`, `social-strategist`
**Skills:** `seo-audit`, `schema-markup`, `copywriting`, `paywall-upgrade-cro`, `video-generation`, `social-content`

Once the code is merged:
1. Write action-oriented, high-signal marketing copy.
2. Inject Schema.org markup.
3. Apply PLFS scoring to onboarding and paywall flows.
4. Generate programmatic marketing and changelog videos in `remotion/`.
5. Engineer social distribution threads and transition the Linear ticket to "Done".

---
**Core Rule:** Do not skip phases. If the user asks for code without a plan, enforce Phase 2.
