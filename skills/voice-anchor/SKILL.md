---
name: voice-anchor
description: Learn a voice through 9 questions, save it in memory, and enforce it on all output. Use when writing anything in the operator's voice, or when asked to set up, show, or update a voice profile.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow ends at give back.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Voice Anchor

You learn a voice once, save it in memory, and enforce it on every piece of output after that. The voice is the operator's, not yours. Your job is to hold it steady across channels, formats, and days, so the operator sounds like the same person everywhere.

This skill is the anchor. `drift-audit` scores copy against the profile this skill builds. `style-rewrite` rebuilds a finished draft in this voice from the bottom up. Use this skill to define the voice, use those skills to check and apply it.

## When to Use

- The operator asks to set up, define, or learn their voice or tone of voice
- Any writing task where a saved voice profile exists: load it first, then write
- The operator asks to show or update their voice profile
- Copy keeps coming out generic and the operator wants it to sound like them

Do not use this to write copy with no voice to anchor to. If no profile exists, run the setup first. Do not guess a voice from one message.

## Setup Check

Before doing anything else, check whether voice profile memories exist:

1. Look for memory files matching `voice-anchor-*.md` in the operator's memory directory.
2. If found: load them and proceed to Enforcement Mode below.
3. If not found: run Interactive Setup first.

Never re-ask what is already answered in memory. Load the profile silently and write in it.

## Interactive Setup (First Use Only)

Ask the operator these 9 questions, one at a time. Let them type freely when open-ended is better; offer choices only where choices help. Save each answer to its own memory file as you go, so a partial setup is never lost.

**1. Identity.** "Who are you? Give me 2 to 3 sentences: your background, what you have built, and how you got here. No hype." Save to `voice-anchor-identity.md`.

**2. Core belief.** "What is the one belief that unifies everything you write? The thing you would put on a billboard. Something slightly provocative." Prime with examples if they stall: "Most founders are building for the wrong scorecard." "Distribution beats product every time." "The system rewards compliance, not competence." Save to `voice-anchor-core-belief.md`.

**3. Audience.** "Who do you write for? Not demographics. Describe the person. What do they care about? What are they trying to do?" Save to `voice-anchor-audience.md`.

**4. Voice traits.** "Pick 3 to 5 words that describe how your writing should feel. Not what you write about, how it sounds." Offer these as starting options, with room for custom: Contrarian, Direct, Technical, Warm, Irreverent, Precise, Provocative. Save to `voice-anchor-traits.md`.

**5. Topics.** "What are your 3 to 5 core topics? The things you always come back to." Save to `voice-anchor-topics.md`.

**6. Vocabulary.** "Give me 5 to 10 word pairs: words you use versus words you would never use. Format: use X, not Y." Example: "Use 'bootstrapped', not 'self-funded'. Use 'ship', not 'deploy'. Use 'customers', not 'users'." Save to `voice-anchor-vocabulary.md`.

**7. Banned phrases.** "What phrases make you cringe? Things you would delete on sight." Start with these defaults and let the operator add or remove: "We are excited to announce", "In this article, we will explore", "Do not miss out!", "Let me know in the comments", "In today's [adjective] world", "If this resonates, you are in the right place", triple anaphora for drama ("Without X. Without Y. Without Z."). Save to `voice-anchor-banned.md`.

**8. Channels.** "Which channels do you write for? For each one, any specific rules?" Common channels: Blog, Newsletter/Email, Twitter/X, LinkedIn, GitHub READMEs, Community (Discord/Slack). Save to `voice-anchor-channels.md`.

**9. Examples.** "Paste 1 to 3 paragraphs you have written that nail your voice. These become the reference standard." Save to `voice-anchor-examples.md`.

After setup, confirm: "Voice profile saved. I will apply it whenever you write. You can update any part by saying 'update my voice [section]'."

## Enforcement Mode (Ongoing Use)

When writing or reviewing content, apply the voice profile from memory.

### Writing rules (apply always)

- **Open with a punch, not a windup.** First sentence: a number, a bold claim, or a contrarian take. Never a definition. Never "have you ever wondered".
- **Short sentences. Short paragraphs. Lots of air.** One idea per paragraph. Under 20 words per sentence when possible. Tables for every comparison.
- **Bold the scannable takeaways.** One to two bold phrases per paragraph, maximum. Bold the insight, not the setup. If someone reads only the bold phrases, they should get the core argument.
- **Have an opinion and defend it.** Do not write "X might have some drawbacks." Write "X is broken and here is why." The reader came for a take, not a Wikipedia article. Back the opinion with data, math, or experience, not attitude.
- **Let ambition speak through specifics.** No false modesty. No chest-beating either. Do not say "I got lucky": explain the decisions. Do not say "without asking permission": just describe what you did. The reader draws their own conclusions from the specifics.
- **Experience first.** "Here is what I did" beats "Here is what you should do." If you have not done it yourself, say so.
- **Anti-fluff.** Every sentence earns its place or gets cut. No throat-clearing. No padding. If you can delete a paragraph and the piece improves, delete it.

### Guardrails (where confidence becomes cringe)

These rules keep a strong voice from tipping into performative writing. Apply them alongside the writing rules.

- **Confident, not performative.** The insight is the flex, not the framing around it. If you strip out the first-person posturing and the piece gets weaker, the piece was never strong. Let specifics carry authority.
- **Say what it is.** Never define yourself by what you are not. "This is not X. It is not Y. It is not Z." is three sentences saying nothing. Say what it is, in one sentence, and move on.
- **Never punch down.** Do not caricature people to make yourself look better by comparison. No strawman attacks on people at different stages. If the content needs a foil, use bad advice or bad structures, not bad people.
- **No manifesto energy.** Triple anaphora, bumper-sticker closers, and "if this resonates, you are my people" are LinkedIn moves. Content earns respect through substance, not rhetoric.
- **Share, do not preach.** Write like you are talking to a peer, not an audience. The motivation is sharing what worked and connecting, not building a following or proving you are above anyone.
- **No parroting.** When replying to a post, comment, or review, do not echo the original back: no paraphrasing their words, no "You said X" restatement. Assume the reader saw what you are responding to. Lead with what is new: a counter, a specific, an angle they did not have.

### Enforcement checklist

Check every piece against the profile before delivery:

- Opening punches (no windup, no definitions)
- Voice traits match the saved profile
- Vocabulary uses preferred terms and avoids rejected terms
- No banned phrases anywhere
- Channel-specific rules applied (length, tone, format)
- Bold phrases carry the argument for scanners
- Examples feel consistent with the saved reference samples
- Every sentence earns its place
- No performative posturing or manifesto energy
- No punching down or strawman foils
- Defines what it is, not what it is not
- No parroting: replies do not echo or paraphrase the original

## Voice Test

Before a piece ships, run the one-sentence voice test against it: "[Operator] sounds like [descriptor], always [consistent quality], even when [the tone shifts]." If the piece fails the sentence, it does not ship in this voice. Rewrite it or flag the failure to the operator; never silently ship a failure.

## Updating the Profile

If the operator says "update my voice [section]": read the relevant memory file, show the current content, ask what they want to change, and update the memory file. If the operator says "show my voice": read all `voice-anchor-*.md` memory files and display a formatted summary of the voice profile.

A voice profile is a living record, not a one-time form. When `drift-audit` finds a pattern worth keeping, fold it into the profile and note the date. When the operator's voice evolves, the profile evolves with it, in the open, with the before and after shown.

## Output

- On setup: the saved profile, confirmed section by section, with the file names where each part lives.
- On enforcement: the written piece, in voice, plus the checklist result.
- On show: the formatted profile summary.
- On update: the before and after for the changed section.

## Verification

- Every written output can be checked against the pattern catalog, voice profile, or drift score. No claim of "matches voice" without a score: score the output against the profile on opening, traits, vocabulary, banned phrases, channel rules, and examples, and report the score with the piece.
- The voice test sentence passes for the piece, or the failure is reported, never hidden.
- The profile was loaded from memory before writing, not reconstructed from a guess. If no profile existed, setup ran first and the operator knows it.
- Updates to the profile show the before and after and are saved to the memory files, not only mentioned in chat.

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow from goal to shipped, everything evidence-based, output as changes, report by work, use related skills, update the agent's memory. The voice profile is the memory this skill updates: nine answers saved as files, enforced on every output, scored on every piece. The loop ends at copy that shipped in the operator's voice, not at a profile that sits unread. Report by work: profile built or updated, pieces written, scores attached. Use the related skills (`anti-slop-audit` to verify the output against the catalog, `anti-slop-constraint` for the floor under every write, `drift-audit` to catch the voice drifting across channels). Update the agent's memory with every profile change, because the profile is the memory.

## Related Skills

- `anti-slop-audit` - the audit that scores output against the pattern catalog
- `anti-slop-constraint` - the floor under every write, including voice calibration
- `drift-audit` - channel-wide drift scoring against this profile
- `style-rewrite` - rebuilding a finished draft in this voice from the bottom up
- `copywriting` - longer-form copy written in this voice
- `content-creator` - content built on this voice

## Research source

entpnomad/tone-of-voice, https://github.com/entpnomad/tone-of-voice
