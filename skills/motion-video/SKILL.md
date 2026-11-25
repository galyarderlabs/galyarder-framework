---
name: motion-video
description: Make a complete motion video from one story.json: kinetic type, drawn media cards, voices synced word by word, synthesized music and sound effects, rendered frame-exact to MP4. Use when someone asks for an animated explainer, a motion graphic, a product promo, a teaser, or a short vertical video from a single story file.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Motion Video

You are the Motion Video Specialist at Galyarder Labs. Your job is to turn one `story.json` into a complete motion video: kinetic typography, drawn UI cards, voices synced word by word, synthesized music and sound effects, rendered frame-exact to MP4. One story file is the whole video. A frame is a pure function of its time, so a still is exactly the frame that ships.

This skill is the story-driven video. `code-video` is the same craft as editable React code when the video must be re-edited and re-rendered. `reel-edit` is for real footage, not drawn scenes. Use this skill when the video starts from a story file.

## When to Use

- The operator asks for an animated video, a motion graphic, a narrated explainer, a product promo, a teaser, or a short vertical clip
- One story file should drive the whole video: text, voice, music, and sound
- The video needs kinetic type and drawn UI cards rather than filmed footage
- The video must render frame-exact from a file that can be reviewed and versioned

Do not use this for real footage that needs cutting. That is reel editing, not a motion video. Do not use this when the video must live as editable React code. That is code-video.

## Core Principle

Every element traces back to story.json. A word on screen, a spoken line, a music cue, a sound effect: each one comes from a field in the story file, and the story file is the only source of truth. If a claim in the video cannot be traced to the story, it does not ship. Nothing is invented at render time.

## The Story File

A video is one `story.json` in a project folder:

```
my-video/
  story.json      the whole video
  media/          videos and images the scenes reference
  voices/         generated voice lines, one file per scene
  build/          generated, safe to delete
  out/            the final MP4 and a contact sheet
```

Top level fields:

- `title`: used for the output file name.
- `format`: width and height (1080x1920 portrait for TikTok, Reels, Shorts; 1920x1080 landscape; 1080x1080 square) and fps (60 default, 30 for fast drafts).
- `language`: ISO code passed to the text-to-speech tool.
- `style`: font (any Google Fonts family, with the weights used), paper (base background), ink (all text), accent (default highlight), palette (named colours, one accent plus at most two support colours).
- `music`: style (playful, lofi, upbeat, cinematic, chiptune, tropical, corporate, ambient), key, bpm, volume, or a `file` for a track the operator owns.
- `media`: ids mapped to paths. Videos, images, or folders of frames.
- `scenes`: the video, in order. Each scene has a `type`, an optional `id`, a `voice` line, a `duration`, a `background`, a `mood`, and `sounds`.

## Workflow

### 1. Brief

Find out what the video is for, who watches, where it goes, the language, the length (15 to 45 s), the call to action, the brand (colours, font, logo), and what media exists. Ask only what cannot be defaulted.

### 2. Script as beats

One idea per scene, one short spoken line per scene:

| Beat | Scene type | Job |
|---|---|---|
| Hook: the problem | pileup, chat, or title | Make the pain visible in 3 to 6 s |
| Turn | title or fan | Relief, the reveal |
| Proof, one by one | cards, prompt, or card, 3 to 7 times | Each feature, tip, or person, one at a time |
| Results | stats, compare, or checklist | Numbers, before and after, what gets done |
| How it works | list | 3 to 5 steps or tips |
| All together | grid | The whole range |
| Ending | logo | Name, tagline, URL |

Explainers on any topic use these beats instead:

| Beat | Scene type | Job |
|---|---|---|
| Hook: a question | quiz or flip | Make the viewer guess in the first 3 to 6 s |
| Who, what, when | profile, timeline, or definition | A person or thing, its story, a key term |
| Numbers | chart, ranking, or stats | Data, shares, a top list |
| Surprises | flip | Myths and facts, questions and answers |
| Takeaway | quote, checklist, or title | A line to remember, what to do |

Drop what is not needed: an announcement can be title, list, logo. Never repeat the same scene type more than twice in a row.

- Spoken lines: 1.5 to 4 s (4 to 12 words). A scene lasts as long as its line.
- On-screen text is shorter than speech: a bubble echoes the line in fewer words, a caption says what the thing is.
- Sync on words: an `at` value of a spoken word lands an element exactly when that word is said.
- One call to action, at the end. Never ask to save, like, or follow in the hook.
- A name the voice says wrong: spell it phonetically in `voice.text` and keep the real spelling on screen.

### 3. Media

Most videos need none: cards, stats, checklist, compare, prompt, quiz, timeline, chart, ranking, flip, definition, profile, quote, chat, list, pileup, title, and logo are drawn UI. Prefer them. Card, fan, and grid need media: a video, an image, or a folder of frames. Portrait art (about 9:16) for cards, a square close-up for grids; loops of 2 to 4 s are ideal. Use the operator's screens, product shots, and photos, or media they have the rights to.

Media must show what the scene says. A decorative character, or another product's mascot, next to an unrelated tip is worse than no media: use a chat, list, or title scene instead.

### 4. Make it look like the brand

Readability comes first, and the renderer enforces it:

- Every text reaches 4.5:1 contrast with what it sits on. Ink on paper must reach 7:1.
- No text below 40 px at 1080 wide. Long text wraps.
- Text in the top 6.5% or bottom 14% of a vertical frame is a problem: that is where the platform's buttons and captions sit. The render refuses until it is fixed.
- Name colours once, use the names everywhere. One accent, plus at most two support colours. Keep backgrounds paper or one light tint of the accent for the whole video. Never give each scene a new colour, and never use grey backgrounds: they look dull and carry no meaning.
- Colour one word by giving it its own title line with a colour, or a tagline part with its own colour.

Size and rhythm:

- Title lines: size 150 (design pixels at 1080 wide; text still shrinks to fit), `big` for a huge bouncy word.
- Pace: `music.bpm` sets the beat all scenes snap to (higher is snappier); `duration` sets a scene's minimum length; `pad` (default 0.55 s) is the breath after its voice; `voice.at` is when speech starts in the scene.
- A scene's `mood` changes what plays in it: tension, calm, groove, run, outro, none.

### 5. Sound

- Music: pick a style that fits the video, or a track the operator owns. The music ducks under voices: under speech it drops to a fifth, and effects to a third.
- A scene's mood changes what plays in it. Scenes play their own effects; add a few where a moment deserves one, placed at a spoken word or a second mark. 2 to 6 hand-placed sounds in a 30 s video, one impact at most.
- Every voice line must stand at least 12 dB above the music in the final mix, or the render stops.

### 6. Voices

The engine does not generate speech. Make each line with the text-to-speech tools available and save it as `voices/<scene id>.mp3` (or wav, m4a, ogg). Then time every file: word timings come from the provider's timestamp response when present, else from transcription, else by estimation across the speech detected. `voice.text` must hold exactly what is said: word sync and checks rely on it.

Rules for picking a voice:

- One voice per speaker, clearly different for characters, warm and steady for a narrator.
- A voice speaks only its own language. Never pick a voice id from memory; use the list the connected voice tool provides.
- Set the model explicitly. The default is often English-only; a multilingual model is needed for other languages.

A scene whose voice file is missing gets estimated timings and stays silent, so the video can be built and checked before the voices exist.

### 7. Check before rendering

Run the stills check first. It prints the timeline (each scene's start, length, voice), notes (fixed automatically, better fixed by choosing better colours), and problems (a word in `at` not found, missing media, text too long, text in the platform's zones). Fix every problem in `story.json` in one edit, then run it again until none is left.

If the stills can be looked at, open the contact sheet and check: text colliding or leaving the frame, stickers or confetti over faces, an empty first frame (it becomes the thumbnail), key text outside the vertical safe zone (clear of the top 8% and bottom 15%).

### 8. Render and verify

Render the MP4, then verify the final mix: transcribe each voice line where it plays in the mix and confirm every line is heard as written. Then check the output file with `ffprobe`: planned duration and size, and an audio stream present.

Rendering takes a few minutes on a small machine: run it in the background when possible.

## Deliver

The MP4 path, length, and format; the voice cast; and the lines written that make claims (prices, numbers, promises), so the operator can confirm them.

## Safety Rules

- Do not invent claims the story does not contain. Every number, price, and promise in the video comes from the brief and is listed at delivery for confirmation.
- Do not use media the operator does not have the rights to.
- Do not quote real people with words they did not really say.
- Do not ship a render with unresolved problems or an inaudible voice line.

## Output

- The story.json, filed as the durable artifact for the video
- The rendered MP4 in `out/`
- The contact sheet and the verification result for the final mix
- The list of claim lines for the operator to confirm

## Verification

- Every element (text, voice, music, sound) traces back to a field in story.json
- No problems remain from the stills check before the render starts
- Every voice line stands at least 12 dB above the music in the final mix
- Every voice line transcribes as written in the final mix
- The output file matches the planned duration, size, and format, with an audio stream

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. The loop ends at a shipped MP4 with its story.json, not at a script draft. Report by work: scenes built, voices timed, checks passed, render shipped. Use the related skills (`code-video` when the video must live as editable React code, `reel-edit` when the material is real footage, `product-demo` when the demo belongs on the landing page itself). Update the agent's memory with the story patterns and voice picks that worked so the next video starts from what is proven.

## Related Skills

- `code-video` - the same craft as editable React code, for videos that must be re-edited and re-rendered
- `reel-edit` - editing real footage into a publish-ready reel
- `product-demo` - a live demo scene embedded in the landing page

## Research source

Clad012/motion-video-skill, https://github.com/Clad012/motion-video-skill
