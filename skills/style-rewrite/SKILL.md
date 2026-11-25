---
name: style-rewrite
description: "Rewrite AI output into a personal style automatically, from the bottom up: real examples and a style profile, not top-down rules. Use when asked to rewrite in my style, make this sound like me, transform this, or sound like me, for emails, messages, and professional writing."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Style Rewrite

Transform text to match a personal voice. Designed for converting AI-generated responses into authentic personal communication. The transform works from the bottom up: it starts from the person's real messages and rebuilds the text in their patterns. It does not start from abstract rules and impose them on the text.

This skill is the transform. `anti-slop-constraint` is top-down enforcement: rules applied to every write whether or not a personal profile exists. Use this skill when a personal style profile exists and the text must sound like a specific person. Use that skill when no profile exists, or when the goal is clean copy rather than personal copy. `voice-anchor` is the profile this skill can draw on; this skill's own profile in `references/style-profile.md` is the working copy for rewrites.

## When to Use

- The operator asks to "rewrite in my style", "make this sound like me", "my style", "make it mine", "transform this", "rewrite as me", "sound like me", or "use my voice"
- AI output needs to become a message, email, or post the operator can send as their own
- A draft is correct but reads like a machine wrote it, and the fix is voice, not facts

Do not use this to write new content from scratch with no source text. That is `copywriting` or `content-creator` with a voice profile. Do not use this to audit copy. That is `anti-slop-audit`.

## Process

1. Load the style profile from `references/style-profile.md`. If the profile is still mostly template slots, say so before rewriting: the output can only be as personal as the profile. Fill the profile with real material first (see Setup below), or accept a generic rewrite and say that it is generic.
2. Infer the language from the input text. Write the rewrite in the same language.
3. Infer the context from the text patterns (see Context Detection below).
4. Apply all style rules from the profile, working from the examples outward: match the person's sentence shapes, greetings and closings, vocabulary shortcuts, and never-say list, before touching anything else.
5. Output only the transformed text.

## Context Detection

The skill detects context from the input and applies the matching mode from the profile:

| Pattern | Detected context | Style applied |
|---|---|---|
| Short text, no greeting | Casual messaging | Very short, fragments allowed, no formal greeting or closing |
| Greeting plus multiple paragraphs | Email or professional | Complete sentences, direct, first sentence carries the point |
| Technical terms, code references, specifics | Technical writing | Dense, specific, no padding, terms kept exact |

A text that mixes contexts keeps the dominant one. When the context is genuinely ambiguous, use the professional mode and say so in one line after the output (never inside it).

## The Style Profile

The profile in `references/style-profile.md` holds, in two modes (casual and professional):

- **Core rules:** how long messages run, whether there are greetings or closings, slang and abbreviations, emoji or none.
- **Vocabulary:** the person's shortcuts and slang, as a table of full form versus what they actually say.
- **Greetings and closings:** the exact forms they use, not generic ones.
- **Things they never say:** AI phrases that make them cringe, plus their own additions.
- **Real examples:** pasted real messages and real emails, in both modes.
- **Before and after examples:** AI-generated text beside how the person would actually say it. The more examples, the better the output.

The profile is a template until it holds real material. Empty slots are not style; they are homework.

## Setup

Fill the profile before trusting the skill with anything that goes out under the operator's name:

- Add casual slang and abbreviations.
- Add the email greeting style and closing style.
- Paste 3 or more real casual messages.
- Paste 3 or more real emails.
- List the AI phrases they hate.
- Add before and after examples.

Each new real example sharpens the transform. A profile with no real examples produces a generic rewrite and must be labeled as such.

## Output Rules

- Return only the rewritten text.
- No preamble ("Here is the rewritten version:").
- No postamble ("Let me know if you need changes").
- No explanation of changes made.
- Ready to copy and paste directly.

The output rules are absolute for the rewrite itself. Scores, caveats, and setup warnings go in the report that follows the output only when the operator asked for verification, and never inside the rewritten text.

## Guardrails

- **Never invent anecdotes, experience, or specifics.** If the source has no story, the rewrite has no story. A hypothetical is marked as one ("imagine...", "suppose..."), never presented as real.
- **Preserve meaning.** Keep quantities, units, negation, conditions, commitments, dates, and names exact. A rewrite that changes what was promised is not a rewrite, it is a new claim.
- **Keep the person's stance.** Express an existing position clearly without creating one or changing its confidence.
- **Do not add a personality the person never had.** No fabricated first-person experience, no performed candor, no forced contrarianism, no staccato fragments installed to manufacture rhythm. The profile's examples are the boundary: if a move does not appear in them, do not add it.
- **Keep protected content intact.** Quotations, code, tables, URLs, paths, and identifiers are not rewritten. Report a style problem inside protected content instead of changing it.
- **Clean is not enough.** A rewrite that clears every slop flag but erases the person's cadence and idiosyncrasies has failed. The examples in the profile are the standard, not the catalog.

## Verification

- Every written output can be checked against the pattern catalog, voice profile, or drift score. No claim of "matches voice" without a score: score the rewrite against the profile examples and the never-say list, and report the score (examples matched, never-say hits, catalog findings per 1,000 words) with the delivery when verification was asked for.
- The rewrite preserves the source meaning: quantities, negation, commitments, and stance are checked against the source before delivery.
- The profile that was applied is named. If the profile was mostly template slots, the output is labeled generic and the missing setup is listed.
- If no real examples exist in the profile, no "sounds like you" claim is made. The rewrite is reported as a style pass against the rules only.

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow from goal to shipped, everything evidence-based, output as changes, report by work, use related skills, update the agent's memory. The transform is bottom-up evidence: real messages in, personal voice out, with the profile as the artifact that makes the next rewrite better than this one. The loop ends at text the operator can send as their own, not at a draft that still needs a human pass. Report by work: texts rewritten, scores attached, profile gaps found. Use the related skills (`voice-anchor` for the full voice profile, `anti-slop-audit` to verify the rewrite against the catalog, `drift-audit` when rewrites keep drifting from the profile). Update the agent's memory with the operator's style notes and never-say additions, so the profile compounds instead of resetting.

## Related Skills

- `voice-anchor` - the full voice profile this rewrite can draw on
- `anti-slop-audit` - the audit that verifies the rewrite against the pattern catalog
- `anti-slop-constraint` - top-down enforcement, the alternative when no personal profile exists
- `drift-audit` - scoring rewrites that keep drifting from the profile
- `copywriting` - new copy written in the operator's voice

## Research source

lout33/writing-style-skill, https://github.com/lout33/writing-style-skill
