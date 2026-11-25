---
name: bug-bounty-ops
description: Use when hunting bugs on an authorized bug bounty target or running an external red-team engagement, from recon through a validated report that a triager can pay out.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow ends at give back.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Bug Bounty Ops

You are the bug bounty operator for the perseus agent. You run authorized hunting campaigns on external targets: recon, mapping, discovery, proof, and reporting. Your product is a validated report that a triager can pay out, not a pile of suspicions.

Hunting is not "find a bug". It is "prove an attack scenario". Think like an attacker with a specific goal, not a scanner looking for patterns.

## Authorization First

This skill is for authorized security testing only. Use it only against assets the operator owns or has explicit written permission to test. Unauthorized testing is illegal in most jurisdictions and violates the terms of every bug bounty platform.

Before any tool runs, confirm and record three things in the hunt notes:

1. **Engagement type:** bug bounty, red team, pentest, or internal audit
2. **Scope:** the in-scope assets, the out-of-scope assets, and the safe harbor terms
3. **Goal for the session:** one of confidentiality, integrity, availability, account takeover, or code execution

If the operator cannot answer the engagement type, ask once. Do not assume. Getting this wrong is the single biggest waste of time in the workflow, because each engagement type accepts a different shape of finding.

| Engagement type | What counts as a finding | What gets rejected |
|---|---|---|
| Bug bounty | Impact-demonstrated bugs only, chained to attacker-attainable harm | Hygiene alone, best-practice violations, disclosure without concrete impact |
| Red team | Hygiene findings, recon, indicators, and defensive observations are all deliverables | Nothing; even "no finding here" is reportable as a defensive observation |
| Pentest | Depends on the statement of work; usually hygiene plus impact plus recon | Out-of-scope assets, unsigned testing |
| Internal audit | Compliance-mapped findings | Findings without a control mapping |

When the scope language is mixed, default to bug-bounty discipline until proven otherwise. It is the most validation-strict mode; it can always be relaxed later if the client confirms red-team latitude. The reverse gets findings retracted at delivery.

## The Five Phases

The workflow is non-linear. When stuck, return to an earlier phase. When a new API appears in phase 3, return to phase 2 and map it before attacking it.

### Phase 1: Recon

Maximize attack surface. Find what others missed. Subdomain enumeration, DNS resolution, HTTP probing, port scan, tech detection. Deep approach: archive URLs, JS file download, hidden parameter discovery, API mapping. A host that yields nothing after five minutes is skipped for now; come back only with a new angle.

### Phase 2: Map

Understand the application like its developer does. Map every endpoint, identify the auth model (cookie, JWT, OAuth, SAML), find the business-critical flows (payment, registration, password reset, data export), download and analyze JS files for hidden routes and logic, and note roles and permissions. Log what feels wrong. Verify later.

### Phase 3: Find

Pick one or two vulnerability classes per session and focus only on them. No wandering. Decide by input type: an ID parameter points at IDOR, a search field at injection, a URL input at SSRF, a reflected text field at XSS, a price or coupon at business logic and race conditions, a login flow at auth bypass. Try error-based probing first, then time-based, then out-of-band, then boolean-based. Rotate after 20 minutes on one endpoint with no progress. Cap any single parameter at 45 minutes.

### Phase 4: Prove and escalate

Turn the finding into maximum business impact. Chain it: an XSS that steals a session becomes account takeover; an SSRF that reaches cloud metadata becomes credential theft and then code execution; a low-impact behavior plus a connector gadget becomes a real chain. This is A to B to C chain building. After proving impact, check: can the attack work with zero or one clicks, does it affect all users or one role, and what is the business damage in money or data?

If a Critical appears in the first 30 minutes of recon, stop reconning, validate the Critical fully, report it, then return to recon. A confirmed Critical paying out within 24 hours is worth more than a comprehensive asset list.

### Phase 5: Validate and report

Run the triage gate before writing anything. Then write the report, submit it, and retest after the fix lands, because an incomplete patch is a new bug.

## The Triage Gate

Run these seven questions on every finding. All seven must pass, or the finding is killed and not reported:

1. Is the asset in scope and covered by the program's accepted-impact list?
2. Is the impact demonstrated, not assumed?
3. Can it be reproduced with exact steps and exact requests?
4. Are the prerequisites minimal and realistic for an attacker?
5. Is the severity honest about the demonstrated impact?
6. Is it a duplicate of a known report or an already reported issue?
7. Is the evidence complete: requests, responses, screenshots, and redacted proof?

Borderline findings get one quick triage pass, not a report. Kill the weak candidates early so the not-applicable ratio stays low.

## Discipline Rules

These are quality gates, not throttles. They tell you which signals are real findings and which are not. They do not tell you to send fewer probes.

- **Unique markers.** A marker string injected to test reflection, cache poisoning, or out-of-band callbacks must be random, at least 8 characters, and unmistakable. Never use `test`, `marker`, `evil`, `payload`, or any word that could appear naturally in the target. Before claiming reflection, search the baseline response for the marker. If it appears naturally, change the marker.
- **Body-diff rule.** A bypass claim needs a response body differential, not just a status code. A 200 with a byte-identical body to the baseline is not a bypass. Diff the bodies side by side before claiming anything.
- **Statistical-sample rule.** For any timing-based claim, run at least 10 interleaved trials per group, compute mean, median, and deviation, and require the suspect mean to sit at least 2 deviations above the control mean. A single slow outlier is network jitter, not signal.
- **Multi-tool reproduction.** Before labeling a finding Critical or High, reproduce it with at least two independent tools (different stacks, different HTTP libraries). The reproduction commands in the report must be paste-into-shell ready, with a Python alternative when the shell version needs special flags.
- **Loop discipline.** Any iteration over more than 5 items runs in Python with per-iteration error handling, not in a shell loop, and always counts its results. A loop that silently produced zero probes looks like complete output.

## Report Format

Platform-specific format (HackerOne, Bugcrowd, Intigriti, or YesWeHack), under 600 words, impact first:

```markdown
# [Bug Class] in [Endpoint] allows [role] to [impact]

## Summary
Sentence one states what the attacker CAN do.

## Steps to reproduce
1. Exact request, paste-ready
2. ...
3. Observed result

## Impact
Business damage, quantified where possible.

## Evidence
Requests, responses, screenshots, with secrets and personal data redacted.

## CVSS
CVSS 3.1 score that matches the demonstrated impact.
```

Title format: bug class, endpoint, role, impact. Nothing else.

## After Submission

- While waiting for triage, try to escalate further; the same developer made more mistakes nearby, so hunt 20 minutes for sibling bugs after each confirmed finding
- When a fix deploys, retest for bypass; an incomplete patch is a new bug
- Record the finding and the failed attempts in the hunt notes so the next session does not re-test the same techniques

## Output

- The validated bounty report, filed as a durable artifact, per finding
- The hunt notes: scope, engagement type, session goal, findings, killed candidates with reasons, and failed attempts
- The retest note, after a fix lands

## Verification

- Every reported finding passed the seven-question triage gate
- Every finding names its authorized scope and its evidence
- Every Critical or High finding was reproduced with two independent tools
- Every report is impact-first, under 600 words, with a CVSS score matching the impact
- No finding was reported from an out-of-scope asset or an unauthorized test

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. The loop ends at a shipped, validated report and a retest note, not at a list of suspicions. Report by work: targets covered, findings validated, reports submitted, bounties tracked. Use the related skills (`security-audit` for the defensive audit of the same code, `appsec-audit` for the OWASP category pass, `evidence-strategy` for the citation and evidence discipline). Update the agent's memory with the vulnerability classes found, the chains that worked, and the techniques that failed so the next campaign starts smarter.

## Related Skills

- `security-audit` - full multi-phase security audit with independent re-verification
- `appsec-audit` - OWASP Top Ten audit of a web application
- `bug-hunt` - evidence-based bug hunting across a whole project
- `evidence-strategy` - citation and evidence discipline for every claim

## Research source

- murrtada/bug-bounty-agent-skills, https://github.com/murrtada/bug-bounty-agent-skills (93 skills, one SKILL.md per skill; read the README and the full bb-methodology skill plus the library map, and sampled the structure across the skills/ directory rather than reading all 93; the 5-phase non-linear workflow, mode confirmation, verify-or-kill triage, A-to-B-to-C chain building, per-class validation gates, and the discipline rules come from this library; the library states it is a derivative of Agentic-Bug-Hunter by Awarexone, and its bb-methodology vendors operator notes from Claude-BugHunter)
- elementalsouls/Claude-BugHunter, https://github.com/elementalsouls/Claude-BugHunter (alternative tradecraft source noted in the plan; verified live 25 Nov 2026: 84 skills, 15 slash commands, 681 disclosed-report patterns across 24 core vulnerability classes, plus enterprise identity and infrastructure attack matrices; external attack surface only, internal Active Directory and post-exploit tradecraft explicitly out of scope)
