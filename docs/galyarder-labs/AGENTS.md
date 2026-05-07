# AGENTS.md — Galyarder Labs Agent Instructions

This file is the canonical execution guide for coding agents, design agents, documentation agents, and automation agents working on Galyarder Labs or any Galyarder product.

Before editing UI, product copy, brand copy, navigation, onboarding, reports, admin, billing, product architecture, or agent workflows, read:

1. [`README.md`](./README.md)
2. [`BRAND.md`](./BRAND.md)
3. [`DESIGN.md`](./DESIGN.md)

The project doctrine is:

> **Dream → Airlock → Machine**  
> **Intent becomes infrastructure.**

Do not build against generic SaaS assumptions. Do not invent a different brand.

---

## 1. Project Context

Galyarder Labs is not a generic AI SaaS product. It is an autonomous execution infrastructure brand.

The current public infrastructure suite:

| Product | Role | Status |
|---|---|---|
| Galyarder Ledger | Autonomous Financial Workspace / Ledger Layer | active production / public / P0 |
| Galyarder HQ | Strategic Command Interface / Command Layer | active production / public / P0 |
| Galyarder Framework | Intelligence Layer for Autonomous Goal Integration | active production / public developer-facing / P0 |
| Galyarder Agent | Continuity Layer / persistent digital entity | active / public / P1 |

Development pipeline:

| Product | Role | Status |
|---|---|---|
| Galyarder Vault | security, key management, asset sovereignty, verifiable trust | in progress / future / internal pipeline / P2 |
| Galyarder OS | unifying Human Intent Layer | future / internal pipeline / P2 |
| Galyarder Alpha | market intelligence protocol | future / internal pipeline / P2 |
| Galyarder Quant | systematic trading and DeFi yield automation | future / internal pipeline / P2 |
| Galyarder Wallet | multi-chain risk visibility | future / internal pipeline / P2 |
| Galyarder Mind | decision tracking and pre-mortem analysis | future / internal pipeline / P2 |

The user is not a passive consumer. The user is a serious operator, founder, builder, researcher, creator, technical strategist, 1-Man Army, or small elite team that needs leverage without bureaucracy.

---

## 2. Required Reading Order

Agents must not treat these files as optional context. They are execution gates.

1. Read [`README.md`](./README.md) first to understand the repository, product map, and canonical documentation structure.
2. Read [`BRAND.md`](./BRAND.md) before writing or editing public copy, product copy, brand copy, onboarding copy, navigation labels, reports, product claims, or product architecture.
3. Read [`DESIGN.md`](./DESIGN.md) before changing UI, layouts, colors, typography, motion, components, dashboards, auth, onboarding, reports, admin, billing, settings, or product screens.
4. Read this `AGENTS.md` before executing coding, design, documentation, automation, or agent workflow work.

If these documents conflict, stop and resolve the contradiction before shipping. Do not guess a new brand direction.

---

## 3. Product Hierarchy

```text
Galyarder Labs
├── Galyarder Ledger
│   ├── G-Agent CFO
│   ├── G-Agent Sales
│   ├── G-Agent Accountant
│   ├── G-Agent Auditor
│   └── Tax Optimizer
├── Galyarder HQ
├── Galyarder Framework
├── Galyarder Agent
└── Development Pipeline
    ├── Galyarder Vault
    ├── Galyarder OS
    ├── Galyarder Alpha
    ├── Galyarder Quant
    ├── Galyarder Wallet
    └── Galyarder Mind
```

Naming rules:

- Use **Galyarder Agent** only for the persistent digital entity / continuity layer.
- Use **G-Agent** only for role-based workforce agents inside Galyarder Ledger.
- Do not confuse Galyarder Agent with G-Agent CFO, G-Agent Sales, G-Agent Accountant, G-Agent Auditor, or Tax Optimizer.
- Formal contexts should use the full product name.
- Short names are allowed after context is established: Labs, Ledger, HQ, Framework, Agent, Vault, OS, Alpha, Quant, Wallet, Mind.

---

## 4. Required Brand Rules

Agents must preserve these rules:

- Lead with human intent, continuity, execution, ownership, command, and operator leverage.
- Do not describe the product as an AI wrapper.
- Do not describe Galyarder Agent as a chatbot.
- Do not describe Galyarder HQ as a dashboard.
- Do not describe Galyarder Framework as a prompt pack.
- Do not describe Galyarder Ledger as bookkeeping software, a warung app, or an Excel replacement.
- Do not lead public-facing copy with Web3, crypto, blockchain, tokens, or speculation language.
- Do not use SMB/Enterprise as primary emotional segmentation.
- Use operator-native language: operator, builder, 1-Man Army, agent workforce, command layer, ledger-backed execution, institutional power for the single operator.
- Every major claim must connect to product behavior, workflow visibility, agent capability, auditability, evidence, ledger state, command state, memory state, or measurable outcome.
- Never promise effortless success or fully autonomous execution with no risk.
- Never make the user feel replaced, passive, or inferior.
- Never present development pipeline products as currently live unless their status has been updated in `BRAND.md`.

### We Say / Never Say

| We Say | Never Say |
|---|---|
| autonomous execution infrastructure | AI wrapper |
| operator | SMB user |
| 1-Man Army | small business customer |
| institutional-grade capability | enterprise SaaS solution |
| cryptographic ownership | crypto app |
| ledger-backed execution | bookkeeping chatbot |
| G-Agent workforce | AI assistant toy |
| Strategic Command Interface | dashboard |
| Galyarder Agent | chatbot persona |
| Autonomous Goal Integration | artificial general intelligence claim |
| guarded autonomy | fully autonomous with no risk |
| evidence trail | guaranteed truth |
| development pipeline | available product if not released |

---

## 5. Required Design Rules

Use the correct layer.

| Layer | Surfaces | Required Feeling |
|---|---|---|
| Dream | landing, marketing, social, pitch openers, public brand pages | luminous, editorial, calm, spacious, threshold-like |
| Airlock | auth, loading, onboarding, post-login transition | GS logo, violet identity glow, soft gold threshold, 1–2 second decompression |
| Machine | Ledger, HQ, Framework, Agent, dashboard, Workforce, Reports, Admin, Settings, Billing | operational, monochrome, semantic, dense but readable, trusted |

Rules:

- Never hard-cut from dreamy marketing into cold dashboard without Airlock.
- Violet and gold are brand identity colors, not operational status colors.
- Semantic colors are only for meaning: info, success, warning, error.
- Product UI must feel trusted before it feels beautiful.
- Admin surfaces must be severe and non-decorative.
- Reports must be clean and export-ready.
- Workforce surfaces must show agent state, activity, outputs, and guardrails.
- HQ surfaces must show structure, budgets, approval gates, reporting lines, and command history.
- Framework surfaces must show blueprints, tickets, SOPs, agent runtime, tests, audits, and execution proof.
- Agent surfaces must show memory, identity, channel presence, continuity records, and recurring jobs without becoming generic chat UI.
- Do not use heavy grain behind small text.
- Do not use monospace everywhere.
- Do not overuse glass, glow, gradients, or cinematic texture in product surfaces.

---

## 6. UI Implementation Rules

When implementing UI, preserve the correct experience layer:

- **Dream:** public marketing, landing, social, pitch openers, and public brand pages. Use luminous editorial restraint and proof direction.
- **Airlock:** auth, loading, onboarding, and post-login bridge. Use GS mark or Galyarder lockup, Violet Identity Glow, Soft Gold threshold trace, and 1–2 second decompression with reduced-motion support.
- **Machine:** Ledger, HQ, Framework, Agent, dashboard, workforce, reports, admin, settings, billing, and authenticated product surfaces. Use neutral structure, semantic color, operational hierarchy, evidence visibility, and audit-ready state.

Implementation rules:

- Use canonical tokens from `DESIGN.md`; do not invent colors, fonts, spacing scales, radii, glow treatments, or component variants without updating `DESIGN.md`.
- Use violet and gold only for identity, threshold, auth, splash, and restrained brand moments.
- Use semantic colors only for information state: info, success, warning, error.
- Use neutral surfaces for product structure.
- Product UI must be trusted before beautiful.
- Admin must be severe and non-decorative.
- Reports must be clean, export-ready, and evidence-forward.
- Workforce must show agent state, activity, outputs, review queues, and guardrails.
- Mobile must be mobile-native; do not squeeze desktop tables into small screens.
- Do not use marketing visuals, cinematic texture, or brand-gradient flooding inside product dashboards.

---

## 7. Copywriting Rules

Copy must preserve operator command and proof-backed positioning.

- Lead with human intent, continuity, execution, ownership, command, and operator leverage.
- Use operator-native audience language: operator, builder, founder, researcher, creator, technical strategist, 1-Man Army, small elite team.
- Tie every major claim to product behavior, workflow visibility, agent capability, auditability, evidence, ledger state, command state, memory state, or measurable outcome.
- State future/pipeline products as pipeline only unless `BRAND.md` has been updated.
- Keep product copy concrete and operational; reserve poetic language for Dream surfaces.
- Do not call Galyarder Ledger bookkeeping software, a warung app, or an Excel replacement.
- Do not call Galyarder HQ a dashboard.
- Do not call Galyarder Framework a prompt pack.
- Do not call Galyarder Agent a chatbot.
- Do not lead public copy with Web3, crypto, blockchain, tokens, speculation, generic AI, SMB, Enterprise SaaS, or fully autonomous no-risk promises.
- Do not sterilize controlled product-truth terms. `agentic companies`, `AI-native companies`, `AGI` as Autonomous Goal Integration, `digital entities`, `cryptographic ownership`, `verifiable control`, `blockchain anchoring`, `key policy`, and `guarded autonomy` are allowed when tied to real product behavior, proof, or architecture.
- Avoid contaminated categories as headlines; use precise primitives as proof.

---

## 8. Product-Specific Build Rules

### Galyarder Ledger

Build Ledger as an operational financial workspace.

Must show:

- omnichannel operational input,
- ledger state transitions,
- evidence visibility,
- G-Agent workforce activity,
- review-needed states,
- guarded execution,
- report/audit output.

Do not build it as a bookkeeping app or generic fintech dashboard.

### Galyarder HQ

Build HQ as the Strategic Command Interface.

Must show:

- org charts,
- departments,
- reporting lines,
- goals/tasks assigned down hierarchy,
- budget and token cost tracking,
- hard stops,
- approval gates,
- rollback/version control,
- multi-company portfolio isolation.

Do not reduce HQ to a chat UI or dashboard.

### Galyarder Framework

Build Framework as a public/developer-facing Intelligence Layer.

Must show:

- intent extraction,
- strategic blueprinting,
- autonomous implementation,
- SOPs/skills/templates,
- workflows,
- agent runtime,
- TDD/tests,
- audit output,
- distribution/market workflow,
- integration with developer/AI tools when relevant.

Clarify that AGI means Autonomous Goal Integration.

### Galyarder Agent

Build Agent as the Continuity Layer.

Must show:

- persistent memory,
- local profile files,
- values,
- voice,
- visual identity,
- omnichannel presence,
- scheduled jobs,
- continuity records.

Do not confuse it with role-based Ledger G-Agents.

---

## 9. Ledger G-Agent Workforce Rules

### G-Agent CFO

- Job: macro financial and operational oversight.
- Inputs: omnichannel operational data and ledger data.
- Outputs: executive summaries, strategic analysis.
- Guardrail: cannot authorize major capital movement without manual operator approval.

### G-Agent Sales

- Job: AR, collections, revenue-oriented follow-up.
- Inputs: sales documents and communication channels.
- Outputs: financial entries, conversion reports, follow-up drafts.
- Guardrail: cannot finalize deals or permanently change ledger state without review-needed approval.

### G-Agent Accountant

- Job: turn messy operational input into clean financial structure.
- Inputs: documents, receipts, voice, chat text.
- Outputs: financial state transitions and integrated ledger records.
- Guardrail: ambiguous entries must trigger confirmation/revision.

### G-Agent Auditor

- Job: traceability, auditability, anomaly detection.
- Inputs: state transitions, agent reports, ledger state.
- Outputs: audit-readiness reports and evidence visibility.
- Guardrail: read-only oversight; can flag anomalies but cannot hide or rewrite history.

### Tax Optimizer

- Job: simulate and plan financial/tax efficiency.
- Inputs: ledger records and historical operations.
- Outputs: tax strategy proposals, expense ratio analysis, risk visibility.
- Guardrail: proposes only; authoritative filing/execution stays behind command approval.

---

## 10. Public Exposure Rules

Public website may show now:

- Galyarder Ledger
- Galyarder HQ
- Galyarder Framework
- Galyarder Agent
- The Infrastructure Suite for 1-Man Army autonomous execution

Public website may mention as development pipeline only:

- Galyarder Vault
- Galyarder OS
- Galyarder Alpha
- Galyarder Quant
- Galyarder Wallet
- Galyarder Mind

Internal only:

- Galyarder Alpha Room
- founder portfolio / legacy archives

Technical-only, not high-level marketing:

- MCP details,
- Context7 / SequentialThinking specifics,
- AST details,
- backend architecture internals,
- Python agent internals.

---

## 11. Dev Environment Tips

- Use `pnpm dlx turbo run where <project_name>` to jump to a package instead of scanning with `ls`.
- Run `pnpm install --filter <project_name>` to add the package to your workspace so Vite, ESLint, and TypeScript can see it.
- Use `pnpm create vite@latest <project_name> -- --template react-ts` to spin up a new React + Vite package with TypeScript checks ready.
- Check the `name` field inside each package's `package.json` to confirm the right package name; skip the top-level one when targeting a package.
- Do not introduce UI libraries or brand tokens that conflict with `DESIGN.md`.
- Before adding new colors, typography, spacing, radii, or component variants, check `DESIGN.md`.

---

## 12. Testing Instructions

- Find the CI plan in `.github/workflows`.
- Run `pnpm turbo run test --filter <project_name>` to run every check defined for that package.
- From the package root you can usually call `pnpm test`.
- To focus on one step, add the Vitest pattern: `pnpm vitest run -t "<test name>"`.
- Fix test, lint, and type errors until the whole suite is green.
- After moving files or changing imports, run `pnpm lint --filter <project_name>`.
- Add or update tests for changed behavior.
- For UI/copy changes, verify the screen complies with `BRAND.md` and `DESIGN.md`.

---

## 13. PR Instructions

- Title format: `[<project_name>] <Title>`.
- Always run `pnpm lint` and `pnpm test` before committing.
- Include a short compliance note for UI/copy/product changes:
  - Brand layer used: Dream / Airlock / Machine.
  - Product affected: Ledger / HQ / Framework / Agent / Pipeline.
  - Proof preserved: evidence, ledger state, command state, memory state, audit trail, or test output.
- Do not merge UI changes that violate Dream → Airlock → Machine.
- Do not merge public copy that sells future pipeline as current product.
- Do not merge product changes that confuse Galyarder Agent with Ledger G-Agents.

---

## 14. Rejection Gates

These are hard gates, not cosmetic checklist items. If one P0 gate fails, the work is not accepted.

Reject the work if:

- UI, copy, product architecture, navigation, onboarding, reports, admin, billing, or agent workflow violates `BRAND.md`.
- UI, layout, color, typography, motion, component behavior, report design, admin design, or product surface violates `DESIGN.md`.
- The agent invents a product name, product status, capability, proof claim, pricing claim, launch claim, or roadmap claim not supported by canonical docs.
- Public copy leads with crypto, Web3, blockchain, tokens, speculation, generic AI wrapper language, chatbot language, SMB language, or Enterprise SaaS positioning.
- Controlled product-truth terms are removed merely to sound safer, causing the brand to collapse into generic corporate SaaS.
- Galyarder HQ is reduced to a dashboard or chat UI.
- Galyarder Ledger is reduced to bookkeeping software, a warung app, or an Excel replacement.
- Galyarder Framework is reduced to a prompt pack or vague artificial-general-intelligence claim.
- Galyarder Agent is reduced to a chatbot or confused with Ledger G-Agents.
- A dashboard, admin screen, report, settings screen, or product workspace uses Dream/marketing visuals as its core surface language.
- Violet/gold are used as warning, error, KPI, or generic operational status colors.
- Future pipeline products are presented as launched/current products.
- Major claims lack proof direction through behavior, workflow, ledger state, command state, memory state, evidence, audit trail, tests, or measurable output.
- Required lint, test, type, build, or package-specific verification fails.

---

## 15. Agent Final Checklist

Before completing a task, verify:

- Did I read the relevant sections of `BRAND.md` and `DESIGN.md`?
- Did I use the correct product terminology?
- Did I avoid banned language?
- Did I avoid crypto/Web3 as the public headline unless working in technical/pipeline context?
- Did I preserve user command rather than replacing the user?
- Did I use semantic colors only for meaning?
- Did I avoid overusing glass, glow, grain, monospace, and cinematic effects?
- Did I include proof direction for major claims?
- Did I avoid overpromising development pipeline products?
- Did I distinguish Galyarder Agent from G-Agents?

<!-- This section is maintained by the coding agent via lore (https://github.com/BYK/loreai) -->
## Long-term Knowledge

### Architecture

<!-- lore:019dfc8a-34af-76c0-b5e9-8404ff99e9ec -->
* **Galyarder product hierarchy and naming**: Do not universalize copy rules across repos. Labs owns active Ledger/HQ/Framework/Agent; future/internal Vault/OS/Alpha/Quant/Wallet/Mind. Targets: Ledger=financial ops + G-Agent workforce/runtime; Framework=AGI as Autonomous Goal Integration + 1-Man Army; HQ=agentic-company control plane with org/budget/approval/heartbeat; Agent=persistent digital entity; Labs=public front door. Vault=Ownership/Security Layer, not Web3 headline. 24/7/never-sleeps wording is allowed only with real runtime/hosting/cost/review gates.

### Decision

<!-- lore:019dfc8a-34a2-78ff-8911-642c58acde7b -->
* **Final docs are P0 hard gates**: Canonical Labs docs are P0 gates; child repo docs stay project-native. Remove active deprecated framing; changelog/release notes may keep it only as clearly historical. Prefer one source of truth: delete redundant Labs mirror files after updating references to BRAND.md/DESIGN.md/canonical docs; only keep a pointer/mirror when link breakage is unavoidable. Final docs may be non-git, so repo commits/pushes are separate.

### Gotcha

<!-- lore:019dfc8a-34d9-73e3-a3dc-1960fcc8c751 -->
* **AGENTS.md must reject brand-breaking work**: AGENTS.md is canonical; AGENT.md is only a legacy alias/redirect. It should define README→BRAND→DESIGN order, UI/copy/product rules, pnpm/turbo checks, PR instructions, and reject invented claims, failed checks, internal doctrine leaks, dashboard-marketing visuals, launched pipeline products, Agent/G-Agent confusion, Humans 3.0, deterministic certainty, self-evolving/autonomous-brain claims, and hype-label AI/Web3/crypto/sovereignty framing. Do not ban product-true primitives or operational truths: cryptography/blockchain anchoring and 24/7/never-sleeps language are allowed when bounded by runtime, cost, approval, and review gates.

<!-- lore:019dfc8a-34ce-72ea-813e-7b8598915782 -->
* **BRAND.md canonical structure requirements**: BRAND.md acceptance requires front matter: name Galyarder Labs, tagline Empowering Human Intent., version 1, language en, type master, architecture branded-house. It must include 16 Strategy/Voice/Visual sections, product tree, public exposure rules, We Say/Never Say, claim guardrails, Future Pipeline wording, and Controlled Terms. Ban category-led Web3/Crypto/AI hype as public positioning, but keep product-true primitives: cryptography, signatures, key policy, blockchain anchoring, multi-sig, non-custodial/verifiable control, and guarded autonomy.

<!-- lore:019dfc8a-34d3-7fe1-beb3-bfa68013ef37 -->
* **DESIGN.md machine-readable surface gates**: DESIGN.md must have valid YAML tokens for colors, typography, spacing, radius, and motion, plus rationale, accessibility, motion, and QA. It also needs explicit surface rules for Landing, Auth, Airlock, Dashboard, Ledger, HQ, Framework, Agent, Workforce, Reports, Admin, Settings, Mobile, Pitch deck, and Brand board.

### Pattern

<!-- lore:019dfc8a-34c5-76b9-bf3c-da57beedb4d1 -->
* **Color and typography separation**: Design law: brand colors are identity, semantic colors information, surface colors structure—do not mix. Violet/gold are for logo, brand, auth, threshold moments, not KPIs/warnings/errors; product UI uses sans, display serif stays marketing, mono only for hashes, IDs, logs, code, and ledger refs.

<!-- lore:019dfc8a-34bd-77d2-932e-d18241a8f642 -->
* **Dream-Airlock-Machine UI boundaries**: Dream/Airlock/Machine is internal operating/design doctrine, not public copy. Keep the terms in BRAND.md, DESIGN.md, AGENTS.md, and internal specs; public surfaces should follow the magnetic-but-controlled tone in \[\[019dfc8a-34b4-7478-aff7-3af23bc8be7e]] without naming the doctrine. Dream = marketing threshold, Airlock = auth/onboarding decompression, Machine = authenticated operational console.

### Preference

<!-- lore:019dfc8a-34b4-7478-aff7-3af23bc8be7e -->
* **Operator-native proof-backed copy**: Front-door/org README copy should be decisive, high-agency, and proof-backed, not corporate-safe. “Negative” means scammy/hype category framing (Web3/crypto/AI/sovereignty as market labels), not technical primitives: cryptography, signatures, keys, blockchain anchoring, multi-sig, and non-custodial control are allowed when product-true. Strong claims like 24/7 or never-sleeps are allowed only when tied to real runtime, cost, approval, review, and failure-mode limits.
<!-- End lore-managed section -->
