---
name: private-image
description: Use when generating creative images through a private, unfiltered image API, editing or upscaling an existing image, or producing a product photo or thumbnail from a prompt. The output is the image file plus its recorded prompt, so the same prompt reproduces it.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Private Image

You are the image producer for the Creative department. Your job is to turn a brief into a finished image file through a private image API, with the full prompt recorded beside it so the result can be reproduced, varied, or challenged later. An image without its recorded prompt is a one-off accident, not a deliverable.

Private here means the request and the image stay with the operator: no training on the prompt, no public gallery, no third party seeing the brief. Unfiltered means the API does not impose its own taste filter on the brief; the operator's judgment and the law are the limits, and this skill never helps produce illegal content.

## When to Use

- The operator asks for an image from a text prompt: illustration, key art, thumbnail, product shot, social asset
- An existing image needs a prompt-driven edit, an upscale, a background removal, or a composite of several images
- A design or campaign needs image variants from one brief
- An earlier image must be reproduced or varied from its recorded prompt

Do not use this for video, audio, or text generation. Do not use it to copy a real person's likeness without the operator's explicit say-so, and never to impersonate a real person.

## Core Principle

Record the prompt, the model, the seed, and the settings with the image. Reproducibility is the verification: the same model plus the same prompt plus the same seed plus the same settings should produce the same image on models that honor seeds. If any of those four is missing, the image cannot be verified and the run is incomplete.

## The Workflow

### 1. Fix the brief before calling the API

Write down, in one short block, before any call:

- Subject: what is in the image, in plain words
- Style: the look, as a named style preset or a short style phrase
- Format: aspect ratio or pixel size, output format (webp, png, jpeg)
- What must NOT appear: the negative prompt, when the model supports one
- Model: the model id, chosen from the live model list, never from memory

If the brief is vague, ask one question or pick the most literal reading and say so. Do not guess a style the operator never asked for.

### 2. Choose the model from the live list

Fetch the model list first (`GET /models?type=image`) and read each candidate's constraints before sending anything:

- Sizing idiom: pixel models take `width` and `height`; aspect-ratio models take `aspect_ratio`, and some also take `resolution` and `quality`. Sending the wrong idiom is silently ignored on some models and a hard 400 on others.
- Prompt length cap, style reference support, seed support, and pricing tier.
- Privacy tier (`private` or `anonymized`) and content posture. Pick a private model when the brief is sensitive.

Model ids change often. A model id remembered from an earlier session is a guess until the live list confirms it.

### 3. Generate

Use the native endpoint for full control, or the OpenAI-compatible endpoint when the project already runs on the OpenAI SDK shape.

Native call, the fields that matter:

| Field | Use |
|---|---|
| `model` | Required, from the live list |
| `prompt` | Required, non-blank, within the model's character cap |
| `negative_prompt` | Only on models that honor it; silently dropped elsewhere, so check first |
| `width`, `height` | Pixel models only, each at most 1280 |
| `aspect_ratio` | Aspect-ratio models only, one of the values the model lists |
| `resolution` | `1K`, `2K`, or `4K`, only when the model lists it |
| `quality` | `low`, `medium`, or `high`, only when the model lists it |
| `cfg_scale` | 0 to 20. Higher means tighter prompt adherence |
| `seed` | Fixed integer for reproducibility. Omit for random. `0` is a literal seed, not random |
| `variants` | 1 to 4. Only the first variant uses your seed; the rest are random |
| `style_preset` | Exact value from the style preset list, case sensitive |
| `style_references` | Reference images that carry the style, each with a strength 0.1 to 1. Only on models that support them |
| `enhance_prompt` | Rewrites the prompt for more detail. Adds latency and a small charge, so leave it off for cost or latency sensitive calls |
| `format` | `webp`, `png`, or `jpeg` |
| `safe_mode` | Blurs images classified as adult content. Default on |
| `hide_watermark` | Only matters on flat-priced models |

### 4. Check the response before saving

A blocked image still arrives as a 200. Always check the response headers:

- `x-venice-is-content-violation: true` means the image was blocked and you were not charged. Report the block, do not save a blacked-out image as the deliverable.
- `x-venice-is-blurred: true` means safe mode blurred the output. Say so.
- `x-venice-enhanced-prompt` holds the rewritten prompt when `enhance_prompt` produced one. Record that prompt, not the original, as the one that made the image.
- Deprecation headers mean the model is going away. Note the replacement and use it next time.

On error: 400 is bad parameters, fix the request; 401 is auth, stop and report; 402 is balance or spend limit, stop and report; 404 is an unknown or retired model, re-read the live list; 429 and 503 are retry with jitter; 500 is inference failure, retry once.

### 5. Edit, upscale, or composite when the brief needs it

| Endpoint | Purpose |
|---|---|
| `/image/edit` | Transform one image with a text prompt |
| `/image/multi-edit` | Composite several images with one prompt |
| `/image/upscale` | Upscale 2x to 4x |
| `/image/background-remove` | Transparent PNG cutout |

Input images arrive as base64, data URI, URL, or multipart file. Minimum 64 px per side, maximum 7680 by 4320. SVG input is rejected.

### 6. Save the record

Every generated image ships with a record file beside it:

```markdown
# Image record: <filename>

- Prompt: <exact prompt sent>
- Enhanced prompt: <from the response header, when present>
- Model: <model id>
- Seed: <seed, or "random">
- Settings: aspect_ratio / width x height, resolution, quality, cfg_scale, style_preset, format
- Style references: <files or URLs, with strengths>
- Generated: <date and time>
- Output: <path to the image file>
```

To reproduce, re-run the same model, prompt, seed, and settings. To vary, change one field and record the new value. A variant made by changing three fields at once teaches nothing.

## Safety Rules

- Never send a prompt that asks for illegal content, non-consensual intimate imagery, or impersonation of a real person.
- Never expose the API key in a log, a record file, a commit, or a screenshot. The key lives in the environment, never in the output.
- Never present a blocked or blurred image as the finished deliverable.
- Never claim a seed reproduces an image on a model that ignores seeds. Check the model's seed support first.
- Keep the operator's brief private: do not upload the prompt or the image to a public service for a second opinion.

## Output

- The image file, saved in the format the brief asked for
- The image record beside it, with prompt, model, seed, and settings
- A one line summary: what was made, from which prompt, at which path

## Verification

- The image file exists at the recorded path and opens
- The record holds the exact prompt, model, seed, and settings that produced it
- Re-running the same four on a seed-honoring model reproduces the image
- No blocked or blurred image is presented as finished work
- The record contains no API key or secret

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow ideas to give back, everything evidence-based, output as changes. The image is the change, and the record is the evidence that makes it reproducible instead of lucky. Report by work: images made, prompts recorded, blocks reported. Use the related skills (`content-creator` for the brief the image serves, `verification-before-completion` before the image counts as done, `prompt-eval` when a prompt keeps missing). Update the agent's memory with the prompts, models, and settings that worked, so the next brief starts from what is proven instead of from scratch.

## Related Skills

- `content-creator` - the brief and the content the image serves
- `social-content` - social assets built from generated images
- `prompt-eval` - judging and improving the prompts that drive generation
- `verification-before-completion` - proving the image and its record before it counts as done

## Research source

venice-image, Venice.ai official, 18 skills, https://github.com/veniceai/skills
