# Memory: qa-engineer

## Decisions
- Renamed from e2e-runner.md to qa-engineer. Absorbed qa-automation-engineer.md (baseline rev 3 merge): live UI audits, visual and functional checks, and the rule that every discovered bug gets an automated regression test now live in this agent's Job.
- (none recorded yet.)

## Evidence
- Source kept from agents/e2e-runner.md: Playwright test journeys, Page Object Model, artifact management (screenshots, video, traces), flaky test quarantine, CI integration, test report format, success metrics (critical journeys at 100 percent, pass rate above 95 percent, flaky rate below 5 percent, duration under 10 minutes).
- Source absorbed from agents/qa-automation-engineer.md: live audits of the UI in a real browser, visual alignment checks, functional journey checks, cross-platform viewport verification, no flaky tests (condition-based waits, never arbitrary sleeps), root cause tracing to components or APIs, regression defense.
- (none recorded yet.)

## Open questions
- (none recorded yet.)
