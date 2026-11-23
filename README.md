<p align="center">
  <img src="docs/assets/social-preview.png" width="600" alt="Galyarder Framework">
</p>

<p align="center">
  Essential skills for the full lifecycle of an AI agent, in one place — from goal to shipped.
</p>

<p align="center">
  <a href="https://www.npmjs.com/package/galyarder-framework"><img alt="npm version" src="https://img.shields.io/npm/v/galyarder-framework?style=for-the-badge&logo=npm&logoColor=white&color=8A00FF"></a>
  <a href="https://github.com/galyarderlabs/galyarder-framework/actions/workflows/deploy-docs.yml"><img alt="docs deployment" src="https://img.shields.io/github/actions/workflow/status/galyarderlabs/galyarder-framework/deploy-docs.yml?branch=main&label=docs&style=for-the-badge&logo=githubactions&logoColor=white&color=6F7DFF"></a>
  <a href="https://github.com/galyarderlabs/galyarder-framework/blob/main/LICENSE"><img alt="license" src="https://img.shields.io/github/license/galyarderlabs/galyarder-framework?style=for-the-badge&color=F1C77A"></a>
</p>

<p align="center">
  <img alt="agentic company framework" src="https://img.shields.io/badge/agent%20skills-framework-8A00FF?style=flat-square">
  <img alt="human directed" src="https://img.shields.io/badge/human--directed-execution-F1C77A?style=flat-square">
</p>

---

## What it is

Most AI-agent setups stop at generating code. The agent writes something, but nobody checks the scope, nobody routes the work, nobody verifies the result, and nothing survives the session.

Galyarder Framework is the operating layer that fixes that. It gives the agent rules and a workflow: take the goal, route it to the right specialist, make a plan, do the work, check the result, and ship it. That is the whole job.

It is not a prompt pack, a kanban board, or another coding agent. It is how operator intent becomes work a company can trust.

---

## How it works

Every mission follows the same five steps, whatever the domain:

1. **Goal** — the operator describes what they want in plain language.
2. **Route** — the framework sends it to the right department, agent, and skill.
3. **Plan** — the agent turns the goal into a scoped plan with steps and risks.
4. **Do** — specialists execute through tools, commands, and code.
5. **Check** — tests, reviews, and evidence gates run before anything is called done. Then the result is shipped and written down: a report, diff, doc, decision log, or release.

---

## What you get

A multi-domain kit in one repository:

- **Specialized agents** across executive, engineering, growth, product, security, infrastructure, legal-finance, and knowledge work.
- **Department routing** so tasks move to the right specialist instead of staying in a generic assistant loop.
- **Skills and SOPs** for TDD, code review, SEO, CRO, FinOps, security review, documentation, release management, and more.
- **Slash commands** for common workflows such as `/tdd`, `/review`, `/marketing`, `/seo`, `/legal`, `/finops`, `/incident`, `/release`, and `/docs`.
- **Galyarder Neural Link** for repository mapping, dependency awareness, and knowledge-graph-oriented project context.
- **Design specifications** for consistent UI and product surfaces when agents produce frontend or brand-facing work.
- **Cross-tool compatibility** for Galyarder Agent, Claude Code, Gemini CLI, OpenClaw, Hermes Agent, Cursor, Windsurf, KiloCode, Augment, Antigravity, Codex-style installs, and OpenCode-style installs.

---

## Rules

- **Human first** — agents expand what the operator can do; they do not replace judgment or approval.
- **Look before you change** — inspect the repo, docs, and constraints before touching anything.
- **Smallest useful change** — solve the stated goal, nothing speculative.
- **Proof before done** — tests, diffs, logs, or reports back every completion claim.
- **Ship it** — a mission is not done until the result is reviewed, shipped, published, or used. Distribution is the end of the loop.
- **Leave something behind** — useful work ends as a doc, skill, command, test, or decision record.

---

## The protocol

Galyarder Framework does not ask the agent to "just do the task." It gives the task a route, a plan, and a verification contract.

| Phase | Category | Action | Typical tool | Outcome |
| :--- | :--- | :--- | :--- | :--- |
| **I** | **Traceability** | Align with roadmap or create a scoped issue | Linear / GitHub / local docs | Work has a named target. |
| **II** | **Mapping** | Inspect repo, dependencies, and prior knowledge | Neural Link / search tools | Agent knows the system before changing it. |
| **III** | **Planning** | Break the goal into steps and risks | Planning skill / sequential reasoning | Execution path is reviewable. |
| **IV** | **Grounding** | Fetch source docs and current references | Context7 / web / file tools | Claims and API usage are source-aligned. |
| **V** | **Execution** | Make the change or produce the artifact | CLI / editor / subagent / workflow tool | Work is created with minimal unnecessary surface area. |
| **VI** | **Verification** | Run tests, reviews, scans, or evidence checks | Test/build/security/docs tools | Completion is backed by output, not confidence. |
| **VII** | **Persistence** | Save the result where future work can use it | Docs / Obsidian / changelog / issue comment | Knowledge and decisions survive the session. |

---

## Installation

### Step 1: Global CLI installation

Bootstrap the framework and link the core commands to your system's PATH.

#### Option A: NPM (recommended)

Install directly from the global registry. This links the `galyarder` command and companion utilities.

```bash
npm install -g galyarder-framework
```

#### Option B: Skills.sh

Pull the full framework or a specific department bundle into an agent environment.

```bash
# Pull everything
npx skills add galyarderlabs/galyarder-framework --skill full

# Or pull by department, such as engineering, growth, security, product, or finance
npx skills add galyarderlabs/galyarder-framework --skill engineering
```

#### Option C: Git clone

Use the source directly when you want to inspect, modify, or contribute to the framework.

```bash
# 1. Clone the repository
git clone https://github.com/galyarderlabs/galyarder-framework.git ~/galyarder-framework

# 2. Link commands globally
cd ~/galyarder-framework
./scripts/setup-cli.sh
```

### Step 2: Initialize and deploy per project

Navigate to the project where you want to install the operating structure.

```bash
# 1. Initialize the project operating structure
galyarder scaffold

# 2. Deploy agents, rules, skills, and commands to your target tool
# Available: cursor, windsurf, kilocode, augment, openclaw, hermes, antigravity, galyarder-agent
galyarder deploy --tool <name>
```

---

## Managed and local options

### A. Official marketplaces

Recommended when your coding environment supports plugin marketplaces or managed extensions.

#### Claude Code / Copilot CLI

```bash
# 1. Add the Galyarder Marketplace
/plugin marketplace add galyarderlabs/galyarder-framework

# 2. Install the full bundle
/plugin install galyarder-framework@galyarderlabs-marketplace

# Or install departments selectively
/plugin install executive-dept@galyarderlabs-marketplace
/plugin install engineering-dept@galyarderlabs-marketplace
# ...growth, security, product, infrastructure, legal-finance, knowledge
```

#### Gemini CLI

```bash
# Install
gemini extensions install https://github.com/galyarderlabs/galyarder-framework

# Update
gemini extensions update galyarder-framework

# Uninstall
gemini extensions uninstall galyarder-framework
```

The framework uses a universal plugin structure. Assets are organized into `agents/`, `skills/`, `commands/`, `personas/`, and `integrations/` so the same operating logic can be adapted across Google, Anthropic, Microsoft, OpenAI, and local-agent environments.

### B. Directives for Codex and OpenCode

For tools that can fetch instructions directly, point them at the install guides.

#### OpenAI Codex

```text
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/main/.codex/INSTALL.md
```

#### OpenCode

```text
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/main/.opencode/INSTALL.md
```

---

## Departments

The framework organizes work into domain departments. These are routing surfaces for agents, skills, commands, and reports; `galyarder scaffold` may create `docs/departments/*` in a project as the output surface.

- **Executive** — strategy, prioritization, company direction, founder context, and decision logs.
- **Engineering** — architecture, implementation, TDD, code review, refactoring, and release readiness.
- **Product** — requirements, roadmaps, PRDs, experiments, product strategy, and user needs.
- **Growth** — marketing, content, SEO, CRO, analytics, campaigns, retention, and revenue workflows.
- **Sales** — technical sales, lead scoring, outreach assets, demos, qualification, and customer-facing material.
- **Finance / Legal** — financial analysis, pricing, contracts, compliance, privacy, and operating-risk review.
- **Security** — security review, threat modeling, secure automation, incident handling, and red-team planning.
- **Infrastructure** — deployment, reliability, observability, FinOps, CI/CD, and operational runbooks.
- **Knowledge** — documentation, Obsidian-style knowledge work, memory, diagrams, and durable reports.

---

## What we are building next

The next phase is to make the framework more concrete as an agentic-company operating layer:

- cleaner department bundles for engineering, product, growth, sales, finance, legal, security, docs, and operations;
- stronger examples that show a goal becoming a plan, issue, implementation, test, audit, and release artifact;
- safer Codex/OpenCode-style install and review workflows;
- fewer, sharper skills — cut the 149 down to the ones that earn their keep.

---

## Star History

<p align="center">
  <a href="https://star-history.com/#galyarderlabs/galyarder-framework&Date">
    <img src="https://api.star-history.com/svg?repos=galyarderlabs/galyarder-framework&type=Date" alt="Star History Chart">
  </a>
</p>
