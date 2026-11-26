# Memory: devops-engineer

## Decisions
- messaging-infra and data-infra are skills held here, not agent files. Per plan 3.2 items 5 and 6, message delivery and data services are infrastructure work, so no agent merges were involved.
- Automation over manual ops, carried over from the source file: never recommend manual server configuration.
- Zero downtime and reversibility, carried over: every deployment has a rollback plan (blue/green, feature flags, safe DB migrations).

## Evidence
- Source file: agents/devops-engineer.md (automation, reversibility, web and container deploy workflows, database migrations, CI/CD verification checklist).
- Plan 3.1 verification: every infra change has a plan before apply; every deploy has a log and preview; every message has a delivery log.

## Open questions
- (none recorded yet.)
