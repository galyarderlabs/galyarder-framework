# Galyarder Engineering Audit - Claude-Skills Benchmark

## Purpose
This note is the first external hiring audit for the Engineering department.

It uses the cloned `claude-skills` repository as a benchmark source to identify where Galyarder Engineering is already strong, where it is thin, and what should be hired next as imported or adapted skills.

## Current Situation In Galyarder Engineering
### Current strengths
Galyarder already has a strong engineering skeleton:
- `super-architect`
- `architect`
- `elite-developer`
- `qa-automation-engineer`
- `build-error-resolver`
- `code-reviewer`
- `refactor-cleaner`
- `vercel-react-expert`
- strong workflow law around TDD, debugging, review, and verification

### Current weakness pattern
The main weakness is not lack of engineering identity.
The weakness is lack of specialized depth in some subdomains compared to broader external libraries.

## Benchmark Domains Observed In Claude-Skills
From `claude-skills`, the relevant engineering benchmark areas include:

### Engineering domain examples
- `agent-designer`
- `agent-workflow-designer`
- `api-design-reviewer`
- `api-test-suite-builder`
- `ci-cd-pipeline-builder`
- `database-designer`
- `database-schema-designer`
- `migration-architect`
- `observability-designer`
- `performance-profiler`
- `pr-review-expert`
- `rag-architect`
- `release-manager`
- `runbook-generator`
- `skill-security-auditor`
- `spec-driven-workflow`
- `tech-debt-tracker`
- `terraform-patterns`

### Engineering-team domain examples
- `adversarial-reviewer`
- `playwright-pro`
- `incident-commander`
- `incident-response`
- `senior-architect`
- `senior-backend`
- `senior-frontend`
- `senior-fullstack`
- `senior-devops`
- `senior-qa`
- `senior-security`
- `tech-stack-evaluator`
- `a11y-audit`

## Hiring Assessment By Capability Area
### 1. Architecture
Galyarder status:
- strong core identity already exists
- still missing more specialized architecture worker depth

Potential hires:
- `senior-architect`
- `api-design-reviewer`
- `database-designer`
- `database-schema-designer`
- `migration-architect`
- `spec-driven-workflow`

Recommendation:
- hire selectively
- do not replace `super-architect` or `architect`
- use imported skills as worker units underneath existing architecture leads

### 2. Code Review And Quality
Galyarder status:
- good base review discipline already exists
- specialized review depth can be improved

Potential hires:
- `pr-review-expert`
- `adversarial-reviewer`
- `a11y-audit`

Recommendation:
- high priority
- these improve review precision without changing the overall Galyarder engineering identity

### 3. Test Automation
Galyarder status:
- has QA and E2E direction
- lacks obvious flagship depth compared with external libraries

Potential hires:
- `playwright-pro`
- `api-test-suite-builder`
- `senior-qa`

Recommendation:
- high priority
- test depth is a strong leverage area for the digital company model

### 4. DevOps / Infra / Release
Galyarder status:
- has `devops-engineer` and `release-manager`
- likely still thinner than best-in-class external engineering packs

Potential hires:
- `ci-cd-pipeline-builder`
- `observability-designer`
- `incident-commander`
- `incident-response`
- `terraform-patterns`
- `senior-devops`
- `runbook-generator`

Recommendation:
- high priority
- this is one of the best areas for external skill hiring

### 5. Performance / Technical Debt / Maintainability
Galyarder status:
- currently underdeveloped as an explicit engineering worker cluster

Potential hires:
- `performance-profiler`
- `tech-debt-tracker`
- `codebase-onboarding`
- `changelog-generator`

Recommendation:
- medium priority
- strong long-term leverage, but less urgent than review and infra depth

### 6. Agent Engineering / AI-Native Engineering
Galyarder status:
- has orchestration DNA, but not yet much explicit agent-engineering specialization in the engineering department

Potential hires:
- `agent-designer`
- `agent-workflow-designer`
- `skill-tester`
- `skill-security-auditor`

Recommendation:
- medium to high priority
- especially useful if Galyarder continues to evolve as a digital company with many agent-worker relationships

## Recommended First Engineering Hires
Top priority shortlist:
1. `playwright-pro`
2. `pr-review-expert`
3. `adversarial-reviewer`
4. `ci-cd-pipeline-builder`
5. `observability-designer`
6. `database-schema-designer`
7. `migration-architect`
8. `runbook-generator`
9. `tech-debt-tracker`
10. `a11y-audit`

## Import Strategy
### Import directly if:
- the skill is already strong and reusable
- it fits under an existing Galyarder department lead
- it does not conflict with the workflow constitution

### Adapt before importing if:
- it is useful but too generic
- the output contract needs founder-facing or Galyarder-specific tightening
- the host assumptions need cleanup

### Reject if:
- it adds breadth without leverage
- it duplicates current capability without meaningful gain
- it creates department ambiguity

## Proposed Owners For First Hires
- `playwright-pro` -> `qa-automation-engineer`
- `pr-review-expert` -> `code-reviewer`
- `adversarial-reviewer` -> `code-reviewer` and `security-reviewer`
- `ci-cd-pipeline-builder` -> `devops-engineer`
- `observability-designer` -> `devops-engineer`
- `database-schema-designer` -> `super-architect` / `architect`
- `migration-architect` -> `architect`
- `runbook-generator` -> `devops-engineer`
- `tech-debt-tracker` -> `elite-developer` / `refactor-cleaner`
- `a11y-audit` -> `qa-automation-engineer` / frontend stack

## Next Step
Turn this note into Linear issues for:
- first-wave engineering hires
- import / adapt evaluation
- ownership assignment
- host compatibility checks
