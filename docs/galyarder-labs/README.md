# Galyarder Labs

**Empowering Human Intent.**

Galyarder Labs builds autonomous execution infrastructure that turns human intent, memory, decisions, capital, ownership, and operational work into persistent systems.

The operating doctrine is:

> **Dream → Airlock → Machine**  
> **Intent becomes infrastructure.**

Galyarder Labs is the luminous invitation. The product suite is the machinery behind it.

---

## What This Repository Is

This repository contains the canonical brand, design, product, and agent execution context for the Galyarder ecosystem.

It is not a generic AI SaaS project, a crypto hype brand, a chatbot interface, or a standard productivity dashboard. It is a branded-house system for building autonomous execution infrastructure around high-agency operators, solo founders, builders, technical strategists, and small elite teams.

---

## Canonical Documentation Map

| File | Who Reads It | What It Defines |
|---|---|---|
| [`README.md`](./README.md) | humans | what the project is and how to orient quickly |
| [`BRAND.md`](./BRAND.md) | humans, writers, founders, agents | brand strategy, product architecture, positioning, voice, promise, guardrails |
| [`DESIGN.md`](./DESIGN.md) | designers, design agents, frontend agents | visual system, machine-readable tokens, UI layers, product surface rules |
| [`AGENTS.md`](./AGENTS.md) | coding agents, design agents, documentation agents | how to build without breaking brand, design, product hierarchy, or execution intent |
| [`AGENT.md`](./AGENT.md) | legacy alias | same content as `AGENTS.md` for tools expecting singular naming |

These files are canonical. Older umbrella, revised, exploratory, or duplicate brand/design files are archived source material only.

---

## Product Architecture

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

---

## Core Products

### Galyarder Ledger

**Layer:** Ledger Layer  
**Status:** active production / public / P0  
**Definition:** an Autonomous Financial Workspace for agent-assisted, audit-ready financial execution.

Ledger turns fragmented operational work into structured state transitions, ledger-backed records, reporting, and evidence visibility.

### Galyarder HQ

**Layer:** Command Layer  
**Status:** active production / public / P0  
**Definition:** a Strategic Command Interface for building structure, setting goals, assigning work, and orchestrating autonomous company systems from a high-fidelity control plane.

HQ prevents agent babysitting by giving operators org charts, reporting lines, budgets, approval gates, rollback controls, and multi-company command.

### Galyarder Framework

**Layer:** Intelligence Layer  
**Status:** active production / public and developer-facing / P0  
**Definition:** an elite engineering protocol for the 1-Man Army, implementing **Autonomous Goal Integration** to convert high-level business vision into deterministic execution.

In this repository, **AGI means Autonomous Goal Integration**, not a claim of artificial general intelligence.

### Galyarder Agent

**Layer:** Continuity Layer  
**Status:** active / public / P1  
**Definition:** a persistent digital entity with recursive memory, values, voice, local profile, visual identity, and cross-channel presence.

Galyarder Agent is not the same as a Ledger G-Agent. Galyarder Agent is a persistent identity layer. Ledger G-Agents are role-based operational workforce agents inside Ledger.

---

## Development Pipeline

These products may be mentioned as the **Development Pipeline** for ecosystem visibility, but they must not be overpromised as fully available products unless their status changes.

| Product | Layer | Promise | Status |
|---|---|---|---|
| Galyarder Vault | Ownership / Security Layer | sovereignty, key management, asset security, verifiable trust | in progress / future / internal pipeline / P2 |
| Galyarder OS | Human Intent Layer | the unifying operating layer where human intent becomes persistent systems | future / internal pipeline / P2 |
| Galyarder Alpha | Intelligence / Research Layer | high-fidelity market signal processing | future / internal pipeline / P2; Alpha Room restricted |
| Galyarder Quant | Financial Execution Layer | systematic trading and DeFi yield automation | future / internal pipeline / P2 |
| Galyarder Wallet | Asset Interface Layer | multi-chain analysis with real-time risk modeling | future / internal pipeline / P2 |
| Galyarder Mind | Decision / Memory Layer | systematic decision tracking and pre-mortem analysis | future / internal pipeline / P2 |

---

## Core Experience Model

### 1. Dream

Public-facing brand surfaces: landing pages, social covers, pitch openers, banners, brand pages.

Feeling: calm, luminous, human, editorial, spacious, threshold-like.

### 2. Airlock

Transition surfaces: auth, loading, onboarding, post-login bridge.

Feeling: identity continuity before operational density.

Required motif: GS mark, Violet Identity Glow, Soft Gold threshold trace, 1–2 second decompression.

### 3. Machine

Authenticated product surfaces: Ledger, HQ, Framework, Agent, Dashboard, Workforce, Reports, Admin, Settings.

Feeling: institutional command machine, monochrome, semantic, dense but readable, audit-ready.

---

## Public Exposure Rules

Public website may show:

- Galyarder Ledger
- Galyarder HQ
- Galyarder Framework
- Galyarder Agent
- The Infrastructure Suite for 1-Man Army autonomous execution

Public website may mention only as future pipeline:

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

- MCP implementation details
- Context7 / SequentialThinking protocol specifics
- AST architecture
- backend code structure
- Python agent internals

---

## Brand Rules

- Lead with human intent, continuity, execution, ownership, and operator leverage.
- Do not call the product an AI wrapper, chatbot, bookkeeping app, Excel replacement, warung app, generic SaaS dashboard, or crypto-hype app.
- Do not lead public-facing copy with Web3, crypto, blockchain, tokens, or speculation language.
- Use operator-native language: operator, builder, 1-Man Army, agent workforce, command layer, ledger-backed execution, institutional power for the single operator.
- Every major claim must connect to product behavior, workflow visibility, agent capability, auditability, evidence, ledger state, or measurable outcome.

---

## Design Rules

- Use the correct layer: Dream, Airlock, or Machine.
- Brand colors are identity.
- Semantic colors are information.
- Surface colors are structure.
- Product UI must feel trusted before it feels beautiful.
- Admin surfaces must be severe.
- Reports must be clean and export-ready.
- Do not turn product UI into a glassy AI dashboard, a crypto spectacle, a red-alert dystopia, or a monospace military wall.

---

## Development

This documentation package is stack-aware but not stack-dependent. When used inside a monorepo, follow the commands in `AGENTS.md`.

Recommended default commands when available:

```bash
pnpm install
pnpm lint
pnpm test
```

For Turbo workspaces:

```bash
pnpm dlx turbo run where <project_name>
pnpm turbo run test --filter <project_name>
pnpm lint --filter <project_name>
```

---

## Contributing

Before changing product UI, product copy, onboarding, marketing pages, agent workflows, reports, admin surfaces, billing, navigation, or documentation:

1. Read `BRAND.md`.
2. Read `DESIGN.md`.
3. Read `AGENTS.md`.
4. Confirm the work preserves **Dream → Airlock → Machine**.
5. Confirm the work does not overpromise pipeline products.
6. Confirm every major product claim has proof direction.

---

## License

Use the license defined by the active repository. If no license has been selected, do not assume open-source rights beyond the product-specific repositories already designated as public/open-source.
