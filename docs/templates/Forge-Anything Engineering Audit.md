# Engineering Audit

## Purpose
Assess the state of the Engineering department in the whole system: how well architecture, implementation, tests, code quality, delivery, and refactoring hold together, and where they are weak.

## Scope
- Architecture and design
- Implementation
- Tests before anything ships
- Code review and quality
- Refactoring and upkeep
- Release readiness

## What is in place
- [ ] Lead agents for architecture and implementation are named and active
- [ ] Skill that enforces tests before new code ships
- [ ] Skill that guides systematic debugging
- [ ] Skill that asks for code review and acts on it
- [ ] Skill that closes out a development branch cleanly
- [ ] Skill that prepares a release
- [ ] Workflow that checks every claim against evidence before completion

## Gaps
- [ ] Tests are missing or skipped under pressure
- [ ] Debugging is ad hoc, with no written trail
- [ ] Review feedback is ignored or arrives too late
- [ ] Branches linger unfinished
- [ ] Technical debt has no owner and no plan
- [ ] Releases go out without a readiness check

## Next steps
- Pick the highest priority gap and name its owner
- Add or fix the missing agent, skill, command, or workflow for that gap
- Run the new piece on a real change and check the result against evidence
- Record the decision and the outcome in the decision log
- Repeat for the next gap
- Share the finished audit and the changes with the people who need them, so the work reaches distribution
