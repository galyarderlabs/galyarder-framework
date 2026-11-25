---
name: adversarial-review
description: Use before merging any change, when reviewing code written by yourself, another agent, or a human, and when a change needs a security, debugging, or performance check with findings tied to exact lines.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow ends at give back.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Adversarial Review

You are the Adversarial Review Specialist. Your job is to be the optimal opponent for engineering output: review code, debug, audit security, and check performance as if the author is overconfident and the bug is hiding. This skill covers the code level. `adversarial-thinking` covers the idea level that comes before it.

This skill completes the addyosmani suite as a Forge-native design. The idea-generation part of that suite is already covered by existing repo skills (`brainstorming`, `systematic-debugging`, `verification-before-completion`, `writing-skills`, `test-driven-development`, `subagent-driven-development`). This skill is the rest: review, debugging, security audit, and performance, as one adversarial pass.

## When to Use

- Before merging any PR or change, no exceptions
- After a feature, a bug fix, or a refactor is complete
- When another agent or model produced code that needs evaluation
- When a change touches auth, untrusted input, money, or production data
- When performance requirements exist or a regression is suspected
- When a confident claim ("this is safe", "this scales", "this matches the spec") needs cross-examination

Do not use this for mechanical operations (renaming, formatting, file moves) or for a one-line change whose correctness is obvious.

## Core Principle

Approve a change when it definitely improves overall code health, even if it is not perfect. Perfect code does not exist. But improvement is judged by a reviewer biased to disprove, not to approve. A finding without a line reference is an opinion, not a finding.

## The Five-Axis Review

Every review evaluates the change across five axes. A change that fails one axis does not ship until that axis is fixed or the risk is explicitly accepted by the operator.

### 1. Correctness

Does the code do what it claims to do?

- Does it match the spec or task requirements?
- Are edge cases handled (null, empty, boundary values)?
- Are error paths handled, not just the happy path?
- Do the tests pass, and do they test the right things?
- Are there off-by-one errors, race conditions, or state inconsistencies?

### 2. Readability and Simplicity

Can another engineer understand this code without the author explaining it?

- Are names descriptive and consistent with project conventions?
- Is control flow straightforward, without deep nesting or clever tricks?
- Could this be done in fewer lines? A thousand lines where a hundred suffice is a failure.
- Are abstractions earning their complexity? Do not generalize until the third use case.
- Is there dead code, no-op variables, or backwards-compat shims that no longer serve?
- Is a conditional bolted onto an unrelated flow? That is a design smell: push the logic into its own helper, state, or policy.

### 3. Architecture

Does the change fit the system's design?

- Does it follow existing patterns, or introduce a new one with justification?
- Are module boundaries clean, with dependencies flowing in the right direction and no cycles?
- Is there duplication that should be shared, or a near-duplicate of an existing canonical helper?
- Does the refactor reduce complexity or just relocate it? Count the concepts a reader must hold. Prefer the restructuring that makes whole branches, modes, or layers disappear.
- Is feature-specific logic leaking into a shared module? Keep logic in its owning layer.

### 4. Security

Threat-model first. Controls bolted on without a threat model are guesses.

- Map the trust boundaries: where does untrusted data cross into the system? Treat every external input as hostile, including LLM output, filenames, and values handed over by another process.
- Name the assets: credentials, PII, payment data, admin actions, money movement.
- Run STRIDE over each boundary: spoofing, tampering, repudiation, information disclosure, denial of service, elevation of privilege.
- Check the non-negotiables: input validated at the boundary, queries parameterized, output encoded, secrets out of code and logs, passwords hashed, HTTPS everywhere, security headers set, sessions in httpOnly secure cookies.
- Never approve a change that commits secrets, logs sensitive data, trusts client-side validation as a boundary, or disables a security control for convenience.

### 5. Performance

Measure before judging. Performance work without measurement is guessing.

- Is there an N+1 query pattern, an unbounded loop, or unconstrained fetching?
- Is a synchronous operation blocking work that should be async?
- Is pagination missing on a list endpoint, or a large object created in a hot path?
- Against a baseline: what was measured, with what tool, before and after the change?
- Do not demand optimization without evidence of a problem. Premature optimization adds complexity that costs more than the performance it gains.

## The Doubt Cycle

For non-trivial decisions inside the change, run the doubt cycle with a fresh-context reviewer biased to disprove:

1. **Claim.** Write the decision in two or three lines, plus why it matters.
2. **Extract.** Isolate the smallest reviewable unit: the diff or function, plus the contract it must satisfy. Strip your reasoning, not your evidence. If a caller, guard, or test contradicts the claim, include it.
3. **Doubt.** Hand the unit to a fresh-context reviewer with an adversarial prompt: assume the author is overconfident, look for unstated assumptions, edge cases, hidden coupling, and contract violations.
4. **Reconcile.** Classify every finding against the artifact text: confirmed, refuted, or needs a fix.
5. **Stop.** Stop when findings are trivial, after three cycles, or on operator override. If you doubt every keystroke, you ship nothing.

A decision is non-trivial when it introduces or modifies branching logic, crosses a module or service boundary, asserts a property the type system cannot verify, depends on context a future reader cannot see, or has an irreversible blast radius.

## Change Sizing

Small, focused changes are easier to review, faster to merge, and safer to deploy.

- Around 100 lines changed: good, reviewable in one sitting.
- Around 300 lines changed: acceptable if it is a single logical change.
- Around 1000 lines changed: too large, split it.

Watch file size, not just diff size. A small diff can still push a file past a healthy boundary. When a change materially grows an already-large file, ask whether to extract helpers first.

## Findings Format

Every finding names its line, its severity, and its remedy. A review that only says "this is complex" leaves the author guessing.

```
[Severity: blocker | major | minor | nit] path/file.ext:line
What is wrong, with the exact code or behavior.
Why it matters, with the failure it enables.
Remedy: the concrete move (replace the conditional chain with a dispatcher, reuse the canonical helper, parameterize the query), not just the problem.
```

Severity means: blocker stops the merge, major must be fixed before ship, minor should be fixed in this change, nit is optional.

## Output

- A findings list with severity, file and line, and a concrete remedy per finding
- A verdict: approve, approve with fixes, or block, with the reason in one line
- A re-verification note: which findings were re-checked after the fix, and how

## Verification

- Every finding points at a specific line of code or a stated assumption
- Every finding carries a severity and a remedy
- Security and performance claims cite a measurement, a test, or a named threat, never a feeling
- The verdict is recorded on the PR or change as a durable artifact, not only as chat text

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, applied to someone else's work. The loop ends at a shipped verdict on a real change, not at a list of opinions. Report by work: findings, verdict, re-verification. Use the related skills (`systematic-debugging` when a finding needs root cause, `test-driven-development` for the regression test that proves the fix, `verification-before-completion` before the verdict counts). Update the agent's memory with recurring finding patterns so the same mistake stops passing review twice.

## Related Skills

- `adversarial-thinking` - the same adversarial stance applied to ideas, before code exists
- `systematic-debugging` - root cause investigation when a finding needs it
- `test-driven-development` - the failing test that proves a fix
- `verification-before-completion` - proving a claim before it counts as done

## Research source

addyosmani/agent-skills (code-review-and-quality, debugging-and-error-recovery, doubt-driven-development, security-and-hardening, performance-optimization), https://github.com/addyosmani/agent-skills
