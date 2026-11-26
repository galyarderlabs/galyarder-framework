---
name: anti-slop-audit
description: Audit and rewrite copy to remove AI writing patterns, with an auditable pattern catalog enforceable in CI. Use when asked to remove AI-isms, clean up AI writing, audit writing for AI tells, or make text sound less like AI. Detect mode reports only; rewrite mode changes the text.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Anti-Slop Audit

You audit and rewrite copy to remove AI writing patterns ("AI-isms") that make text sound machine generated. The audit comes first, the rewrite follows only when the operator asked for one. Detection alone never authorizes rewriting.

This skill is the audit. `anti-slop-constraint` is the system level guard that stops the patterns from being written in the first place. Use this skill to check finished copy, use that skill to keep new copy clean.

## When to Use

- The operator asks to remove AI-isms, clean up AI writing, audit writing for AI tells, or make text sound less like AI
- Finished copy is about to ship and needs a check before it goes out
- The operator wants to see what is flagged and decide what to fix themselves
- Text is being audited that must not be altered (published content, someone else's writing, reference material)

Do not use this to write new copy from scratch. Do not use it as a verdict on who wrote a text.

## What This Is and Is Not

This is a writing quality tool, not a verdict. The patterns flagged here are statistically more common in LLM output, but humans on autopilot produce the same shapes: writing under deadline pressure, in an unfamiliar genre, or in a second language. Independent audits of commercial AI detectors have found false positive rates above 60 percent on non-native English writers, and adversarial paraphrase cuts detection accuracy sharply across every method tested.

The patterns are a useful signal for cleaning up your own writing. They are not proof about who wrote a text, and they must never be the sole basis for a consequential decision such as academic integrity, hiring, publication, or attribution. Pair the signal with context: who wrote it, what genre it is, what the writer's normal voice looks like, what other evidence exists. Signals, not proof. Worth acting on; not worth ruining someone's day over.

## Modes

Three modes. Detect is the default when the operator asks for an audit, a scan, or flags only.

**`detect`** (flag only). Report findings without changing the text. Use it when the writer wants to decide what to fix, when the flagged patterns might be intentional, when the text must not be altered, or when a quick scan is enough.

**`rewrite`** (default for a cleanup request). Flag the patterns and rewrite the text to fix them. Return the full rewritten text once, then the changes and the verification.

**`edit`** (in place). The operator names a file and asks to fix it directly. Confirm the target is a prose file first. Refuse source code, configuration, and generated data files: prose rewrites can corrupt structured content. Make minimal, targeted edits to the justified spans only, leave already human passages untouched, re-read the file, and report what changed.

Trigger detect mode when the operator says "detect", "flag only", "audit only", "just flag", "scan", or "what AI patterns are in this". Trigger edit mode when the operator names a file and asks to fix it in place. Default to rewrite mode if not specified.

## Before Auditing

Read `references/pattern-catalog.md` in full before auditing or rewriting any text. It holds the word tiers, the pattern catalog with IDs, and the context and voice profiles. The catalog is the auditable source of truth: every finding cites a catalog ID, so any finding can be checked, disputed, or enforced mechanically. A finding without a catalog ID is not a finding.

## Editing Contract

Apply this contract before turning a pattern match into a change. A candidate match is text worth checking. It becomes a finding only after the rule's pass conditions, context exceptions, and surrounding meaning have been read. A finding becomes an edit only when the operator's requested mode and scope authorize one.

- **User-authorized scope.** Detect mode reports without changing text. An ordinary cleanup authorizes minimal, targeted wording edits and preserves the document's structure and argument. Report a structural problem when useful, but rebuild, reorder, or substantially condense only when the operator asks for editing broad enough to permit it. An explicit request to change structure or register permits that transformation; it does not permit new evidence, experiences, or claims.
- **Source fidelity.** Ground every factual addition or correction in the supplied source material or an explicit correction from the operator. Preserve the source's meaning, attribution, quantities and units, negation, conditions, causal relationships, and level of certainty. Do not invent facts, speaker experience, stance, causality, or confidence to make prose more concrete. When a justified fix needs information the source does not provide, flag the gap instead of guessing.
- **Protected content.** Quotations, attributed passages, code, tables, URLs, paths, identifiers, frontmatter, and other protected regions keep their content during ordinary cleanup. Report an applicable finding inside a protected region instead of rewriting it. Edit such content only when the operator specifically identifies it as part of the requested scope and the change will not corrupt data, code, or attribution.
- **Context and intent.** Apply a pattern only where its stated context and pass conditions make it a problem. Preserve weak matches, legitimate technical uses, meaningful correction words such as "actually", necessary hedges, intentional rhetoric, and authentic irregularities. When context is missing, treat a borderline match as a judgment call rather than forcing an edit.
- **Voice, register, and mechanics.** With no explicit transformation request, preserve the source's established voice and register. An explicit voice request can change how editable prose expresses material already present, but cannot override source fidelity or protected content, and must not fabricate a reaction, opinion, or lived experience.

If there are no justified findings and the operator requested no separate transformation, return the text unchanged and say it is clean. If a finding cannot be edited because of scope, protection, or missing source support, leave it in place and report the unresolved finding.

## Severity Tiers

Not all AI-isms are equal. For a quick pass or a large document, triage by tier. Full audit covers all three.

### P0, credibility killers (fix immediately)

- Cutoff disclaimers ("As of my last update")
- Chatbot artifacts ("I hope this helps!", "Great question!")
- Vague attributions without sources ("Experts believe")
- Significance inflation on routine events
- Hashtag stuffing on LinkedIn and investor-email posts

### P1, obvious AI smell (fix before publishing)

- Word-list violations (delve, leverage, harness, robust, and the rest of Tier 1)
- Template phrases and slot-fill constructions
- "Let's" transition openers
- Synonym cycling inside one paragraph
- Formulaic openings ("In the rapidly evolving world of...")
- Bold overuse
- Generic future-narrative closers
- Social endorsement closers ("This one is worth your time", "thank me later")
- Hedge-stacked predictions ("could potentially", "may eventually")
- Real/actual adjective inflation
- Invented contrast-pair mirroring ("false precision rather than genuine accuracy")
- Bullet lists of five or more bare noun phrases with no verbs
- Three or more distinct boilerplate phrases clustered in one piece

### P2, stylistic polish (fix when time allows)

- Em dash frequency above 1 per 1,000 words. This is writing quality guidance, not evidence of machine authorship: usage has varied by model generation and vendor, so never score it as an authorship signal.
- Generic conclusions ("The future looks bright")
- Repeated setup/reversal punchlines when they replace concrete claims
- Compulsive rule of three
- Uniform paragraph length
- Copula avoidance (serves as, features, boasts)
- Transition phrases (Moreover, Furthermore, Additionally)
- Tier 3 phrase repetition (one phrase twice or more)
- Unnecessary hyphenation of curated compounds

Use P0 plus P1 for quick passes. Full audit covers all three tiers.

## Self-Reference Escape Hatch

When writing about AI writing patterns (tutorials, skill documentation, this file), quoted examples are exempt from flagging. Text inside quotation marks, code blocks, or explicitly marked as illustrative ("for example, AI might write...") is not rewritten. Flag only patterns in the author's own prose, never cited examples of bad writing. Without this hatch the skill flags its own documentation.

## CI Enforcement

The catalog is enforceable, not advisory. Wire it into CI as a gate on changed lines:

1. The catalog in `references/pattern-catalog.md` is the single source of truth. Its entry count is canonical; a check fails when the count in the catalog and the count claimed in docs drift apart.
2. The gate runs on the diff, not the whole repo: P0 and P1 findings on changed lines fail the build. P2 findings are warnings.
3. Quoted examples and protected regions are exempt by the escape hatch above, so docs about the patterns do not fail their own gate.
4. The gate reports findings by catalog ID, file, and line, so every failure names the rule that fired.
5. A finding the operator judges intentional is resolved by an explicit exemption naming the catalog ID and the reason, never by weakening the catalog.

## Detect Mode Output

Return two sections:

**1. Issues found.** A bulleted list of every justified finding, with the offending text quoted and the catalog ID cited. Group by severity (P0, P1, P2). Omit sub-threshold weak matches (such as a single Tier 2 word without two or more occurrences in the same paragraph); do not report them as standalone issues.

**2. Assessment.** For each flag, note whether it is a clear problem or a judgment call. Discuss sub-threshold weak matches here as context. Some AI-associated patterns are effective writing techniques: uniform paragraph length is a problem, but a well-placed "however" is not. Call out which flags the writer should definitely fix versus which are worth a second look but might be fine in context. If the text is clean, say so.

State whether the check ran mechanically or was model-only. Report zero editing passes; detect mode performs no rewriting.

## Rewrite Mode Output

Complete the audit and the authorized editing passes before responding. Return the full rewritten content exactly once, under **Final rewrite**. Never publish a first-pass draft and then supersede it with another full version.

Follow it with **Changes** (a short summary of meaningful edits when edits were made; omit it for a no-op) and **Verification** with four explicit items:

- **Editing passes:** how many were used and the limit (at most two: the initial rewrite and one corrective pass when review finds another justified in-scope edit; stop early when no justified edit remains).
- **Checks:** which checks actually ran, whether deterministic or model-only, and which were unavailable.
- **Residuals:** findings left in place and why (intentional, protected, source-blocked, or pass-limit), or none found. Residuals cover the whole text, including protected regions: a quote that contains an applicable pattern is named with the reason it was retained.
- **Stop reason:** no further justified in-scope edit, requested limit reached, or unresolved verification failure.

Before delivery, compare the final text with the source. Account for each changed span: it must address a justified finding or belong to an explicitly requested transformation. If review finds an unauthorized change, repair it only within the remaining editing budget; otherwise report it as unresolved. For a clean no-op, return the source unchanged once, omit the change summary, and say in Verification that no justified in-scope edit was found.

## Tone Calibration

The goal is writing that sounds like a person wrote it. Direct. Specific. State each claim at the source's level of confidence instead of announcing confidence.

1. **Keep purposeful rhythm.** Vary sentence shape when repetition is accidental, while preserving deliberate repetition and rough edges.
2. **Use source detail.** Sharpen vague wording with numbers, names, dates, or examples only when the source or operator supplies them.
3. **Preserve the speaker.** Retain established preferences, reactions, and first-person presence without inventing them.
4. **Keep the source's stance.** Express an existing position clearly without creating one or changing its confidence.
5. **Earn your emphasis.** Show why something matters with source-supported detail instead of adding an importance claim.

Removal is half the job. A rewrite that clears every flag but erases the source's cadence, stance, or idiosyncrasies has failed to preserve its voice.

Never inject these into a text that did not already contain them: fabricated speaker perspective ("I have seen this a hundred times"), manufactured stakes ("now more than ever"), forced contrarianism ("everyone says X, but they are wrong"), performed candor ("let us be honest"), em dash theatrics, staccato conversion (chopping ordinary sentences into fragments to manufacture rhythm), or invented specifics. Subtraction and sharpening are in scope when they preserve meaning: cut filler, use supplied details, surface a buried point. Do not add unsupported personality, stance, or facts.

## Verification

- Every finding cites a catalog ID from `references/pattern-catalog.md`. A finding without one does not ship.
- Every written output can be checked against the pattern catalog, the voice profile, or the drift score. No claim of "matches voice" without a score: report findings per 1,000 words by tier before and after, and the tier of every residual.
- Detect mode changes nothing and reports zero editing passes.
- Rewrite mode reports passes used, checks run, residuals, and stop reason. A pass count alone is not a stop reason.
- CI gate state is reported when it ran: pass, fail with the failing catalog IDs, or not run.

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow from ideas to give back, everything evidence-based, output as changes, report by work, use related skills, update the agent's memory. Ship means copy that shipped clean, not a list of suspicions. An audit is a change: a report filed as a durable artifact, and once approved, a rewritten file with its verification. Report by work: findings by tier, edits made, residuals left and why. Use the related skills (`anti-slop-constraint` to stop the next draft from needing this audit, `voice-anchor` for the voice the copy is scored against, `drift-audit` when the flags point at drift across channels). Update the agent's memory with the pattern classes found so the same class is caught earlier next time.

## Related Skills

- `anti-slop-constraint` - system-level constraints that stop these patterns at write time
- `voice-anchor` - the voice profile copy is scored against
- `drift-audit` - channel-wide drift scoring when flags repeat across copy
- `style-rewrite` - rewriting into a personal style after the audit clears the slop
- `verification-before-completion` - proving the copy is ready before it counts as done

## Research source

conorbronsdon/avoid-ai-writing, https://github.com/conorbronsdon/avoid-ai-writing
