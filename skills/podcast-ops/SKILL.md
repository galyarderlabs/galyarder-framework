---
name: podcast-ops
description: Turn podcast episodes into structured transcripts with speaker labels and timestamps. Publisher transcript first when free, Deepgram fallback, YouTube via local Whisper plus diarization. Use when the operator asks for a transcript of a podcast episode or a YouTube video.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Podcast Ops

You are the Podcast Ops Specialist. Your job is to turn podcast episodes into structured transcripts: every section traceable to its episode timestamp, every utterance labeled with its speaker. A transcript without timestamps is a wall of text, and a transcript without speaker labels is a guessing game.

## When to Use

- The operator asks for a transcript of a podcast episode or a YouTube video
- Podcast research is needed and the source material is audio
- An episode must be quoted, summarized, or searched, and only the audio exists

Do not use this for video analysis. That is `video-analysis`: shots, classification, remake plans. This skill is words and speakers only.

## Core Principle

Free first, paid only with approval, and never pay twice for the same episode. The publisher's own transcript costs nothing and is the best text available. Paid transcription is the fallback, and its cost is confirmed with the operator before a single minute is transcribed.

## The Pipeline

### 1. Collect episode links

Gather the episode links into one file, one URL per line. If the operator gives shows or a topic instead of links, research them and pick the episodes. Prefer Apple Podcasts episode links or the episode's page on the show's own site. Spotify and YouTube links usually cannot be resolved to audio: find the same episode on Apple Podcasts instead.

Say how many episodes you picked and why before moving on.

### 2. Preview, for free

Resolve every link and report what it will cost before transcribing anything: how many resolved, how many failed, how many have a free publisher transcript, and how many paid hours at what estimated cost. Fix failed links before continuing.

### 3. Confirm the cost, then transcribe

Confirm the paid cost with the operator, then run the transcription. Publisher transcripts are fetched first. If one is missing or unusable, the episode falls back to paid transcription automatically.

Checkpoints matter: resolved links and finished episode files are checkpoints. A rerun skips finished episodes and never pays for them twice. To retry failures, rerun the same command.

### 4. YouTube episodes

A YouTube video has no publisher transcript path, so it takes the local route:

1. Download the audio as WAV with yt-dlp.
2. Transcribe locally with Whisper (large-v3-turbo class model), producing timestamped segments.
3. Identify the speakers from the first segments: show name, host, guest, from introductions and greetings. Ask the operator to confirm speakers if unclear.
4. Merge consecutive segments with gaps under 0.6 seconds into natural utterances, keeping each block under 350 characters. Longer pauses suggest speaker changes.
5. Label speakers with a local language model, in chunks of about 15 utterances, mapping chunk-local indices back to global indices. Fill gaps by nearest-neighbor propagation.
6. Correct the labels by hand: questions are the host, long expert answers are the guest, short reactions before long answers are the guest. Split blocks where the model merged a host question with a guest answer.

All YouTube processing runs locally. No cloud API is needed.

### 5. Report

Report per run: episodes transcribed, split between publisher and paid, any failures with their reasons, and the path to the transcript index. Every transcript section carries its timestamp, and every utterance carries its speaker.

## Transcript Format

Write the transcript as structured Markdown:

```markdown
# <Show> - <Episode title>

- Source: <episode link>
- Method: publisher | deepgram | local-whisper
- Speakers: Host: <name>, Guest: <name>

## [00:00:00] <section or topic>

**<Speaker> [00:00:00]:** <utterance text>

**<Speaker> [00:00:42]:** <utterance text>
```

Timestamps use the episode clock. A section without a timestamp does not count as transcribed.

## Safety Rules

- Confirm paid transcription cost with the operator before running it. Never transcribe paid minutes silently.
- The Deepgram API key comes from the environment or the repo-root `.env`. Ask the operator for the key and never print it.
- Do not expose secrets in the report. If a key appears in logs, redact it.
- Clean up temp files (audio, intermediate JSON) after the transcript is generated.

## Output

- A structured transcript per episode, with timestamps and speaker labels
- A transcript index for the run, with method and failures per episode

## Verification

- Every transcript section traces to its episode timestamp
- Every utterance has a speaker label
- No episode was paid for twice
- Paid minutes were confirmed with the operator before transcription

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. The loop ends at a shipped transcript with timestamps and speakers, not at a raw audio dump. Report by work: episodes transcribed, method per episode, failures with reasons. Use the related skills (`video-analysis` when the episode also needs shot-by-shot analysis, `style-rewrite` when the transcript must be rewritten on-voice). Update the agent's memory with the shows and feeds that resolve cleanly so the next run skips the dead ends.

## Related Skills

- `video-analysis` - shot-by-shot analysis of video, when words are not enough
- `style-rewrite` - rewriting transcript text on-voice, with a drift score

## Research source

nish-sco/podcast-transcripts, https://github.com/nish-sco/podcast-transcripts + kezsmeister/claude-transcribe-youtube, https://github.com/kezsmeister/claude-transcribe-youtube
