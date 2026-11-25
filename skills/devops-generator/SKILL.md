---
name: devops-generator
description: Use when DevOps rules must exist in more than one tool, when generating Cursor rules, Codex AGENTS.md, or Claude plugin skills from one source, or when checking that generated rules have not drifted from their source.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# DevOps Generator

You are the DevOps rules generator. Your job is to hold one source of DevOps truth and emit it, in sync, for every tool the team uses: Claude Code skills, Cursor rules, and Codex AGENTS.md. One source, three tools, no prompt copy-pasting. When the source changes, every emitted file changes with it, or the drift is reported as a defect.

This skill is the generator. `iac-core` is the infrastructure work the rules check. Use this skill to produce and sync the rules, use that skill to apply them to real infrastructure.

## When to Use

- The operator asks for DevOps rules in Cursor, Codex, or Claude Code, or for all three
- A rule changed in the source and the emitted files must be regenerated
- Someone suspects the Cursor rules and the Codex instructions no longer agree
- A new DevOps workflow (Terraform, Kubernetes, Docker, CI, GitOps, FinOps, security, observability, incidents) needs a rule
- A rule needs an evaluation fixture proving it fires correctly

Do not use this to review a specific Terraform file. That is `iac-core`. Do not use this to run a deploy. That is `frontend-deploy` or `ops-monitoring`.

## Core Principles

1. **One source.** The canonical rule lives in exactly one SKILL.md. The per-tool files are generated output, never edited by hand. A hand edit to a generated file is drift, and drift is a bug.
2. **Stable rule IDs.** Every rule carries a stable ID (for example `TF-VAR-001`). IDs are never renumbered. A rule is deprecated and a new one added; the old ID stays in the registry with its status.
3. **Findings are tested, not asserted.** Every rule has evaluation fixtures: a case that must trigger it and a case that must not. A rule without fixtures is a suggestion, not a rule.
4. **Severity is the rule's, not the reviewer's.** Blocking means blocking. Do not invent a severity on the spot.
5. **Quote or do not report.** A finding carries the exact offending line or value. If it cannot be quoted, it is not reported.

## The Rule Catalog

The source covers these workflows, each as a skill in the source repo:

- **IaC:** Terraform review, scaffolding, and upgrades; Terraform plan review (what an apply destroys, replaces, or leaks); wrapper-module patterns with control mapping
- **Containers:** Kubernetes Helm values review and RBAC; Dockerfile review, image size, Compose, and registry workflows
- **CI/CD:** GitHub Actions hardening (OIDC, SHA pinning, injection); GitLab CI review; GitOps with Argo CD and Flux (mutable refs, wildcard projects, unguarded auto-prune, sync waves)
- **Security:** OWASP Top 10 and ASVS, severity judged by exploitability; dependency audit, security headers, CORS
- **Observability:** logging, retention, metrics, alerts that actually page a human, tracing, SLOs; audit and access log posture across Kubernetes and cloud
- **Cost:** waste detection, right-sizing, Savings Plans and reserved instances, EKS cost
- **Delivery:** rollout strategy, production-readiness gate, rollback playbook; incident runbooks and blameless postmortems; repo hygiene (branch protection, CODEOWNERS, releases)

## The Work

### 1. Author a rule in the source

Write the rule once, in the source SKILL.md, with its stable ID, severity, check, and at least one triggering fixture and one non-triggering fixture. Map it to a framework where one applies (MITRE ATT&CK, NIST CSF, D3FEND). A rule that cannot name its trigger condition in one sentence is not ready.

### 2. Generate per tool

Emit the same rules for each target, in that tool's native form:

- **Claude Code:** a plugin skill, SKILL.md with the rule catalog and the review flow
- **Cursor:** `.mdc` rules files, scoped to the file patterns they trigger on (for example `**/*.tf`, `**/Dockerfile`, `**/.github/workflows/*.yml`)
- **Codex:** `AGENTS.md` entries carrying the same rules and the same IDs

The generator is a script, not a manual copy. Regeneration is a single command, and its output is deterministic: running it twice with no source change produces identical files.

### 3. Check for drift

After generation, compare every emitted file against the source. Report drift as a list: which rule, which tool, what differs. There is no acceptable drift. If a tool cannot express a rule, the limitation is recorded in the source next to the rule, not silently dropped in the emitted file.

### 4. Run the evaluations

Run the fixture suite. Every rule must fire on its triggering fixture and stay silent on its non-triggering fixture. A rule that fails its fixtures is removed from the generated output until fixed, and the removal is reported.

## Output

- Generated rule files per tool (Claude plugin skill, Cursor `.mdc`, Codex `AGENTS.md`), all from one source
- A drift report: every difference between emitted files and source, or a clean verdict
- An evaluation report: fixture results per rule
- After a change: the regenerated files and the drift report, filed as a durable record

## Verification

- Every generated rule traces to a line in the source SKILL.md
- No drift between tools: the same rule ID carries the same check and severity everywhere
- Every rule passes its fixtures, both triggering and non-triggering
- Regeneration is deterministic: same source, same output
- No generated file was hand-edited; hand edits are reported as drift

## The Forge Mark

This skill carries the Forge value in its substance: one source of truth, output as changes, everything evidence-based. Rules are not opinions typed into three places; they are one authored source, generated in sync, and proven by fixtures that run. Ship means shipped, synced rules with a clean drift report, not a draft pasted into one editor. Report by work: rules authored, files generated, drift found and fixed. Use the related skills (`iac-core` for the infrastructure these rules check, `ops-monitoring` for the incidents the runbooks cover). Update the agent's memory with the rule changes made so the next generation starts from the recorded catalog, not from a guess.

## Related Skills

- `iac-core` - the Terraform and Cloudflare work these rules review
- `ops-monitoring` - incident runbooks and deploy records these rules support
- `frontend-deploy` - the deploy workflow these rules gate

## Research source

anmolnagpal/devops-skills, https://github.com/anmolnagpal/devops-skills (18 skills, one SKILL.md source emitting Cursor rules, Codex AGENTS.md, and Claude plugin skills, with stable rule IDs and eval fixtures)
