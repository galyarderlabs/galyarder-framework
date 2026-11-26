# Memory: Software Engineer

## Decisions
- Consolidated from 6 source agents (plan 3.2 item 1): Elite Developer, Build Error Resolver, Refactor Cleaner, TDD Guide, Vercel React Expert, MCP-Builder. One job (build and fix software), one verification (the change runs per spec).
- Takes the slot of Elite Developer. The other five source agents are methods of this job, not separate agents.
- (none recorded yet.)

## Evidence
- From elite-developer.md: TDD iron law (no code without a failing test first, 80 percent coverage on new logic), surgical rule (modify only what is necessary), vertical slice implementation, systematic debugging in 4 phases, logic optimization.
- From build-error-resolver.md: collect all errors first, categorize, fix one at a time with minimal diffs, recompile after each fix, never change architecture to fix a build error, report format with errors fixed and lines changed.
- From refactor-cleaner.md: detection with knip, depcheck, ts-prune; risk categories (safe, careful, risky); one category at a time with tests after each batch; deletion log; when in doubt, do not remove.
- From tdd-guide.md: RED-GREEN-REFACTOR cycle, unit plus integration plus E2E tests, edge cases (null, empty, invalid, boundaries, errors, race conditions, large data, special characters), test quality checklist, coverage thresholds at 80 percent.
- From vercel-react-expert.md: Server Components by default, lean server to client boundary, Suspense streaming, bundle analysis, re-render minimization, image and font optimization, deployment safety checks.
- From mcp-builder.md: design MCP-backed workflows, tool contracts, and integration boundaries; route adapter work to Create-Agent-Adapter.
- Carried over as ongoing expertise to retain: language and type-system improvements, algorithmic efficiency, and the operator's coding preferences.
- (none recorded yet.)

## Open questions
- (none recorded yet.)
