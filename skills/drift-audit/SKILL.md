---
name: drift-audit
description: Score copy across channels to detect pattern drift and run the voice test. Use when copy feels off-brand, when the voice has drifted across channels, or when asked to audit how the brand sounds.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Drift Audit

You score copy across channels to detect pattern drift: the slow slide where the brand stops sounding like itself. Voice is who you are; it does not change. Tone is how you show up in a specific moment; it shifts by buyer and channel, intentionally, not randomly. Drift is tone shifting without intent, or voice thinning out until any competitor could have written the same copy.

This skill is the audit. `voice-anchor` builds the profile this skill scores against. `anti-slop-audit` supplies the pattern flags that feed the score. Use this skill when the question is "are we still us", use those skills for the profile and the patterns.

## When to Use

- The operator says copy feels off, the brand sounds like everyone else, or asks for a voice audit
- Copy is being produced across three or more channels and nobody has checked whether it still matches
- A new persona, channel, or writer has joined and the voice needs verifying
- The operator asks "how should we sound on LinkedIn versus a sales deck" or "adapt tone for" a specific buyer

Do not use this to write the copy itself. Write the copy using this skill's report as input. Do not use this to build a voice profile from zero; that is `voice-anchor` setup, run first when the profile is thin.

## Inputs

- **The voice profile.** Load it from `voice-anchor` memory files, or from the brand voice guide if one exists. If no profile exists at all, say so once: the audit can still run, but the scores are against a profile built from the samples themselves, and the operator should run `voice-anchor` setup first for sharper results. No hard block.
- **The samples.** 5 to 10 recent copy samples across 3 or more channels (homepage, sales deck, outbound email, LinkedIn, thought leadership, talk tracks, customer comms, or whichever channels are actually in use). Samples the operator pastes work the same as samples pulled from a tool. 3 to 5 samples are enough for a quick audit; fewer than 3 is not an audit, it is a guess.
- **The personas.** For each buyer on the committee: what they care about, how they prefer information, what makes them distrust a vendor immediately, what makes them lean in. Never pre-fill a buying committee; every committee is different. If a recent persona mapping exists, load it instead of re-asking.

## The Voice Test

Build or load the one-sentence voice test before scoring anything:

"[Brand] sounds like [descriptor], always [consistent quality], even when [the tone shifts]."

Every persona profile and channel entry must pass this sentence before the guide ships, and every audited sample is judged against it. A sample that fails the sentence is drift, whatever its other scores say. The test is the anchor; the numbers below are the measurement.

## Scoring

Score each sample on the four tone dimensions per persona, each rated 1 to 5, against the profile target for that persona and channel:

| Dimension | What it measures |
|---|---|
| Formality | How formal the copy reads, from blunt plain speech to boardroom formal |
| Warmth | How human and approachable it feels, from cold to warm |
| Boldness | How strong the stance is, from hedged to direct and opinionated |
| Energy | How much drive the copy carries, from flat to urgent |

Drift per sample is the mean absolute deviation from the profile target across the four dimensions. Then add the two flag counts:

- **Forbidden language hits.** Words and phrases on the profile's forbidden list, counted per sample.
- **AI pattern flags.** Findings from `anti-slop-audit` against the pattern catalog, counted per sample by tier (P0, P1, P2).

Combine them into one drift score per sample, 0 to 100, where 100 means no drift:

- Start at 100.
- Subtract 10 points per full point of mean dimension deviation (a sample 2 points off on average loses 20).
- Subtract 5 points per forbidden language hit.
- Subtract 5 points per P0 flag, 3 per P1 flag, 1 per P2 flag.
- Floor at 0.

Bands: 90 to 100 means on voice; 70 to 89 means light drift, targeted fixes; 50 to 69 means real drift, needs a profile or process fix; below 50 means systemic drift, the guide or the workflow is not holding.

Score the samples, not the writer. A low score on one channel is a channel problem. Low scores everywhere with the same pattern is a systemic problem. Report which one it is.

## Report Format

File the audit as a durable artifact and report it in this shape:

```markdown
# Drift Audit: <brand> <date>

## Voice test
- <the one-sentence voice test>
- Profile source: <voice-anchor files or guide path>

## Scores
| Sample | Channel | Persona | Formality | Warmth | Boldness | Energy | Deviation | Forbidden hits | P0/P1/P2 | Drift score |
|---|---|---|---|---|---|---|---|---|---|---|
| <title or first line> | ... | ... | x/5 | x/5 | x/5 | x/5 | x.x | n | n/n/n | nn |

## Drift patterns
- <pattern 1: what repeats, where, with sample IDs>
- <pattern 2: ...>

## Verdict
- Overall drift: <band>
- Systemic or isolated: <which, with evidence>

## Recommendations
1. <targeted update, naming the profile section and the change>
2. ...

## Next steps
- <rebuild the guide only if drift is systemic, else targeted updates>
```

Every Do and Don't in the recommendations needs a concrete example before it is encoded: "be direct" is useless without "write X, not Y". Persona takes precedence over channel when both apply: channel adapts the voice, it never replaces persona tone. Reject generic personality traits: if a competitor could claim the same 3 to 4 words, push for specificity before encoding anything.

## What To Do With Drift

- **Isolated drift** (one channel, one persona, one pattern): targeted update to that profile section or channel row. Show the before and after, get confirmation, then write it.
- **Repeated pattern** (same flag across channels): fix the process that produces it. Usually that means tightening `anti-slop-constraint` for that writer or channel, or adding the pattern to the forbidden list.
- **Systemic drift** (low scores everywhere, same thinning): rebuild the voice guide. Even then, rebuild from the existing guide and the samples, not from zero, and show the exact before and after before writing anything.
- **No drift found:** say so, with the scores as proof. Do not invent recommendations to justify the audit.

Never write to the voice guide silently. Show the exact before and after for every change, and write only on confirmation. The guide is a shared source of truth every downstream writing skill reads.

## Output

- The drift audit report, filed as a durable artifact, with per-sample scores and the verdict.
- The list of recommended targeted updates, each with a concrete example and the profile section it touches.
- The before and after for any guide change, approved before it is written.
- A log entry noting the session: date, samples scored, drift patterns found (or "none" written explicitly when nothing notable happened, never skipped).

## Verification

- Every written output can be checked against the pattern catalog, voice profile, or drift score. No claim of "matches voice" without a score: every sample carries its drift score, its dimension ratings, and its flag counts, so any reader can recompute the verdict.
- The voice test sentence passes across every persona profile before delivery, or the failure is named.
- The audit used 5 to 10 samples across 3 or more channels (or states the smaller sample and its limits plainly).
- Persona profiles are complete with at least one concrete Do and one concrete Don't example each. No abstract-only instructions survive.
- Forbidden language is an explicit named list, not implied.
- Guide changes show the exact before and after and were confirmed before writing.
- The session log entry exists, with the pattern field filled in, even when the pattern is "none".

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow from ideas to give back, everything evidence-based, output as changes, report by work, use related skills, update the agent's memory. Drift is measured, not vibed: scores per sample, dimensions per persona, flags by catalog ID, and a voice test sentence that either passes or does not. Ship means a report that shipped and, where needed, a guide update that shipped with its before and after. Report by work: samples scored, patterns found, updates made. Use the related skills (`voice-anchor` for the profile, `anti-slop-audit` for the pattern flags, `anti-slop-constraint` to stop the drift at the source). Update the agent's memory with the drift patterns found, so the next audit starts from evidence instead of from scratch.

## Related Skills

- `voice-anchor` - the voice profile this audit scores against
- `anti-slop-audit` - the pattern flags that feed the drift score
- `anti-slop-constraint` - the floor that stops drift at write time
- `style-rewrite` - rebuilding drifted copy in the anchored voice

## Research source

stefanoskarakasis/brand-voice, https://www.skillsdirectory.com/skills/stefanoskarakasis-brand-voice
