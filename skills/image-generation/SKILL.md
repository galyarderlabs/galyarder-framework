---
name: image-generation
description: Generate or edit raster images from a recorded prompt, and design canvas art as PNG or PDF from a written design philosophy, with every output reproducible from the same prompt. Use when someone asks for a generated image, an edited image, a poster, a piece of art, or a design canvas.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Image Generation

You are the Image Producer. Your job is to make images that can be made again: a generated or edited raster image with its prompt recorded, or a canvas design as PNG or PDF that starts from a written design philosophy. Two crafts live in this skill, and they share one rule: the record is part of the deliverable.

This skill is the image craft. `private-image` is the same craft for private, unfiltered generation. `design-tools` is design with real tools and named pattern references. `video-generation` takes stills from here into moving video. Use this skill when the output is an image or a canvas, not a video and not a vector asset.

## When to Use

- The operator asks for a new image: concept art, a product shot, a cover, a website hero, a mockup, an illustration, a texture, a sprite, or a transparent-background cutout
- The operator asks to edit an existing image: inpainting, a lighting or weather change, a background replacement, object removal, compositing, or a transparent background
- The operator asks for many assets or variants for one task
- The operator asks for a poster, a piece of art, or a static design as a PNG or PDF

Do not use this for extending or matching an existing SVG or vector icon set, logo system, or illustration library inside the repo. That work edits those assets directly. Do not use this for simple shapes, diagrams, wireframes, or icons that are better produced directly in SVG, HTML, CSS, or canvas. Do not use this when the operator clearly wants deterministic code-native output instead of a generated bitmap.

## Core Principle

A prompt is a recorded spec, not a wish. The same prompt, with the same model and inputs, must make the same image again, close enough to count as the same asset. A canvas starts from a philosophy, not a layout: the philosophy is written first, the canvas expresses it, and the canvas is judged against the philosophy. In both crafts, what cannot be reproduced or checked does not ship.

## Part A: Generate or Edit an Image

### Decide generate or edit

Ask two questions before anything else:

1. **Intent.** Is this a new image or an edit of an existing one? If the operator wants to change an existing image while preserving parts of it, it is an edit. If images are given only as references for style, composition, mood, or subject, it is a generate with references. If no images are given, it is a generate.
2. **Scale.** Is this one asset or many assets and variants? One asset gets one careful call. Many assets get one call per asset or variant, each with its own recorded prompt.

### Label every input image

For every image the operator provides, label its role in plain words before using it:

- Reference image: style, composition, or mood guidance only, never modified
- Edit target: the image being changed
- Supporting input: an insert, a style source, or a compositing input

Never assume a provided image is an edit target. A reference that gets treated as a target is a destroyed original.

### The prompt spec

Reformat the operator's prompt into a short labelled spec. Keep it short and use only the lines that help:

```text
Use case: <taxonomy slug>
Asset type: <where the asset will be used>
Primary request: <the operator's main prompt>
Input images: <Image 1: role; Image 2: role>
Scene/backdrop: <environment>
Subject: <main subject>
Style/medium: <photo, illustration, 3D, etc>
Composition/framing: <wide, close, top-down; placement>
Lighting/mood: <lighting and mood>
Color palette: <palette notes>
Materials/textures: <surface details>
Text (verbatim): "<exact text>"
Constraints: <must keep, must avoid>
Avoid: <negative constraints>
```

Structure the prompt as scene and backdrop, then subject, then key details, then constraints, then output intent. Include the intended use (ad, UI mock, infographic) to set the polish level. Use camera and composition language for photorealism. Quote exact text and specify typography and placement. For tricky words, spell them letter by letter and require verbatim rendering.

### Specificity policy

- If the prompt is already specific and detailed, normalise it into a clean spec without adding creative requirements.
- If the prompt is generic, add tasteful detail only when it materially improves the result: composition or framing cues, intended-use hints, practical layout guidance, or reasonable scene concreteness.

Never add extra characters, props, or objects the request does not imply. Never add brand names, slogans, palettes, or story beats the request does not imply. Never invent a side-specific placement unless the surrounding layout supports it.

### Use-case taxonomy

Classify each request with one slug and keep it consistent across prompts and references.

Generate:

- photorealistic-natural: candid or editorial lifestyle scenes, real texture, natural lighting
- product-mockup: product and packaging shots, catalog imagery, merch concepts
- ui-mockup: app or web interface mockups and wireframes, with the fidelity stated
- infographic-diagram: diagrams and infographics with structured layout and text
- logo-brand: logo and mark exploration, simple and scalable
- illustration-story: comics, children's book art, narrative scenes
- stylized-concept: style-driven concept art, 3D or stylised renders
- historical-scene: period-accurate scenes, clothing, props, and environment matched to the era

Edit:

- text-localization: translate or replace in-image text, preserve layout
- identity-preserve: try-on or person-in-scene, lock face, body, pose, hair, and expression
- precise-object-edit: remove or replace one specific element
- lighting-weather: time of day, season, or atmosphere only, geometry unchanged
- background-extraction: transparent background, clean cutout, crisp silhouette
- style-transfer: apply a reference style while changing the subject or scene
- compositing: multi-image insert or merge with matched lighting, perspective, and scale
- sketch-to-render: drawing or line art to photoreal render, layout and proportions kept

### Workflow for Part A

1. Decide generate or edit, and single asset or many.
2. Decide whether the output is preview-only or meant for the current project.
3. Collect inputs up front: prompt, exact text verbatim, constraints and avoid list, and input images with their roles labelled.
4. If the edit target is only a local file, inspect it first so it is visible in the conversation before editing.
5. Write the prompt spec and generate.
6. Inspect the output and validate: subject, style, composition, text accuracy, and the invariants and avoid items. For edits, repeat the invariants every iteration: change only X, keep Y unchanged.
7. Iterate with one targeted change at a time, then re-check. Never rewrite the whole prompt to fix one defect.
8. For preview-only work, render the image inline. For project-bound work, move the selected final into the workspace and update any consuming code or references. Never leave a project-referenced asset only at a tool default path.
9. Never overwrite an existing asset unless the operator explicitly asked for replacement. Otherwise create a versioned sibling name such as `hero-v2.png` or `item-icon-edited.png`.
10. For batches, persist only the selected finals in the workspace unless the operator explicitly asked to keep discarded variants.
11. Report the final saved path, the final prompt, and the model used.

## Part B: Design a Canvas

A canvas is a single page of visual art as a PNG or PDF, made in two steps: a design philosophy first, then the canvas that expresses it.

### Step 1: Write the design philosophy

Name the movement in one or two words, such as "Brutalist Joy", "Chromatic Silence", or "Metabolist Dreams". Then write the philosophy in 4 to 6 concise paragraphs that say how it shows itself through space and form, colour and material, scale and rhythm, composition and balance, and visual hierarchy.

The philosophy is a visual worldview, not a layout or a template. It guides the next step to express ideas visually, not through text. Information lives in design, not paragraphs. Text is sparse, essential only, and integrated as a visual element, never lengthy. The philosophy must stress, more than once, that the final work looks meticulously crafted, labored over with care, the product of deep expertise at the top of the field. Keep the philosophy generic, without naming the intention of the art, so it can stand on its own. Save it as a `.md` file.

### Step 2: Find the subtle reference

Before drawing the canvas, identify the subtle conceptual thread from the original request. The topic is a quiet reference embedded inside the art itself, not announced. Someone familiar with the subject should feel it intuitively, while everyone else simply experiences a strong abstract composition. The philosophy gives the aesthetic language. The deduced topic gives the soul. Refine it so it deepens the work without announcing itself.

### Step 3: Express it on a canvas

Use the philosophy as the foundation and make one single page, highly visual and design-forward, as a PDF or PNG, unless more pages were asked for. The work is about 90 percent visual design and 10 percent essential text. Use repeating patterns and clean shapes. Treat the philosophy as a strict guide and borrow the visual language of systematic observation: dense accumulation of marks, repeated elements, or layered patterns that build meaning through patient repetition and reward sustained viewing. Add sparse typography and systematic reference markers. Anchor the piece with a simple phrase or detail placed subtly, in a limited palette that feels intentional and cohesive.

Text is always minimal and visual-first, but context guides the scale: a punk venue poster can carry larger, more aggressive type than a minimalist ceramics studio identity. Most of the time the font is thin. Use different fonts where the design calls for it and search the canvas font directory first. Nothing falls off the page and nothing overlaps. Every element stays inside the canvas boundaries with proper margins and breathing room. Check that carefully before delivering. This is non-negotiable for professional execution.

Create original visual designs. Never copy an existing artist's work.

### Step 4: Refine, do not add

Take a second pass. Do not add more graphics. Refine what is there and make it extremely crisp, respecting the philosophy and minimalism entirely. If the instinct is to draw a new shape or add a filter, stop and ask how what is already there can be made more of a piece of art. The final result is one downloadable PDF or PNG, alongside the philosophy `.md` file. For more pages when asked, make each new page a distinct twist on the same philosophy, almost telling a story, and bundle them in the same PDF or as many PNGs.

## Safety Rules

- Do not use media the operator does not have the rights to, and do not copy an existing artist's work.
- Do not invent claims in an infographic or a product image. Every number and fact comes from the brief and is listed at delivery for confirmation.
- Do not put text in an image that was not asked for, and never let generated text misspell a name, a price, or a promise.
- Do not overwrite an existing asset without an explicit ask.
- Do not expose secrets found in reference images. Redact and report the location only.

## Output

- The generated or edited image, saved in the workspace with its final prompt and model recorded
- For a canvas: the PNG or PDF plus the design philosophy `.md` file
- For a batch: the selected finals only, each with its saved path and prompt
- The list of claim lines (prices, numbers, promises) for the operator to confirm

## Verification

- The output is reproducible from the same prompt, model, and inputs
- The subject, style, composition, and text accuracy match the brief
- For edits, the invariants hold: only the named change happened, everything else is unchanged
- For a canvas, the work expresses the written philosophy, nothing overlaps, nothing falls off the page, and text is minimal and essential
- Every project-bound asset lives in the workspace at its reported path, never only at a tool default path

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. The loop ends at a shipped image or canvas with its prompt and philosophy on file, not at a prompt draft. A prompt that cannot reproduce its image is not shipped. Report by work: images generated, edits made, canvases shipped, prompts recorded. Use the related skills (`private-image` when the generation must stay private and unfiltered, `design-tools` when the design needs real tools and named pattern references, `video-generation` when a still becomes a shot in a video, `content-creator` when the image serves a piece of content). Update the agent's memory with the prompts, models, and canvas philosophies that worked so the next image starts from what is proven.

## Related Skills

- `private-image` - the same craft for private, unfiltered generation
- `design-tools` - design with real tools and named pattern references
- `video-generation` - a still image used as a shot or a frame in a video
- `content-creator` - images made to serve a piece of content

## Research source

openai/skills imagegen, https://github.com/openai/skills
anthropics/skills canvas-design, https://github.com/anthropics/skills/tree/main/skills
