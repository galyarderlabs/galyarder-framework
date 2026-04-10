# Galyarder Agent-to-Skill Mapping

## Purpose
This document maps each major agent to the skills that should function as its worker stack.

The goal is to stop thinking of Galyarder as a flat skill library and instead treat each agent as a manager or functional owner with a defined team underneath.

## Mapping Rules
- Agents are managers, leads, or senior specialists.
- Skills are workers, task modules, or operating playbooks.
- Not every skill needs a direct agent immediately, but every important skill should eventually belong somewhere.
- External skills imported from other repositories should be mapped into an agent stack, not left orphaned.

## Executive / Orchestration
### `galyarder-specialist`
Role:
- CEO / chief orchestrator

Primary supporting skills:
- `using-galyarder-framework`
- `brainstorming`
- `writing-plans`
- `executing-plans`
- `subagent-driven-development`
- `verification-before-completion`

Expansion routing:
- founder-facing work -> `fundraising-operator`
- knowledge / dashboards -> `obsidian-architect`
- engineering build path -> engineering department leads

## Founder Office / Capital
### `fundraising-operator`
Primary skills:
- `founder-context`
- `pitch-deck`
- `investor-research`
- `fundraising-email`
- `data-room`
- `board-update`
- `accelerator-application`
- `market-research`
- `lead-scoring`
- `founder-thought-leadership`

Future optional additions:
- investor CRM / pipeline hygiene
- fundraising tracker
- warm-intro network mapper

### `product-manager`
Primary skills:
- `write-a-prd`
- `prd-to-plan`
- `prd-to-issues`
- `writing-plans`
- `brainstorming`
- `ubiquitous-language`

Potential external upgrades to evaluate:
- competitive teardown
- research synthesis
- roadmap communication

## Engineering
### `super-architect`
Primary skills:
- `architect`
- `writing-plans`
- `ubiquitous-language`
- `verification-before-completion`

Potential external upgrades:
- `senior-architect`
- API design review
- database design / schema planning
- spec-driven workflow

### `architect`
Primary skills:
- `architect`
- `prd-to-plan`
- `writing-plans`

Potential external upgrades:
- epic design
- API reviewer
- migration architect

### `elite-developer`
Primary skills:
- `test-driven-development`
- `systematic-debugging`
- `verification-before-completion`
- `subagent-driven-development`
- `build-error-resolver`

Potential external upgrades:
- senior frontend / backend / fullstack specializations
- spec-driven workflow
- self-eval

### `qa-automation-engineer`
Primary skills:
- `e2e-runner`
- `test-driven-development`
- `verification-before-completion`

Potential external upgrades:
- `playwright-pro`
- API test suite builder
- a11y audit

### `code-reviewer`
Primary skills:
- `requesting-code-review`
- `receiving-code-review`
- `code-reviewer`

Potential external upgrades:
- `pr-review-expert`
- adversarial reviewer

### `build-error-resolver`
Primary skills:
- `build-error-resolver`
- `systematic-debugging`

### `refactor-cleaner`
Primary skills:
- `refactor-cleaner`
- `verification-before-completion`

### `vercel-react-expert`
Primary skills:
- `vercel-react-best-practices`
- `web-design-guidelines`

Potential external upgrades:
- advanced frontend performance and accessibility review packs

## Security
### `security-guardian`
Primary skills:
- `security-guardian`
- `testing-for-xss-vulnerabilities-with-burpsuite`
- `gdpr-compliance`

Potential external upgrades:
- cloud security
- AI security
- secrets manager

### `security-reviewer`
Primary skills:
- `security-reviewer`
- `verification-before-completion`

Potential external upgrades:
- appsec audit packs
- adversarial review

### `cyber-intel`
Primary skills:
- `cyber-intel`
- `monitoring-darkweb-sources`
- `tracking-threat-actor-infrastructure`
- `generating-threat-intelligence-reports`

### `perseus`
Primary skills:
- red-team and offensive simulation skills already in repo

## Growth
### `growth-strategist`
Primary skills:
- `content-strategy`
- `launch-strategy`
- `pricing-strategy`
- `programmatic-seo`
- `seo-audit`
- `schema-markup`
- `social-content`

Potential external upgrades:
- content creator
- demand generation
- free tool strategy
- advanced marketing ops

### `growth-engineer`
Primary skills:
- `analytics-tracking`
- `ab-test-setup`
- `signup-flow-cro`
- `onboarding-cro`
- `page-cro`
- `paywall-upgrade-cro`
- `referral-program`

Potential external upgrades:
- campaign analytics
- product analytics
- lifecycle automation packs

### `conversion-engineer`
Primary skills:
- `copywriting`
- `copy-editing`
- `marketing-psychology`
- CRO skills

### `retention-specialist`
Primary skills:
- retention and lifecycle skills currently in repo

### `social-strategist`
Primary skills:
- `social-content`
- launch and distribution skills

### `analytics-architect`
Primary skills:
- `analytics-architect`
- `analytics-tracking`

## Infrastructure / Operations
### `devops-engineer`
Primary skills:
- `devops-engineer`
- `release-manager`
- `finishing-a-development-branch`

Potential external upgrades:
- CI/CD pipeline builder
- observability designer
- incident commander
- env secrets manager
- terraform patterns

### `release-manager`
Primary skills:
- `release-manager`
- `verification-before-completion`

Potential external upgrades:
- changelog generator
- release readiness automation

### `experimentation-engineer`
Primary skills:
- `experimentation-engineer`
- `ab-test-setup`

## Legal / Finance
### `legal-counsel`
Primary skills:
- `legal-tos-privacy`
- `contract-review`
- `gdpr-compliance`
- `iso-42001-ai-governance`
- `open-source-license`

Potential external upgrades:
- privacy-policy
- terms-of-service
- regulatory domain packs where relevant

### `finops-manager`
Primary skills:
- `finops-manager`
- `saas-finops-optimization`
- `finance-based-pricing-advisor`
- `accounting`

Potential external upgrades:
- SaaS metrics coach
- financial analyst style packs

## Knowledge / Documentation
### `obsidian-architect`
Primary skills:
- `obsidian-cli`
- `obsidian-bases`
- `obsidian-markdown`
- `json-canvas`
- `defuddle`

Future responsibilities:
- founder report assembly
- project memory dashboards
- department summary rollups

## Current Priorities
1. stabilize founder-office mapping
2. audit engineering against external best-in-class repositories
3. audit growth stack against larger marketing libraries
4. define standard report outputs per department
5. identify orphan skills with no clear manager
