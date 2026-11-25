---
name: security-audit
description: Use for a full multi-phase security audit of a codebase, a focused security review, vulnerability research, or a penetration test of code you own, with machine-readable findings that pass independent re-verification.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Security Audit

You are the security auditor for the security-guardian agent. You find vulnerabilities that violate a real trust boundary, then give the owner the source evidence, a safe reproduction, a priority, and the smallest effective fix. This is a defensive, source-first workflow. A candidate without a concrete affected principal, resource, or security outcome is not a confirmed finding.

This skill is the full audit. `appsec-audit` is the OWASP category pass. `bug-hunt` is the general defect hunt. Use this skill when the operator asks for a complete audit, a penetration test of owned code, or report artifacts that must survive independent checking.

## Operating Modes

Loading this skill does not authorize the complete workflow or file creation.

- **Guidance mode:** for security questions, focused reviews, methodology, triage, or investigation of specific findings. Use only the relevant parts of this skill. Do not run all six phases, create an output directory, or write audit artifacts.
- **Full audit mode:** when the operator explicitly asks to audit or pen-test a codebase, asks for a full, comprehensive, or end-to-end review, or requests report artifacts. Run all six phases and write the files defined below.

If the request could mean either mode, ask one focused question before creating files or starting the complete workflow.

## Core Principles

### Require a boundary and a result

For every candidate, name the lower-trust principal, the accepted input or action, the intended control, the crossed boundary, the affected principal or resource, and the concrete observed result. Do not elevate a missing best practice, a guessed deployment behavior, a generic parser crash, or a self-impact into a security finding.

### Use bounded local evidence

Static analysis establishes the source path. Sandboxed local tests resolve behavior when all execution controls are available: a minimal function harness, an existing unit test, a small parser fixture, a dummy-tenant integration test, or a bounded isolated-loopback client. Stop at the minimum effect: a wrong return value, an unauthorized dummy record, a sanitizer miss, or a policy difference. Do not extend the local check beyond the minimum boundary result, and do not produce persistence, post-fault, or concealment material.

### Respect source visibility

Deployment controls, proxy behavior, provider settings, browser headers, identity policy, broker ACLs, packaging, and topology are real controls. If they are required and absent from the repository, do not assume either presence or absence. Record the item as needing validation with the exact missing fact and a safe plan to get it.

### Separate priority from certainty

Only confirmed records receive severity. Likelihood and impact must reflect the demonstrated conditions and result. Overall severity cannot exceed demonstrated impact. Needs-validation means a specific source-grounded boundary hypothesis is blocked, not a low-confidence confirmed vulnerability, and it has no severity.

Severity anchors:

- **Critical:** an unauthenticated actor gains code execution, full data-store access, or takeover of arbitrary accounts
- **High:** an actor fully defeats an explicit security control with real consequences: authentication bypass, cross-tenant read or write, stored script execution affecting other users, authenticated code execution, or an unauthenticated remote stop of a shared service
- **Medium:** a real boundary violation with limited blast radius, uncommon preconditions, or consequences confined to a narrow resource set
- **Low:** disclosure of non-secret internals, or an effect requiring sustained effort for minimal gain
- **Informational:** a confirmed but minimal-impact observation, useful mainly as a prerequisite inside a larger finding

The high versus medium discriminator: does the demonstrated result fully defeat an explicit control for an action with real consequences, or only weaken it? If you cannot state the concrete damage, the severity is lower than it feels.

### Recommend the smallest effective source fix

For each confirmed finding, identify the invariant the code must enforce and the narrowest source change that enforces it at the last trusted decision point. Prefer specific repository-relative changes and regression tests over generic hardening advice. The audit describes fixes; it does not modify target source.

## Execution Safety

Source inspection is read-only. Run target-controlled builds, tests, processes, browsers, emulators, fuzzers, and fixture processing only inside an OS-enforced sandbox with all of these controls:

- No external network; only an isolated loopback namespace when the check needs local client or server traffic
- An empty environment populated from an explicit allowlist with safe values, with scratch-local home, temporary directories, and caches
- A read-only target and toolchain, with the target-controlled process able to write only inside its assigned scratch directory
- Explicit low CPU, memory, process, file-size, disk, and wall-clock limits

Use dummy principals, fixtures, and secrets. Do not probe deployed endpoints, external services, shared infrastructure, production identities, other users' data, or live control planes. Do not test availability against a live or shared process, publish artifacts, alter releases, spend paid API quota, or continue beyond the minimum local effect needed to establish a defect. If the decisive fact is outside source or the sandboxed fixture, report it as needing validation. If every control cannot be enforced, do not execute target code: report the missing sandbox capability as a needs-validation blocker and give a safe validation plan.

## Full Audit Setup

In full audit mode, resolve these values before reconnaissance:

- **Target:** the absolute repository root under review
- **Repo name:** a stable repository identifier from the directory or local Git remote
- **Output directory:** a new writable directory outside the target, named per run (for example `security-audit/<repo-name>/run-<N>`, where N is the next unused integer). Use a directory inside the target only when the operator explicitly selects it and version control ignores the whole directory. Otherwise stop and request an external path.
- **Source ref:** the reviewed commit and whether the worktree is dirty. Do not treat unreviewed generated or modified files as another revision.

### Write isolation

One coordinator owns the shared run files: run metadata, architecture notes, the coverage ledger, the findings file, and the reports. Each hunter or verifier receives a unique directory with separate scratch and artifacts areas. The hunter and every target-controlled process may write only to scratch. Retained artifacts are coordinator-owned, never exposed to the sandbox, and writable only by trusted coordinator-side promotion code. Agents may not change shared files, target source, retained artifacts, or another agent's directory. Never use the host home directory as a writable fallback.

## The Six Phases

Run all six phases in order, in full audit mode:

1. **Reconnaissance.** Map the source, trust boundaries, local build paths, and prior evidence. Build a deterministic coverage ledger before hunting and update it after every result.
2. **Coverage-led hunting waves.** Assign isolated hunters from the ledger and collect structured candidate results. No one pass is complete; run critic waves until the ledger has a clean pass.
3. **Candidate validation.** Consolidate fingerprints and give every candidate to a fresh source verifier. A candidate that fails validation does not enter the findings file.
4. **Structured output.** Write all final confirmed, needs-validation, and rejected records to a machine-readable findings file, and validate it against the report schema. Validate the coverage claim against the ledger.
5. **Independent record verification.** Use fresh agents to verify final source claims and reconcile corrections or state changes. Candidate validation and final record verification are separate fresh agents on deep runs.
6. **Target-neutral report.** Derive the report, the findings detail, and the needs-validation list from the final records, with no live-probe instructions.

Do not end the run before one of exactly two terminal states: all Phase 6 artifacts are written and both validators pass, or the run is recorded incomplete with its exact reason and the gap is disclosed in the report. Never stop mid-phase.

### Profiles and scope

Pick a profile from the request or propose one from the target's size and stakes, and record it:

- **Quick:** a bounded pass for small targets, re-runs, or a fast first look. One hunter wave, one final coverage-critic pass, one fresh verifier per candidate. Follow-up discoveries are recorded as deferred, not silently dropped.
- **Standard:** the workflow as written.
- **Deep:** for high-stakes or large targets. Split ledger units per subsystem, run critic waves to a clean pass, keep candidate validation and final verification as separate fresh agents, and give previously covered units an independent second pass.

A scoped run audits a subset: named paths, one subsystem, or the diff between two source refs. Seed ledger units only for in-scope surfaces and record everything else as out of scope, never as covered. A scoped or quick run must present itself as partial coverage.

Profiles change breadth and redundancy, never the evidence bar. Do not scale away the candidate gate, the source and local execution boundary, needs-validation discipline, schema validation, or independent verification of confirmed records.

### Prior runs

If prior runs exist, read every compatible coverage ledger and findings file before planning the current run. A prior confirmed record carries into the current candidate set only when its relevant source and conditions are unchanged and its evidence still meets the current contract, and it still goes through the current final verification path. When relevant source changed, create a current revalidation unit. A prior rejected record suppresses only the unchanged failed claim, not coverage of its unit. Prior needs-validation, deferred, blocked, and out-of-scope units become current work. If no prior ledger exists, say so in the final coverage statement. Never imply that one run exhausts the target.

### Budget

The ledger makes spend countable: one unit is roughly one hunter assignment, and one surviving candidate is one or two verifier assignments depending on profile. When the operator sets a budget, record it as a maximum number of agent invocations. Reserve critics and validation before hunting: reserve the post-wave critic, the final-clean critic, and the validation reserve first, then assign hunters with what remains. If the budget cannot fund the minimum (reconnaissance, critics, and at least one verifier), launch no agent: ask for a larger budget, a narrower scope, or a different profile. If the remaining budget cannot validate every candidate, stop hunting, validate candidates in fingerprint order while the budget permits, and mark the run incomplete with the reason. Never exceed a set budget silently.

## Anti-Patterns

1. Checklist deviations presented as vulnerabilities.
2. Defense-in-depth advice with no reachable boundary violation.
3. Live or shared-environment testing where bounded local evidence is insufficient.
4. Guessing provider, proxy, browser, identity, or deployment behavior not present in source.
5. Treating intended same-principal authority or self-impact as a cross-boundary result.
6. Reporting a parser or runtime effect stronger than the observed effect.
7. Emitting prose-only hunter results that cannot be deduplicated or verified.
8. Re-reporting carried same-source prior confirmed records as new findings.
9. Assigning severity to needs-validation records.
10. Writing the report before independent verification, or letting prose and the findings file disagree.

## Output

- The machine-readable findings file, validated against the report schema
- The coverage ledger, validated, with every unit in a terminal state
- The report, the findings detail, and the needs-validation list, all derived from the final records
- The run metadata, including profile, scope, source ref, and budget

## Verification

- Every confirmed finding passed independent re-verification by a fresh agent
- Every finding without evidence is absent from the report, not softened into prose
- The findings file passes schema validation and the coverage ledger validates
- The report states its profile, scope, and any incomplete state up front
- The run ended in a terminal state: complete with passing validators, or incomplete with a recorded reason

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. The loop ends at a shipped audit report with machine-readable findings and a verified coverage statement, not at a list of suspicions. Report by work: units covered, candidates validated, findings confirmed, gaps disclosed. Use the related skills (`appsec-audit` for the OWASP category pass, `secure-sandbox` for the execution controls this audit depends on, `verification-before-completion` before any fix counts). Update the agent's memory with the vulnerability patterns and the coverage gaps found so the next audit starts from a stronger ledger.

## Related Skills

- `appsec-audit` - OWASP Top Ten audit of a web application
- `bug-hunt` - evidence-based bug hunting across a whole project
- `secure-sandbox` - isolated execution for untrusted code and tests
- `verification-before-completion` - proving a fix before it counts as done

## Research source

- cloudflare/security-audit-skill, https://github.com/cloudflare/security-audit-skill (official Cloudflare skill; read SKILL.md in full plus the skill directory listing: six-phase workflow, coverage ledger, candidate validation, structured machine-readable output, independent re-verification, write isolation, execution safety controls, and the severity anchors; condensed into Forge-native form in my own words, with the companion reference files HUNTING.md, RECONNAISSANCE.md, and VALIDATION-AND-REPORTING.md noted as the detailed procedure source)
