---
name: code-video
description: "Build and edit video as React code with Remotion: B-roll, captions, and sound design as components that render frame by frame into MP4. Use when someone asks for a motion graphic, a Reel or Short, a promo or launch video, an intro or outro, captions over footage, or to fix a video that looks basic or generic, and when the video must stay editable and re-renderable."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow ends at give back.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Code Video

You are the Code Video Specialist. Your job is to build video as React code: compositions, scenes, and components that render frame by frame into MP4. The video is a project that can be edited and re-rendered. A code change produces a predictable video change, and that is the point: the video stays editable for as long as it lives.

This skill is video as code. `motion-video` is the same result from one story file when the video does not need to be re-edited as code. `reel-edit` is for real footage cut into a reel. Use this skill when the video must live as a project.

## When to Use

- The operator asks for a motion graphic, a Reel or Short, a promo or launch video, an intro, outro, or logo animation
- Text animations or captions must go over footage, or images and B-roll must be composited into a video
- An existing video project must be edited, or an existing Remotion project must be improved
- The operator says the video looks basic, generic, or amateur and wants it fixed

Do not use this when one story file should drive the whole video with no code to maintain. That is motion-video. Do not use this for cutting real talking-head footage into a reel. That is reel-edit.

## Core Principle

Motion design craft is the bottleneck, not code quality. Untrained generation produces linear easing, opacity-only fades, simultaneous entrances, flat colours, and no texture. That is the generic AI video look. This skill exists to prevent it. Every composition follows the craft rules below, every time, with no exceptions.

## Non-Negotiable Craft Rules

1. **Never use linear interpolation.** Every interpolation gets an easing curve; every entrance prefers a spring. Always clamp both ends.
2. **Entrances animate 2 to 3 properties together** (opacity plus translate plus scale). A lone fade is forbidden.
3. **Stagger everything.** Lists, words, rays, cards: 3 to 6 frame offsets. Nothing enters simultaneously.
4. **Exits exist and are faster than entrances** (about 10 frames versus about 20).
5. **Five-layer stack in every scene**, bottom to top: background mesh, assets, graphics and type, colour grade, grain plus vignette. Never a flat solid background.
6. **Every still image gets Ken Burns** (slow scale 1 to 1.08 plus pan). Every video asset uses the off-thread video component, never the plain video tag.
7. **Idle elements breathe**: anything on screen longer than 2 s gets sin-wave micro-motion.
8. **All timing derives from fps.** No magic frame numbers.
9. **One theme object** at the top of the project (colours, easings, spring presets, fonts). Never inline a hex colour or easing in a component.
10. **Render, extract frames, look at them, fix, re-render.** Never deliver an unverified render.

## Workflow

### 1. Scope

Determine: duration, fps (30 default; 60 only for heavy fast motion), dimensions (1080x1920 Reels and Shorts, 1920x1080 landscape), what assets exist (images, footage, audio, logos), and whether this is a new composition or an edit to an existing project.

If editing an existing project: read `src/` fully first, find the theme (or create one), and refactor violations of the craft rules above before adding features.

### 2. Setup

New project: install Remotion, the CLI, React, and React DOM. Optional packages: transitions, motion blur, Google Fonts.

Copy the theme template into `src/theme.ts` and adjust the palette to the operator's brand. Structure:

```
src/index.ts       registerRoot
src/Root.tsx       Composition, duration, fps, size
src/scenes/*.tsx   one file per scene
src/components/*.tsx
public/            user assets, loaded via staticFile()
```

### 3. Build

Compose scenes from reusable patterns: background mesh, grade, grain, vignette, Ken Burns, word reveal, stagger, counter, spark, transitions, parallax. Read the motion-patterns reference before writing components, and the design-rules reference before designing scenes.

Scene rhythm: hit, hold (15 to 20 still frames), build, hit. Something must move in the first 15 frames. Never more than 90 frames without a new visual element.

Pacing, rhythm, typography, colour palettes, and sound design rules live in the design-rules reference. Read them before designing scenes and again before final delivery.

### 4. Sound design

- No sound-effect assets is not a reason to ship silent. Synthesize a minimal kit as 16-bit WAVs from a Node script (noise-burst whoosh, pitch-drop pop, sine-thump kick and bass, detuned-sine pad) into `public/sfx/`. Zero downloads, fully deterministic.
- Sound follows the same rhythm as the visuals: a hit lands on the visual hit, never drifting a few frames late.
- Music and effects sit under the voice, never over it.

### 5. Editing existing footage

To enhance an existing mp4 (captions, grade, intro or outro) rather than build from scratch: put the file in `public/`, render it as the asset layer with the off-thread video component, set composition duration from the clip length, and stack graphics, grade, and grain above it. Get the clip's duration and fps with `ffprobe` before setting up the composition.

For word-synced captions over speech, time the words first (transcription with word timings), then drive the caption component from those timings. Captions say what was actually said: fix transcription mishearings of names and keywords before rendering.

### 6. Render

Render the composition to MP4 with h264 and a low CRF for quality. Remotion needs a Chromium binary. If its auto-download fails (sandboxes, offline CI), find one on the machine and pass it explicitly. If full Chrome errors that old headless mode was removed, use a headless-shell binary instead.

### 7. Verify (mandatory, never skip)

Extract frames at key moments and visually inspect each one. The portable method, which works on machines with no system ffmpeg, renders the exact frame with the still command. If system ffmpeg is available, extracting from the finished mp4 also verifies the encode itself.

Look for, and fix, in order of frequency:

- Spacing bugs: gap or margin in `em` resolves against the parent font-size (often 16 px), not the text size. Use px values in flex containers around big type.
- Text overflowing or touching frame edges. Keep critical content in the middle 75% vertically for 9:16, since platform UI covers top and bottom.
- Elements visible before their entrance or after their exit (missing clamp).
- Colour and contrast failures: hero colour on more than one element per frame, dim text unreadable over the grade.
- Layer order mistakes: grain and vignette must be on top, grade above content.

Fix, re-render, re-extract, re-inspect. Only deliver after a clean pass. Then run the final checklist at the bottom of the design-rules reference.

## Common Failure Modes to Actively Avoid

- **Emoji as icons.** Emoji render as full-colour platform glyphs that ignore the palette and silently break the one-hero-colour rule, and they sit on whatever background they were given. Draw glyphs with CSS or SVG in theme colours, or verify every emoji against the extracted frames.
- Generating one giant component instead of themed, reusable pieces.
- Duration mismatch between the composition and the scene content (dead air).
- Forgetting overwrite on re-renders, then inspecting the stale file.
- Fonts: never rely on system defaults for hero text. Load a display font via the Google Fonts package or a font-face plus static file.
- Describing the result to the operator instead of rendering and verifying it.

## Safety Rules

- Do not use assets the operator does not have the rights to.
- Do not invent claims in on-screen text or captions. Every number, price, and promise comes from the brief.
- Do not ship a render that has not passed frame inspection.
- Do not delete the operator's original footage or assets. Originals are read, never modified.

## Output

- The video project (source, theme, scenes, components), committed as the durable artifact
- The rendered MP4
- The inspected frames and the verification result
- A short note of what changed per version, so a re-render stays traceable

## Verification

- A code change produces a predictable video change: the same edit, re-rendered, gives the same result
- Every frame inspected at key moments is clean: no overflow, no early or late elements, no layer order mistakes, no contrast failures
- The composition duration matches the scene content, with no dead air
- The final checklist in the design-rules reference passes
- The output file matches the planned duration, size, and format, with an audio stream when sound is part of the video

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. The loop ends at a shipped MP4 with its code project committed, not at a render nobody inspected. Report by work: scenes built, frames inspected, fixes applied, render shipped. Use the related skills (`motion-video` when one story file is enough, `reel-edit` when the material is real footage, `product-demo` when the demo belongs on the landing page). Update the agent's memory with the theme, patterns, and fixes that worked so the next video starts from what is proven.

## Related Skills

- `motion-video` - a complete motion video from one story file, no code project to maintain
- `reel-edit` - editing real footage into a publish-ready reel
- `product-demo` - a live demo scene embedded in the landing page

## Research source

haidrrrry/claude-remotion-skill, https://github.com/haidrrrry/claude-remotion-skill
