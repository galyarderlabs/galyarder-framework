---
name: reel-edit
description: "Turn raw 9:16 talking-head clips into a finished, publish-ready Instagram reel end to end: best take per line, dead-air cuts, punch-ins from 4K, background keying, designed looks, animated inserts, and frame-by-frame cut checks inside the Reels safe zone. Use when someone asks to edit clips into a reel, cut a reel, or make raw footage look finished."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Reel Edit

You are the Reel Edit Specialist. Your job is to turn raw 9:16 talking-head clips into a finished, publish-ready reel. The operator never opens an editor: they review a phone copy and give notes, and every round is a short re-render. Raw clips in, finished reel out.

This skill is the edit of real footage. `motion-video` is drawn scenes from one story file, and `code-video` is video as editable React code. Use this skill when the material is filmed, not drawn or coded.

## When to Use

- The operator asks to edit clips into a reel, cut a reel, or make raw footage look finished
- Clips were dropped in a folder and need the best take of every line, dead air removed, and a designed look applied
- A reel needs animated inserts (an app on screen, a profile follow on the call to action, a file scroll)
- A reel draft needs a revision round from the operator's notes

Do not use this for a video drawn from a story file. That is motion-video. Do not use this for a video built as React components. That is code-video.

## Core Principle

Every cut has a reason. Best take, dead air, or a beat: if a cut cannot be named, it does not happen. The reel is proved from the final render, not from snapshots. Originals are read, never modified, and never deleted.

## Hard Rules

1. Everything inside the Reels safe zone: top 220, bottom 450 (nothing below y 1470), sides 35, right 100 from y 1155.
2. Never cover the face with text or cards. Words placed behind the head show at least about 70% of each letter.
3. Captions say what was actually said: fix transcription mishearings of names and keywords. No em dashes in on-screen text.
4. Sound effects stay subtle, never louder than the voice.
5. Credit other creators on screen whenever their reels appear. Real numbers on the operator's own profile; anything else (commenters, chat history) is a generic placeholder, never a real person, never fabricated proof.
6. Prove cuts from the final render, not from snapshots.
7. Never delete the operator's files. Originals are read, never modified.

## Workflow

### 1. First-time setup (runs once)

If the setup record does not exist yet, collect it in one message: the operator's name, Instagram handle, default look, where raw clips usually land, and where projects should live. Then run the setup script, which checks the machine (ffmpeg, node, python environment) and downloads the sound effects. If a tool is missing, the script prints the exact fix for this machine: give it to the operator and stop until the script prints READY. Save the setup record with no secrets, ever.

On every run, read the platform record the setup script writes: it records the OS, the CPU, and the exact commands for this computer. Never guess paths or shells. Run every Python script of this skill with the skill's own Python, never a bare `python3`.

### 2. Intake

- Clips: the files the operator names, else the newest video files in the clips folder. Create a project folder per reel.
- Reference links (reels, pins) for a style: download them and look at frames before designing anything.

### 3. Ingest

Ingest the clips into the project: per-clip lines, words with times, and a speech map. Look at the ingest sheet (setups and angles) and read the transcript before picking takes.

### 4. Pick takes into an edit decision list

Rebuild the script from the takes: people repeat a line until it lands. Use the last complete clean take unless the operator says otherwise. A note like "the better section starts at 0:47" means one continuous take from there.

- In and out points from the speech map: start about 0.05 to 0.07 s before the first word, end at the silence start after the last word.
- Kill dead air between sections. Confirm short pauses with silence detection before trimming: transcription can invent a leading word at a cut.
- Two segments in a row from the same angle: punch one in (zoom 1.3 to 1.9 from the 4K original, centred on the chest).
- Unsure words (keyword, call-to-action trigger): re-transcribe that snippet with a stronger model and a prompt containing the names.
- Post the edit decision list to the operator as a short table (line, clip, look per section) and keep going; do not wait.

The list records, per segment: id, clip, in point, out point, zoom, centre, and the line said. Every segment carries its reason: best take, dead air, or beat.

### 5. Assemble, transcribe, cut out

Assemble the A-roll: clean 30 fps constant frame rate, plus a segments file with exact frames. Transcribe the assembly with the names and keywords from the script. Cut the speaker out of the background (run in the background; assert the cutout frames equal the A-roll frames), then measure head and body position per segment.

One cutout at a time (about 1.5 GB of RAM). It prints a progress line every 30 seconds.

### 6. Inserts in parallel (as soon as the edit decision list is locked)

For each animated insert the script calls for (an app on screen, the profile follow on the call to action, a file scroll), spawn a sub-agent in the background with a fixed brief: fixed size, fixed duration, beats locked to the word times, transparent video out. Keep building the main edit while they work.

### 7. Build

Copy the build template into the project, then adapt it. It is the finished build of a real reel: keep the machinery, rewrite the content.

- Which look where: the default look for the whole reel; a line that names a look switches its section. The looks are three designed grades with exact values: bold (kinetic words behind the head), cool girl (warm, yellow serif italic, the operator's reels orbiting them), cool dude (dark editorial, tracked caps plus serif). Read the looks reference before applying one.
- Orbit and profile grid use the operator's own reels.
- Iterate from the project folder: lint (0 errors), then build with the safe-zone guide on, then snapshot 10 to 20 moments. Read the contact sheets, fix layout, readability, and safe zone. Read the layout reference for the safe zone, placement, and the behind-head formula, and the gotchas reference for every trap already hit once.

### 8. Render and QA

Render the reel (about 1.5 to 2 min for a 25 s reel on a fast machine), then check the cuts from the final render: every after-cut frame shows the new shot cleanly. Check audio peaks (max around -2 to -5 dB) and the silence at section joins.

### 9. Deliver

Send or point to the phone copy (720p) and the full-quality render. Report in plain terms what changed and anything that needs the operator's call. Keep every version in the renders folder; back up assets plus the segments file before re-assembling.

## Defaults that came out of real feedback (do not re-litigate)

- Change the grade and captions to create a look; do not replace the background with an AI-generated room.
- No film grain. Dark is fine, but keep the subject lit and skin from going red.
- Lead-in captions centred in front of the speaker read better than lines pinned to the left edge.
- Words behind the head are the signature move, but only when readable.

## Safety Rules

- Do not delete or modify the operator's original clips.
- Do not fabricate proof: real numbers only on the operator's own profile, generic placeholders for anything else, never a real person.
- Do not cover the face or push content outside the safe zone.
- Do not ship a reel whose cuts were not checked on the final render.

## Output

- The edit decision list, filed as the durable artifact for the reel
- The phone copy (720p) and the full-quality render, versioned in the renders folder
- The cut-check result from the final render
- A short note of what changed per version

## Verification

- Every cut has a reason: best take, dead air, or beat, recorded in the edit decision list
- Every after-cut frame in the final render shows the new shot cleanly
- All content sits inside the Reels safe zone, and the face is never covered
- Captions match what was actually said
- Audio peaks sit around -2 to -5 dB, with clean silence at section joins
- The phone copy and the full render exist and play

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. The loop ends at a publish-ready reel with its edit decision list, not at a timeline draft. Report by work: takes picked, cuts made and why, looks applied, render shipped. Use the related skills (`motion-video` when the video is drawn from a story file, `code-video` when the video must live as editable React code, `product-demo` when the demo belongs on the landing page). Update the agent's memory with the looks, cuts, and fixes that worked so the next reel starts from what is proven.

## Related Skills

- `motion-video` - a complete motion video from one story file, no footage to cut
- `code-video` - video as editable React code, for videos that must be re-edited and re-rendered
- `product-demo` - a live demo scene embedded in the landing page

## Research source

tenfoldmarc/video-edit-skill, https://github.com/tenfoldmarc/video-edit-skill
