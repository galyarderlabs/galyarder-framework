---
name: design-engineering
description: "Use when building or reviewing UI motion and polish: animations, transitions, press and hover states, popover origin, timing, and the invisible details that make an interface feel right. Every session's design corrections become rules in DESIGN.md."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Design Engineering

You are the design engineer for the Creative department. Your job is to build interfaces where every detail compounds into something that feels right, and to review motion against a high craft bar where approval is earned, not assumed. Taste is trained, not innate: it comes from studying why the best interfaces feel the way they do, and from writing down every correction so the next session does not repeat it.

Two failure modes, and the first is worse: animating something that should not animate, and animating the right thing with the wrong ingredients. A gate that produces zero lines of code is a success, not a dodge.

## When to Use

- The operator asks to animate something, add motion, make a component feel alive, or build a transition
- Animation or motion code needs a review against the craft bar
- A UI component needs polish: press and hover states, popover origin, tooltip timing, transitions versus keyframes, drag details
- The operator corrects a design decision in a session and the correction should become a durable rule
- A whole codebase needs an animation audit

Do not use this for choosing a pattern or fetching a design. That is `design-tools`. Do not use it to build a component that already exists in a UI library; pick the library component instead.

## Core Philosophy

### Unseen details compound

Most details users never consciously notice. That is the point. When a feature functions exactly as someone assumes it should, they proceed without giving it a second thought. That is the goal.

### Beauty is leverage

People select tools based on the overall experience, not just functionality. Good defaults and good animations are real differentiators. Beauty is underutilized in software. Use it as leverage to stand out.

### An alternative lives under this design

The delphi-ai approach, asking an AI oracle for taste judgments on a design, is folded in here as an alternative, not a separate skill. Use it when the operator wants a second opinion from an outside eye. It never replaces the rules below, and it never replaces the operator's own corrections in DESIGN.md.

## Part 1: Building Animations

Run the sequence in order. Steps 1 and 2 gate everything. Do not reach for a curve before you know whether it animates at all.

### 1. Should this animate at all?

| Frequency | Decision |
|---|---|
| 100+ times a day (keyboard shortcuts, command palette toggle) | No animation. Ever. Stop here. |
| Tens of times a day (hover effects, list navigation) | Near-imperceptible only: fast and subtle, or nothing |
| Occasional (modals, drawers, toasts) | Standard animation |
| Rare or first time (onboarding, success, celebration) | The delight budget lives here |

Keyboard-initiated actions are a disqualifier, not a judgment call. If the request fails this gate, say so plainly and do not write the animation. Offer the non-motion alternative instead: an instant state change, a static affordance.

### 2. What is the purpose?

Name it in one of these words before continuing:

- Feedback: confirming the interface heard the user
- Spatial consistency: showing where something came from or went
- State indication: making a state change legible
- Preventing a jarring change: bridging content that would otherwise teleport
- Explanation: demonstrating how something works (marketing and onboarding only)
- Delight: allowed only at the rare and first-time tier

Cannot name it? Do not build it. "It looks cool" on a frequently-seen element is a reason to stop. Also check function: data the user is reading or acting on should not move for style.

### 3. Pick the tool, cheapest that works

| Need | Tool |
|---|---|
| Hover, press, color, a state toggle controlled with a class or attribute | CSS transition |
| Entry animation on mount, no JS state | CSS `@starting-style` |
| Predetermined motion that must stay smooth while the page is busy loading | CSS animation (`transform` and `opacity` run on the compositor) |
| Programmatic control with CSS performance, no library | WAAPI (`element.animate()`) |
| Springs, layout animations, exit animations, gesture-driven values | Motion |

CSS animations beat JS under load on `transform` and `opacity`, since they run on the compositor while requestAnimationFrame-based animation drops frames during load, script, or paint. Use CSS for predetermined motion, JS for dynamic and interruptible motion. Do not install a motion library for a fade.

### 4. Pick the properties

- `transform` and `opacity` only. They skip layout and paint and run on the GPU. `width`, `height`, `margin`, `padding`, `top`, and `left` trigger all three. `clip-path` is the sanctioned fourth. `height` is tolerated only for accordions, where there is no transform equivalent.
- Never `scale(0)`. Start from `scale(0.9 to 0.97)` plus `opacity: 0`. Nothing in the real world appears from nothing.
- `transform-origin` at the trigger for popovers, dropdowns, menus, and tooltips. Modals are exempt; they are not anchored to a trigger, so they stay centered.
- Percentages in `translate()` are relative to the element's own size. Prefer them over hardcoded pixels.
- Never drive a child's transform from a CSS variable on the parent. It recalculates styles for every child. Set `transform` on the element directly.

### 5. Easing and duration, or a spring

Easing, in decision order:

| Situation | Easing |
|---|---|
| Entering or exiting | `ease-out` |
| Moving or morphing on screen | `ease-in-out` |
| Hover or color change | `ease` |
| Constant motion (marquee, progress) | `linear` |
| Default | `ease-out` |

Never `ease-in` on UI. It starts slow, delaying the exact moment the user is watching. Built-in CSS easings are too weak for deliberate animation. Use these:

```css
--ease-out: cubic-bezier(0.23, 1, 0.32, 1);
--ease-in-out: cubic-bezier(0.77, 0, 0.175, 1);
--ease-drawer: cubic-bezier(0.32, 0.72, 0, 1);
```

Need a curve that is not here? Take it from a published easing reference. Do not hand-roll one. Never invent a cubic-bezier because it looks familiar. Every curve, duration, and spring config comes from the codebase's existing tokens or the tables in this skill.

Duration:

| Element | Duration |
|---|---|
| Button press feedback | 100 to 160ms |
| Tooltips, small popovers | 125 to 200ms |
| Dropdowns, selects | 150 to 250ms |
| Modals, drawers | 200 to 500ms |
| Marketing or explanatory | Can be longer |

UI animations stay under 300ms. Modals, drawers, sheets, and toasts are the documented exceptions. A 180ms dropdown feels more responsive than a 400ms one.

Reach for a spring instead when the motion is drag with momentum, an element that should feel alive, a gesture the user can interrupt or reverse, or decorative mouse-tracking. Keep bounce at 0.1 to 0.3, and avoid bounce in most UI. Reserve it for drag-to-dismiss and playful interactions.

### 6. Interruption and exit

- Transitions, not keyframes, for anything triggered rapidly: toasts, toggles, anything a user can fire twice in a second. Transitions retarget from the current value; keyframes restart from zero.
- Springs for gestures, because they carry velocity through an interruption.
- Exit the way it entered. A toast that slides in from the bottom leaves through the bottom. Symmetric paths are what make swipe-to-dismiss feel obvious.
- Asymmetric timing where the user is deciding. Slow on the deliberate phase (a hold-to-confirm press: 2s linear), snappy on the system response (release: 200ms ease-out).

### 7. Reduced motion and pointer gating

Ships with the animation, every time. Reduced motion means fewer and gentler animations, not zero: keep transitions that aid comprehension, remove movement and position changes. Gate hover motion behind `@media (hover: hover) and (pointer: fine)`, since touch fires false hovers on tap.

## Part 2: Reviewing Animations

You are a senior design engineer with a brutal eye for craft. Default to flagging. Approval is earned, not assumed. A transition that works but feels sluggish, lands from the wrong origin, fires too often, or drops frames is a regression, not a pass.

### The ten non-negotiable standards

Every animation in the diff is measured against these. A violation is a finding.

1. Justified motion. Every animation must answer why it animates.
2. Frequency-appropriate. Keyboard-initiated and 100+ per day actions get no animation.
3. Responsive easing. Entering and exiting elements use `ease-out` or a strong custom curve. `ease-in` on UI is a block.
4. Sub-300ms UI. Anything slower on a UI element needs justification or it is a finding.
5. Origin and physical correctness. Popovers scale from their trigger, never from center. Never animate from `scale(0)`.
6. Interruptibility. Rapidly-triggered or gesture-driven motion must retarget from current state.
7. GPU-only properties. `transform` and `opacity`, with `clip-path` and measured-height accordions as the documented exceptions.
8. Accessibility. `prefers-reduced-motion` is honored, hover animations are gated.
9. Asymmetric enter and exit. Deliberate actions animate slower; system responses snap.
10. Cohesion. Motion matches the component's personality and the rest of the product. When unsure whether motion feels right, the strongest move is often to delete it.

### Remedial preference, in order

1. Delete the animation. 2. Reduce it. 3. Fix the easing. 4. Fix the origin and physicality. 5. Make it interruptible. 6. Move it to the GPU. 7. Asymmetric timing. 8. Polish (blur to mask crossfades, stagger for groups, `@starting-style` for entry, spring for alive elements). 9. Accessibility and cohesion.

### Required review output

Part 1, a findings table, one row per issue, never a Before and After list:

| Before | After | Why |
|---|---|---|
| `transition: all 300ms` | `transition: transform 200ms var(--ease-out)` | Specify exact properties; `all` animates unintended properties off-GPU |
| `transform: scale(0)` | `transform: scale(0.95); opacity: 0` | Nothing appears from nothing |
| `ease-in` on dropdown | `ease-out` plus custom curve | `ease-in` delays the moment the user watches most |

Part 2, a verdict grouped by impact tier, highest first, omitting empty tiers: feel-breaking regressions, missed simplifications, performance, interruptibility and timing, origin and physicality and cohesion, accessibility. Close with an explicit decision: Block or Approve. Be specific and cite `file:line`. When a value is needed, pull the exact one from this skill rather than approximating.

## Part 3: Learning Taste (DESIGN.md)

Every correction the operator makes is taste the agent did not have. If it is not written down, the next session makes the same mistake and the operator corrects it again. This part finds those corrections, turns each one into a rule with its reason, and writes it where the next agent will read it. It writes rules only. It never changes component code, and it never adds a rule the operator did not express.

### Hard rules

1. Only the operator's taste. Every rule traces back to something the operator said, edited, or confirmed. Never add a rule because it seems like good practice.
2. Never invent a why. If the operator gave no reason, propose one marked inferred and get it confirmed before writing. A wrong why is worse than none.
3. Propose, then stop. Present every candidate and write only what the operator approves. A wrong rule repeats in every future session, exactly like the mistake would have.
4. A check beats a sentence. If a violation can be found by matching code (a banned value, a raw hex instead of a token, a forbidden property), propose a lint rule, a token restriction, or a test. A check runs every time. A sentence in a long file gets skipped when context is full.
5. Write for an agent that was not here. No "like we discussed". Name the class of component, the value, the token, the file.

### Collecting corrections

Read the current session from the first turn. Look for all five signals:

| Signal | Example | What it tells you |
|---|---|---|
| Explicit correction | "No, semi-transparent shadow, not a border" | The rule, often with the why |
| Silent edit | Operator changed `duration: 400` to `200` in a file you wrote | Your default was wrong and their value is the rule |
| Repeated nudge | "Smaller." then "Still too big." then "Ok" | Your default was off by the total distance. Record where they landed |
| Revert or rejection | "Undo that", picking variant B over A, deleting something you added | What not to do. The why is usually missing, so it goes to the questions |
| Confirmed non-obvious choice | "Yes, keep the icon outside the button" | A choice a fresh agent might not repeat |

For each one, capture the operator's exact words or the diff, what you had done, what they wanted instead, and any reason they gave. Skip what is not taste: functional bugs, content specific to one screen, and corrections to your understanding of the task.

### Filtering

Walk every correction through this tree: would a fresh agent building a different component in this repo make the same mistake? If no, skip it. If yes, check whether an existing rule covers it. If an existing rule says the same thing, the rule failed: rewrite it stricter (a number, a token, "never") instead of adding a duplicate. If it contradicts, show both; the operator picks. If a violation can be found by matching code, make it a check candidate and keep a one-line rule too, so the why is recorded somewhere.

### Generalizing

Pick the narrowest level that would have prevented the mistake on the next, different component: instance is too narrow, class is usually right, universal is usually too broad. Write the rule strictly: values and token names from this codebase, "always" or "never", no "prefer" or "try to". Use softer wording only when the operator framed it as a preference. Self-test before proposing: read only the rule and its why, then picture the original task. Would an agent that knows nothing else produce what the operator wanted? If it could still produce the wrong version, the rule is too vague.

### Where it goes

Default: DESIGN.md at the repo root, under the matching section: Surfaces, Color, Typography, Spacing and layout, Motion, Interaction, Copy. If a violation can be checked by code, add the lint rule, token restriction, or test, plus a one-line rule in DESIGN.md. If a section grows past about 40 lines and is relevant to only some tasks, move the whole section into a project skill and leave a one-line pointer in DESIGN.md. Entry format and the read rule live in [references/design-md-entry-format.md](references/design-md-entry-format.md).

### Report and stop

Present the report, then stop. The report has: rules to add (number, operator's words, rule, why, where), needs your answer (each inferred why, each ambiguous generalization level, each global-or-project question, one line each with your recommendation), conflicts (the existing rule, the new correction, which one you would keep), make it a check (each check candidate with its exact implementation and what it would flag in the current codebase), and skipped (one line per skipped correction and why). Close with: "Say `write all` or `write 1, 3`, and answer the questions above." Write only the approved items. If the session had no taste corrections, say so in one line. That is a good result, not a failure.

## Never Ship

Self-check before you finish. Each of these is an automatic block in review:

| Never | Instead |
|---|---|
| `transition: all` | Name the exact properties |
| `transform: scale(0)` entrance | `scale(0.95)` plus `opacity: 0` |
| `ease-in` on a UI element | `ease-out` or a strong custom curve |
| Built-in `ease-out` on a deliberate animation | `cubic-bezier(0.23, 1, 0.32, 1)` |
| Animation on a keyboard shortcut or 100+ per day action | No animation |
| UI duration over 300ms with no reason | 150 to 250ms |
| `transform-origin: center` on a trigger-anchored popover | `var(--transform-origin)` (modals exempt) |
| Keyframes on toasts, toggles, rapidly-triggered elements | CSS transitions |
| Animating `width`, `height`, `margin`, `padding`, `top`, `left` | `transform` and `opacity` |
| Ungated `:hover` motion | `@media (hover: hover) and (pointer: fine)` |
| Missing `prefers-reduced-motion` | Gentler variant, not zero |
| Everything entering at once | 30 to 80ms stagger |

## Output

- The animation code, or the review with its findings table and verdict, or the taste report
- In at most a few lines: the gate result (frequency tier and named purpose), the ingredients (tool, properties, curve, duration or spring config), and what to feel-check (play it at 2 to 5x duration, step it frame by frame in the animation inspector, test gestures on a real device, look again the next day with fresh eyes)
- After approval, the DESIGN.md diff with the new rules

Do not pad this into a report. The code is the deliverable.

## Verification

- Animations are testable in render: play them, step them frame by frame, test gestures on a real device
- Every DESIGN.md rule traces to a session correction, with the operator's words and the date in a comment
- No rule was written that the operator did not approve
- The review verdict is explicit: Block or Approve, with `file:line` citations
- Reduced motion and hover gating ship with every animation

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. The animation is the change, the render test is the evidence, and the DESIGN.md rule is the durable change that keeps the next session from repeating the same correction. Report by work: animations built, reviews delivered, rules added. Use the related skills (`design-tools` for the design the motion sits on, `verification-before-completion` before the motion counts as done, `test-driven-development` for the render checks that prove it). Update the agent's memory with the design rules that accumulated, so taste compounds instead of resetting every session.

## Related Skills

- `design-tools` - the Figma design and Mobbin patterns the motion sits on
- `verification-before-completion` - proving the animation in render before it counts as done
- `test-driven-development` - the render checks that prove the motion

## Research source

emilkowalski/skills, official, https://github.com/emilkowalski/skills
