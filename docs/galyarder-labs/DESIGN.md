---
name: Galyarder Labs Design System
version: 1
language: en
system: Dream-Airlock-Machine

colors:
  brand:
    violet: "#8A00FF"
    deepMidnight: "#061126"
    charcoalNavy: "#0D172A"
    luminousIvory: "#F7F0E6"
    softGold: "#F1C77A"
    twilightPurple: "#4F2DA8"
    periwinkleBlue: "#6F7DFF"
    mistBlue: "#DCE6FF"
    warmStone: "#B89B7A"
    pureWhite: "#FFFFFF"
    softFog: "#F4F1EC"
    ink: "#171717"
    mutedInk: "#5F636B"

  effects:
    violetGlow: "rgba(138, 0, 255, 0.35)"
    violetGlowStrong: "rgba(138, 0, 255, 0.45)"
    goldThresholdGlow: "rgba(241, 199, 122, 0.42)"
    goldMist: "rgba(241, 199, 122, 0.72)"
    periwinkleMist: "rgba(111, 125, 255, 0.20)"
    hairlineLight: "rgba(255, 255, 255, 0.12)"
    mutedLight: "rgba(255, 255, 255, 0.68)"

  productLight:
    surface: "#ffffff"
    surfaceDim: "#f8f8f8"
    surfaceContainerLow: "#f5f5f5"
    surfaceContainer: "#efefef"
    surfaceContainerHigh: "#e8e8e8"
    surfaceContainerHighest: "#e0e0e0"
    onSurface: "#0a0a0a"
    onSurfaceVariant: "#525252"
    outline: "#d4d4d4"
    outlineVariant: "#e5e5e5"

  productDark:
    surface: "#141313"
    surfaceDim: "#0e0e0e"
    surfaceContainerLow: "#1c1b1b"
    surfaceContainer: "#222222"
    surfaceContainerHigh: "#2a2a2a"
    surfaceContainerHighest: "#333333"
    onSurface: "#f5f5f5"
    onSurfaceVariant: "#a3a3a3"
    outline: "#434655"
    outlineVariant: "#2d2f3a"

  semantic:
    info: "#3b82f6"
    infoDark: "#b4c5ff"
    success: "#10b981"
    successDark: "#86efac"
    warning: "#eab308"
    warningDark: "#fdba74"
    error: "#ef4444"
    errorDark: "#fca5a5"

  gradients:
    futureThreshold: "linear-gradient(115deg, #061126 0%, #0D172A 32%, #4F2DA8 72%, #F1C77A 100%)"
    luminousMist: "radial-gradient(circle at 70% 50%, rgba(241,199,122,0.72), rgba(111,125,255,0.20) 38%, rgba(6,17,38,0) 70%)"
    violetIdentityGlow: "radial-gradient(circle, rgba(138,0,255,0.45), rgba(138,0,255,0.08) 45%, rgba(138,0,255,0) 75%)"

typography:
  display:
    fontFamily: "Cormorant Garamond, Libre Baskerville, Georgia, serif"
    fontWeight: 500
    lineHeight: 0.98
    letterSpacing: "-0.03em"
  displayAlternative:
    fontFamily: "Canela, Editorial New, New York, Georgia, serif"
    fontWeight: 500
  body:
    fontFamily: "Inter, Satoshi, Geist, system-ui, sans-serif"
    fontSize: "16px"
    fontWeight: 400
    lineHeight: 1.65
  label:
    fontFamily: "Inter, Satoshi, Geist, system-ui, sans-serif"
    fontSize: "13px"
    fontWeight: 600
    letterSpacing: "0.08em"
  mono:
    fontFamily: "JetBrains Mono, IBM Plex Mono, SFMono-Regular, monospace"
    fontSize: "13px"
    fontWeight: 500

spacing:
  scale:
    1: "4px"
    2: "8px"
    3: "12px"
    4: "16px"
    5: "20px"
    6: "24px"
    8: "32px"
    10: "40px"
    12: "48px"
    16: "64px"
    20: "80px"
    24: "96px"

radius:
  sm: "6px"
  md: "10px"
  lg: "16px"
  xl: "24px"
  full: "999px"

motion:
  airlockDuration: "1000ms-2000ms"
  standardDuration: "180ms-240ms"
  reducedMotionRequired: true

layers:
  dream:
    surfaces: ["landing", "marketing", "social", "pitch", "public-brand"]
    feeling: "luminous editorial threshold"
  airlock:
    surfaces: ["auth", "loading", "onboarding", "post-login"]
    feeling: "identity continuity before operational density"
  machine:
    surfaces: ["dashboard", "ledger", "hq", "framework", "agent", "reports", "admin", "settings", "billing"]
    feeling: "institutional command machine"

products:
  public:
    - Galyarder Ledger
    - Galyarder HQ
    - Galyarder Framework
    - Galyarder Agent
  pipeline:
    - Galyarder Vault
    - Galyarder OS
    - Galyarder Alpha
    - Galyarder Quant
    - Galyarder Wallet
    - Galyarder Mind
---

# DESIGN.md — Galyarder Labs Final Design System

This is the single canonical visual and product design source of truth for Galyarder Labs and the Galyarder product ecosystem.

It is designed for humans and agents. The YAML front matter provides machine-readable tokens. The markdown body explains the design logic, product surface rules, and quality bar.

The core experience model is:

> **Dream → Airlock → Machine**

---

## 1. Overview

Galyarder has one identity expressed through three visual layers.

- **Dream:** public-facing luminous invitation.
- **Airlock:** transition layer that preserves brand continuity before operational density.
- **Machine:** authenticated product layer where work becomes structured, governed, audited, and executed.

The system exists to prevent two failures:

1. A beautiful brand that never proves the machine.
2. A powerful product that loses the emotional identity of the brand.

The design must move the user from wonder to trust.

---

## 2. Three Visual Layers

### Layer 1 — Dream

Use for:

- landing pages,
- hero sections,
- social covers,
- pitch openers,
- manifesto pages,
- public brand campaigns.

Feeling:

- calm,
- luminous,
- editorial,
- human,
- spacious,
- threshold-like,
- premium,
- quietly powerful.

Allowed:

- editorial serif,
- lone figure,
- luminous mist,
- violet/gold identity accents,
- spacious negative space,
- cinematic composition.

Forbidden:

- crypto coins,
- robot heads,
- cyberpunk clutter,
- red danger palettes,
- generic AI neon,
- decorative node webs,
- excessive HUD graphics.

### Layer 2 — Airlock

Use for:

- login,
- signup,
- loading,
- onboarding,
- post-auth bridge,
- product switch moments,
- critical identity confirmations.

Purpose:

The Airlock prevents conceptual whiplash. Users should not be thrown from luminous public brand into cold operational density without a decompression moment.

Required elements:

- GS mark or Galyarder lockup,
- Violet Identity Glow `#8A00FF`,
- restrained Soft Gold threshold trace `#F1C77A`,
- minimal status phrase,
- 1–2 second transition,
- reduced motion alternative.

Example status phrases:

- Preparing command layer.
- Loading operational context.
- Restoring agent state.
- Synchronizing ledger evidence.
- Opening the machine.

Forbidden:

- fake boot noise,
- hacker terminal theatrics,
- red alert animations,
- long cinematic loading delays,
- heavy grain behind small text.

### Layer 3 — Machine

Use for:

- Ledger,
- HQ,
- Framework,
- Agent,
- dashboards,
- workforce views,
- reports,
- admin,
- settings,
- billing,
- audit surfaces.

Feeling:

- operational,
- monochrome,
- semantic,
- dense but readable,
- institutional,
- audit-ready,
- high-signal,
- trusted before beautiful.

Allowed:

- neutral surfaces,
- strict hierarchy,
- semantic status colors,
- data density,
- structured tables,
- agent state indicators,
- audit trails,
- command panels.

Forbidden:

- decorative violet/gold flooding,
- glass fantasy dashboards,
- overuse of glow,
- monospace walls,
- unreadable density,
- marketing poetry in operational flows.

---

## 3. Color Rules

### Core Law

```text
Brand colors are identity.
Semantic colors are information.
Surface colors are structure.
Do not mix them.
```

### Brand Colors

Use Galyarder Violet and Soft Gold for:

- logo,
- identity glow,
- auth,
- Airlock,
- splash,
- brand-level milestones,
- payment success,
- premium identity moments.

Do not use them for:

- KPI deltas,
- warning badges,
- error states,
- report status,
- chart semantics,
- default dashboard buttons,
- operational severity.

### Semantic Colors

Use semantic colors only when information state requires it.

| Meaning | Light | Dark | Use |
|---|---:|---:|---|
| Info / action | `#3b82f6` | `#b4c5ff` | active neutral state, primary operational action |
| Success | `#10b981` | `#86efac` | positive outcome, completed task, healthy state |
| Warning | `#eab308` | `#fdba74` | review-needed, budget caution, ambiguous state |
| Error | `#ef4444` | `#fca5a5` | failed, destructive, blocked, risky state |

### Surface Colors

Product surfaces should rely on neutral hierarchy. Color is not decoration inside the Machine.

### Forbidden Color Patterns

- violet KPI numbers,
- gold warning badges,
- green Matrix UI,
- red dystopian brand world,
- rainbow neon,
- crypto-gold overload,
- full-screen violet floods,
- ad-hoc gold or blue variants without token registration.

---

## 4. Typography Rules

### Marketing Typography

Marketing may use editorial serif for hero moments, manifesto openers, and premium brand statements.

Recommended:

- Cormorant Garamond,
- Libre Baskerville,
- Georgia,
- Canela,
- Editorial New,
- New York.

### Product Typography

Product uses sans-serif.

Recommended:

- Inter,
- Satoshi,
- Geist,
- system-ui.

Use product sans for:

- dashboards,
- Ledger,
- HQ,
- Framework UI,
- Agent UI,
- reports,
- admin,
- settings,
- billing,
- docs.

### Mono Typography

Mono is for machine-readable details only:

- hashes,
- IDs,
- logs,
- ledger references,
- code,
- commands,
- technical labels.

Hard rule:

> Do not create a monospace military wall. Monospace is a tool, not the product personality.

---

## 5. Layout & Spacing

### Dream Layout

- large negative space,
- editorial asymmetry,
- left-weighted lockups,
- human figure small against vast structure,
- threshold or horizon in depth,
- few words with high impact,
- generous breathing room.

### Airlock Layout

- centered identity,
- minimal copy,
- soft glow,
- no operational density yet,
- one clear progress/status signal.

### Machine Layout

- clear scan path,
- strong grid,
- responsive density,
- mobile-native cards,
- desktop tables where useful,
- no fake complexity,
- data legible before decorative.

---

## 6. Imagery

### Keep

- lone figure,
- threshold,
- architecture,
- mist,
- path,
- vault,
- horizon,
- luminous portal,
- quiet control room,
- future archive,
- institutional surfaces.

### Avoid

- robot heads,
- crypto coins,
- random nodes,
- generic HUD,
- over-scratched film damage,
- red sci-fi,
- weapons/military literalism,
- AI stock imagery,
- faces as default universal brand hero.

---

## 7. Texture & Atmosphere

Texture must be subtle.

Rules:

- Grain should be light and atmospheric, not dirty.
- Scratch overlays are rare, not default.
- Do not place small text over heavy grain.
- Do not use top-left flare on every slide.
- Do not reduce legibility for mood.
- Do not use visual complexity to fake intelligence.

---

## 8. Component Style

### Buttons

- Product primary buttons use operational primary color, not brand gold.
- Marketing CTAs may use restrained brand identity treatment.
- Destructive actions must use semantic error treatment.

### Cards

- Dream cards may be glassy and atmospheric.
- Machine cards should use neutral containers, borders, and hierarchy.
- Admin cards should be severe and low-decoration.

### Inputs

- Clear labels.
- High contrast.
- Visible focus states.
- No decorative placeholder-only UI.

### Badges

Badges must be semantic or structural.

Allowed examples:

- `Active`
- `Review Needed`
- `Blocked`
- `Synced`
- `Budget Limit`
- `Approval Required`
- `Read-only`

Forbidden:

- badges that use violet/gold purely to look branded,
- badges that communicate status with color alone.

### Glass

Glass is allowed for:

- Airlock,
- overlays,
- floating sheets,
- identity moments,
- public hero previews.

Glass is not the core product surface language.

### Terminal Cards

Terminal cards are allowed only for:

- logs,
- commands,
- build output,
- code execution,
- Framework technical states.

They must not become the entire product aesthetic.

---

## 9. Product Surface Rules

These surface rules are hard gates for human designers and AI design agents. If a screen fits multiple surfaces, obey the strictest applicable rule and preserve Dream → Airlock → Machine.

| Surface | Required behavior | Rejected behavior |
|---|---|---|
| Landing | Dream layer: luminous, calm, editorial, spacious, readable, threshold-like, with restrained violet/gold identity accents and clear product proof direction. | Generic AI landing pages, crypto spectacle, robot heads, decorative node webs, unreadable cinematic texture, or product claims with no evidence direction. |
| Auth | Airlock layer: identity continuity, GS mark or Galyarder lockup, Violet Identity Glow, Soft Gold threshold trace, minimal form friction, visible security/focus states. | Cold generic login, hacker boot screens, long cinematic delay, heavy grain behind form fields, or brand colors used as validation/error semantics. |
| Airlock | Transition layer: 1–2 second decompression, minimal status phrase, reduced-motion alternative, calm bridge from Dream to Machine. | Hard-cut from marketing into dense product UI, fake terminal noise, red-alert animation, or motion that hides system state. |
| Dashboard | Machine layer: trusted before beautiful, neutral surfaces, semantic status, clear scan path, command state, evidence and workflow visibility. | Calling HQ a dashboard, using marketing glow/gradient as product chrome, vanity KPIs without proof, or generic SaaS bento clutter. |
| Ledger | Operational financial workspace with ledger state transitions, evidence, G-Agent workforce status, review-needed states, guarded execution, reports, and audit readiness. | Bookkeeping toy aesthetics, warung/Excel replacement framing, decorative crypto visuals, cute G-Agent avatars, or unreviewed permanent state changes. |
| HQ | Strategic Command Interface with org charts, departments, reporting lines, goals, budgets, token costs, hard stops, approval gates, rollback, and multi-company isolation. | Reducing HQ to chat, generic dashboards, micromanagement noise, or command surfaces without budget/approval visibility. |
| Framework | Intelligence Layer for Autonomous Goal Integration with blueprints, tickets, SOPs, skills/templates, workflows, agent runtime, TDD/tests, audits, execution proof, and tool integrations. | Prompt-pack aesthetics, vague AGI claims, hiding tests/audits, or treating the public developer-facing framework as only internal. |
| Agent | Continuity Layer with persistent memory, local profile, values, voice, visual identity, channel presence, scheduled jobs, and continuity records. | Generic chatbot UI, confusing Galyarder Agent with Ledger G-Agents, implying the human is replaced, or relying only on message bubbles. |
| Workforce | Machine layer: role-based G-Agent activity, state, assignments, outputs, guardrails, review queues, escalation, and evidence. Agents should feel operational and alive, not cute. | Mascot companions, toy assistants, unbounded autonomy, hidden guardrails, or status communicated by color alone. |
| Reports | Clean, export-ready, audit-ready, high-contrast, print-safe, with source references, evidence trail, timestamps, and clear assumptions. | Cinematic backgrounds, glow, heavy texture, tiny type, decorative charts, or claims detached from source/evidence. |
| Admin | Severe, non-decorative, permission-aware, log-forward, destructive-action-safe, with clear ownership, audit trail, and rollback context. | Marketing visuals, glass fantasy, violet/gold decoration, playful tone, hidden destructive risk, or ambiguous permissions. |
| Settings | Quiet, structured, reversible, searchable where needed, with visible defaults, account boundaries, permissions, billing, integrations, and data controls. | Decorative settings panels, unclear save state, hidden critical controls, or mixing identity colors with error/success states. |
| Mobile | Mobile-native density: cards over cramped tables, thumb-safe actions, persistent command context, readable type, accessible focus, and reduced motion. | Desktop dashboard squeezed into mobile, tiny tables, hover-only controls, cinematic effects that reduce clarity, or hidden review/approval states. |
| Pitch deck | Dream may open the story, but proof slides must be clean, diagrammatic, readable, and show architecture, product workflows, pipeline status, guardrails, and trust model. | Pure cinematic mythology, repeated flare template, heavy grain behind body copy, or future pipeline sold as current product. |
| Brand board | Atmospheric direction plus precise implementation tokens: separate core tokens from effect tokens and convert mood into colors, spacing, components, and surface rules. | Treating concept art as product UI, overriding canonical hexes, unregistered color drift, or letting inspiration replace specification. |

### Galyarder Ledger

Purpose: turn fragmented operational input into agent-assisted, ledger-backed execution.

Design should emphasize:

- operational clarity,
- transaction/state transitions,
- evidence visibility,
- report generation,
- G-Agent workforce status,
- review-needed states,
- guarded autonomy,
- audit readiness.

Avoid:

- bookkeeping toy aesthetics,
- generic finance dashboard templates,
- decorative crypto visuals,
- making G-Agents look like cute companions.

### Galyarder HQ

Purpose: command and govern autonomous company systems.

Design should emphasize:

- org charts,
- departments,
- reporting lines,
- goal assignment,
- task queues,
- budget hard stops,
- approval gates,
- rollback,
- multi-company portfolio isolation.

HQ should feel like the highest-level command surface.

Avoid:

- calling it a dashboard,
- micromanagement UI,
- single-chat assistant patterns,
- lack of budget/approval visibility.

### Galyarder Framework

Purpose: turn high-level business vision into deterministic implementation through Autonomous Goal Integration.

Design should emphasize:

- blueprints,
- project tickets,
- SOPs,
- skills/templates,
- agent runtime,
- workflows,
- TDD/test status,
- audit output,
- distribution workflows,
- integration with tools such as Claude Code, Gemini CLI, Cursor, and CLI contexts where relevant.

Avoid:

- prompt-pack aesthetics,
- vague AGI claims,
- treating the Framework as only internal if it is public/developer-facing,
- hiding execution proof.

### Galyarder Agent

Purpose: persistent digital identity and continuity across channels.

Design should emphasize:

- memory profile,
- local profile,
- values,
- voice,
- visual identity,
- channel presence,
- scheduled/recurring jobs,
- continuity records,
- multimodal responses.

Agent may feel more human than Ledger/HQ, but must not become a toy chatbot.

Avoid:

- confusing Galyarder Agent with Ledger G-Agents,
- making it a generic assistant,
- implying it replaces the human,
- relying only on chat UI.

### G-Agent Workforce inside Ledger

G-Agents are role-based operational workers, not persistent identity products.

#### G-Agent CFO

- Macro operational and financial oversight.
- Input: omnichannel operational data and integrated ledger data.
- Output: strategic/executive summaries and analysis.
- Guardrail: cannot authorize major capital movement without manual operator approval.

#### G-Agent Sales

- Manages AR, collections, revenue-oriented follow-up.
- Input: sales documents and communication channels.
- Output: financial entries, conversion reports, follow-up drafts.
- Guardrail: cannot finalize deals or permanently change ledger state without review-needed approval.

#### G-Agent Accountant

- Converts messy operational input into clean financial structure.
- Input: documents, receipts, voice, chat text.
- Output: financial state transitions and integrated ledger records.
- Guardrail: ambiguous entries must trigger confirmation/revision.

#### G-Agent Auditor

- Ensures traceability and auditability.
- Input: state transitions, other agent reports, ledger state.
- Output: audit-readiness reports and evidence visibility.
- Guardrail: read-only oversight; can flag anomalies but cannot hide or modify history.

#### Tax Optimizer

- Simulates and plans financial/tax efficiency.
- Input: ledger records and historical operations.
- Output: tax strategy, expense ratios, risk visibility.
- Guardrail: provides proposals only; authoritative filing/execution stays behind command approval.

### Development Pipeline Surfaces

When designing pipeline pages, use restrained pipeline treatment:

- show product as in development,
- do not imply live availability,
- focus on layer, problem, and promise,
- avoid pricing, CTA, or onboarding unless status changes.

---

## 10. Motion

Motion must explain state, not decorate the interface.

Allowed motion:

- Airlock transition,
- loading state,
- agent activity state,
- command submission,
- approval gate,
- report generated,
- error/failure explanation,
- budget hard-stop warning,
- sync complete.

Rules:

- Reduced motion support is required.
- No cyberpunk flicker.
- No fake hacker boot sequence.
- No long cinematic delay.
- No motion that hides system state.

---

## 11. Accessibility

- Maintain readable contrast for all text.
- Do not put small text over heavy texture.
- Semantic color must be supported by labels/icons, not color alone.
- Focus states must be visible.
- Motion must be reducible.
- Product density must remain scannable.
- Reports must print/export cleanly.

---

## 12. Pitch Deck Rules

The pitch deck must not become pure cinematic mythology.

Rules:

- Cinematic slides: max 30–40%.
- Proof slides: clean, diagrammatic, readable.
- Architecture slides: no small text over noisy background.
- Product proof slides are required.
- Every slide must either create belief or show proof.
- No repeated flare template across every slide.
- No heavy grain behind body copy.

Required proof slides:

- product architecture,
- current public products,
- Ledger workflow,
- HQ command workflow,
- Framework execution workflow,
- Agent continuity workflow,
- pipeline with clear status,
- business/use-case proof,
- guardrails and trust model.

---

## 13. Brand Board Rules

The brand board can be atmospheric, but implementation specs must be precise.

Rules:

- Separate core tokens from effect tokens.
- Effect colors are for glow/illustration only.
- Do not let visual inspiration override canonical hex values.
- Do not treat concept art as product UI.
- Convert mood into tokens, spacing, components, and surface rules before implementation.

---

## 14. Do / Don’t

### Do

- Make the future feel inviting.
- Make the product feel trusted.
- Use violet as identity.
- Use gold as threshold.
- Show the machine behind the myth.
- Use semantic colors for meaning.
- Use neutral surfaces for structure.
- Keep the user in command.
- Show evidence, guardrails, and state.

### Don’t

- Make every screen cinematic.
- Make product UI poetic.
- Use crypto visual clichés.
- Use monospace everywhere.
- Use decorative color as information.
- Create hard visual whiplash.
- Hide proof behind atmosphere.
- Make agents feel like toys.
- Present future pipeline as active product.

---

## 15. Implementation Notes for Agents

When generating screens:

- Use **Dream** for marketing/public pages.
- Use **Airlock** for auth/loading/onboarding/post-login transition.
- Use **Machine** for authenticated product surfaces.
- Use Ledger rules for financial execution surfaces.
- Use HQ rules for command/governance surfaces.
- Use Framework rules for developer/implementation surfaces.
- Use Agent rules for continuity/identity surfaces.
- Use pipeline rules for future products.

When uncertain, choose:

```text
trust over spectacle
proof over poetry
semantic clarity over brand decoration
operator command over passive assistant behavior
```

---

## 16. QA Checklist

Before shipping UI, answer:

- Does this preserve Galyarder identity?
- Does this avoid conceptual whiplash?
- Does this use Dream, Airlock, or Machine correctly?
- Does this keep product trust above decoration?
- Does this use semantic colors only for meaning?
- Does this avoid generic AI/Web3/SaaS aesthetics?
- Does this distinguish Galyarder Agent from Ledger G-Agents?
- Does this show product proof, not just mythology?
- Does this avoid overpromising pipeline products?
- Does this make the user feel more capable and in command?
