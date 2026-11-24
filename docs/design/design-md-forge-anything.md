---
name: design-md-forge-anything
description: "Design system reference for Forge Anything."
---

# Design System: Forge Anything

## 1. Visual Theme and Atmosphere

Forge Anything feels warm, crafted, calm, human, clear, and made, not generated. The reference is the README banner, `docs/assets/social-preview.png` (1280x640). That image is the design source of truth: every color, type choice, and image rule in this spec comes from it.

The scene is a long table where small matte stone figures work in warm natural light: a magnifying glass, a laptop, an anvil, a glowing case, a small stone furnace with fire. One scene, not a collage. Calm and uncluttered, with the forge as the making: heat, hammer, craft.

**Key characteristics:**
- Warm cream surfaces, never stark white and never dark
- Matte stone and clay figures, rounded, off-white, small in the frame
- A forge and an anvil as the central motif
- Warm natural light, calm and uncluttered composition
- No violet, no purple, no neon, no mascot
- No logo mark on the banner

## 2. Color Palette and Roles

Sampled from `docs/assets/social-preview.png`:

### Surface
- **Background cream** (`#f0e2c9` dominant, `#eddfc6`, `#eadac0`): the surface for pages, cards, and docs. Cream is the surface.

### Text
- **Text charcoal** (`#1b1b19`): near-black, for titles and body text. Charcoal is the text.

### Material
- **Stone taupe** (`#c1af9e` figures, `#a79279` shadowed stone): the material of the figures. Taupe is the material.
- **Forge tan** (`#daa770`): table and furnace stone.
- **Shadow brown** (`#95856d`): vignette and deep shadow.

### Accent
- **Fire amber** (`#e99e41`): the forge flame, the only hot accent. Use it sparingly: the forge flame, a launch moment, a single highlight. It is never a background and never a gradient wash.

Do not reintroduce violet or purple. The old violet logo is gone with the old violet-on-black look.

## 3. Typography Rules

- **Hero and title:** serif, bold, dark charcoal. The banner title "Forge Anything" is a classic serif.
- **Subtitle and body:** sans-serif, regular, dark charcoal. The banner subtitle "in your company, and in your life." is sans-serif.
- **Mono only for:** commands, code, paths, hashes, logs, config snippets.

Do not turn the whole product into a monospace wall. Do not set body text in serif.

## 4. Logo Usage

The logo mark is three stone figures leaning inward around a glowing four-pointed gold spark, in the banner's warm cream and stone style. Mark only, no text.

- `docs/assets/logo.webp` (1600x1600): the full mark.
- `docs/assets/favicon.webp` (256x256): the small mark.

Use the mark on cream. Never place it on violet, purple, or neon, and never pair it with the deleted old logo.

## 5. Surfaces and Components

Forge Anything surfaces must show the work, not decorate it:

- agents, skills, commands, and workflows
- the phases Goal, Plan, Build, Verify, Ship
- tests and evidence
- distribution, where the loop ends

Do not make Forge Anything look like a prompt pack, a generic docs template, a neon hacker console, a vague splash page, a mascot gallery, or a decorative bento grid without execution proof.

## 6. Diagram Rules

Good Forge Anything diagrams show the phases, delegation, test gates and evidence checks, distribution, and source-of-truth files. Reject diagrams that are only decorative node webs.

## 7. Quality Gate

Before shipping Forge Anything UI or docs visuals, verify the palette matches the banner (warm cream, charcoal, taupe, amber fire only), there is no violet, no purple, and no neon, execution proof is visible, the agent, skill, and command structure is inspectable, tests and evidence are not hidden, public-facing visuals do not imply artificial general intelligence, and the banner is the reference, not a mood board.
