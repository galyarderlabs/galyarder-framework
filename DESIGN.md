# DESIGN.md — Forge Anything Design

## Status

This is the product-specific design guide for **Forge Anything**.

The reference is the README banner, `docs/assets/social-preview.png` (1280x640). That image is the design source of truth: every color, type choice, and image rule below comes from it. The logo mark is three stone figures leaning inward around a glowing four-pointed gold spark, in the banner's warm cream and stone style. It comes from Galih's example lockup (the figures + spark), which comes from the banner's stone figures. Files: `docs/assets/logo.webp` (1600x1600), `docs/assets/favicon.webp` (256x256), `public/logo.png` (1024x1024). The old purple Galyarder "G" logo is deleted and must not be reintroduced.

## Design Role

Forge Anything is the tool that lets an AI agent forge anything: the agent gets the tools that do the work, the skills to use them right, and a scaffold to start clean, so even a regular chatbot can add the MCP and forge anything.

It should feel:

- warm,
- crafted,
- calm,
- human,
- clear,
- made, not generated.

## Surface Rules

Forge Anything surfaces must show:

- agents,
- skills,
- commands,
- workflows,
- the five phases (Goal, Plan, Build, Verify, Ship),
- tests and evidence,
- distribution (where the loop ends).

Do not make Forge Anything look like:

- a prompt pack,
- generic docs template,
- neon hacker console,
- vague splash page,
- AI mascot gallery,
- decorative bento grid without execution proof,
- the old violet-on-black Galyarder Framework look.

## Visual System

The banner sets the system:

- Background: warm cream, soft and light, not white and not dark.
- Figures: matte stone/clay figures, rounded, off-white, small in the frame.
- Motif: a forge (small stone furnace with fire) and an anvil. The forge is the making: heat, hammer, craft.
- Composition: a long table, figures working (magnifying glass, laptop, anvil, glowing case), warm natural light, calm and uncluttered. One scene, not a collage.
- No violet, no purple, no neon. No mascot. No logo mark on the banner.

## Color Rules

Sampled from `docs/assets/social-preview.png`:

```text
Background cream:  #f0e2c9 (dominant), #eddfc6, #eadac0
Text charcoal:     #1b1b19 (near-black, for titles and body text)
Stone taupe:       #c1af9e (figures), #a79279 (shadowed stone)
Forge tan:         #daa770 (table and furnace stone)
Fire amber:        #e99e41 (the forge flame, the only hot accent)
Shadow brown:      #95856d (vignette and deep shadow)
```

Rules:

- Cream is the surface. Charcoal is the text. Taupe is the material.
- Fire amber is the accent and it is used sparingly: the forge flame, a launch moment, a single highlight. It is never a background and never a gradient wash.
- Do not reintroduce violet or purple. The old logo color is gone with the logo.

## Typography

From the banner:

- Hero/title: serif, bold, dark charcoal. The banner title "Forge Anything" is a classic serif.
- Subtitle/body: sans-serif, regular, dark charcoal. The banner subtitle "in your company, and in your life." is sans-serif.
- Mono only for: commands, code, paths, hashes, logs, config snippets.

Do not turn the whole product into a monospace wall. Do not set body text in serif.

## Diagram Rules

Good Forge Anything diagrams show:

- the five phases (Goal, Plan, Build, Verify, Ship),
- agent delegation,
- test gates and evidence checks,
- distribution (where the loop ends),
- source-of-truth files.

Reject diagrams that are only decorative node webs.

## Quality Gate

Before shipping Forge Anything UI/docs visuals, verify:

- the palette matches the banner (warm cream, charcoal, taupe, amber fire only),
- no violet, no purple, no neon,
- execution proof is visible,
- agent/skill/command structure is inspectable,
- tests and evidence are not hidden,
- public-facing visuals do not imply artificial general intelligence,
- the banner is the reference, not a mood board.
