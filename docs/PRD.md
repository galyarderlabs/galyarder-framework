# Forge Anything - Product Requirements

**Status**: Current
**Version**: 3.0.2
**Scope**: Forge Anything as a whole system for AI agents, for work and for life.

## What it is

Forge Anything is one system that gives an AI agent the rules and the workflow to do work the right way, so the work is planned, built, checked against evidence, and shipped. The loop is Goal to Ship and it ends at distribution.

The system has four parts that fit together:

- **Skills**: the rules the agents follow, kept as a curated essential set.
- **Agents**: the agents that do the work, with coordinators and department leads.
- **Commands**: shortcuts for common workflows.
- **The `forge` CLI and the MCP server**: the CLI scaffolds a project and serves the MCP server, which is how a chatbot or an agent gets the tools plus the workflow.

Everything installs through the harness plugin, with no manual setup. The supported harnesses are Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes. See `docs/INTEGRATION.md`.

## Problem

Most AI-agent setups stop at chat or code generation. An agent can help with a task, but the work around it stays loose. There is no durable scope for what was asked, no plan before the work starts, no review gate before a result is called done, and no audit trail after the fact. A person running several agents ends up as the only integration point: they re-explain context, judge quality by feel, and lose the reasoning behind decisions once the session ends.

The missing piece is not another coding agent or a prompt pack. It is the operating layer around the work: a way to receive intent, make a plan, execute through tools, verify the result, and hand control back with evidence. Forge Anything packages that layer so the same workflow applies whether the work is engineering, growth, finance, legal, security, or documentation, and whether it is work or life.

## Who it is for

- **Solo founders and small technical teams** running AI agents across more than one function, who need the work to be structured and reviewable.
- **Operators already using an agentic coding tool** (Claude Code, Cursor, Codex, OpenCode, Antigravity, OpenClaw, Hermes, or a similar harness) who want reusable operating rules instead of one-off prompts.
- **Maintainers and contributors** who add skills, agents, and commands and need a clear contract for what a good addition looks like.

## Goals

- Give every piece of work a goal, a plan, and a verification contract instead of a direct "just do the task" instruction.
- Keep the operating logic host-agnostic, so the same agents, skills, and commands work across the supported harnesses from one canonical source.
- Make completion claims evidence-backed: tests, diffs, logs, citations, or reports, not confidence.
- Leave durable artifacts behind, so knowledge and decisions survive the session.
- Keep human command central: agents expand what the operator can do without removing judgment or approval.
- Keep the system inspectable and local: a set of files a user can read, copy, and modify.
- End every loop at distribution: shipped work, not just finished work.

## Non-goals

- Not a kanban board, project tracker, or general PM tool.
- Not another coding agent; coding is one surface among many.
- Not a hosted or managed service; the system runs locally.
- Not a model provider, training pipeline, or fine-tuning system.
- Not a way to remove human approval from public, financial, irreversible, or production-sensitive actions.

## Requirements

### Workflow

- **R1 - Goal to Ship loop.** A piece of work should follow goal, plan, build, verify, ship, ending in distribution. `[implemented]` - described in `README.md`, `AGENTS.md`, and `WORKFLOW.md`.
- **R2 - Operating modes.** BUILD, INCIDENT, and EXPERIMENT should each have defined rules and evidence expectations. `[implemented]` - `WORKFLOW.md`.
- **R3 - Verification ladder.** Cheaper proof (logic, interface, system) should be used before human review gates, and completion claims should cite evidence. `[implemented]` - `WORKFLOW.md`.
- **R4 - Traceability of work.** Work should map to a scoped issue, brief, plan, or decision. `[implemented]` - stated as a foundation protocol in `WORKFLOW.md`.

### Skills, agents, and commands

- **R5 - Reusable skills with a stable contract.** Skills should have a discoverable entry point and manifest entry. `[implemented]` - `skills/*/SKILL.md` and the skills manifest.
- **R6 - Skill quality review.** New or changed skills should be reviewable against a quality bar before merge. `[partial]` - `scripts/review-new-skills.sh` exists but is not wired into CI.
- **R7 - Slash commands for common workflows.** Common workflows should have commands (`/tdd`, `/review`, `/release`, and others). `[implemented]` - `commands/`.
- **R8 - Specialty agents with clear roles.** Specialist agents should be documented with role and scope. `[implemented]` - `agents/`.
- **R9 - Curation to essential only.** The scaffold ships a curated essential skill set; the full repo is long-term curation work to bring down to essential only. `[in progress]` - see `AGENTS.md` and `ROADMAP.md`.

### Installation and distribution

- **R10 - Plugin-only install.** Users install through their harness plugin manager, with no manual setup and no scripts. `[implemented]` - `docs/INTEGRATION.md`.
- **R11 - Skills-only install.** Users who only want the skills should be able to install them without a harness plugin. `[implemented]` - `npx skills add galyarderlabs/forge-anything`.
- **R12 - Prebuilt CLI install.** Users should be able to install the prebuilt `forge` CLI binary without a Rust toolchain. `[implemented]` - `curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh`, or `cargo install --path crates/forge` from source.
- **R13 - Per-project scaffold.** A user should be able to scaffold an operating structure into a project. `[implemented]` - `forge scaffold` (Rust, `crates/forge-scaffold`).
- **R14 - MCP distribution.** The MCP server should expose the skills, agents, commands, and scaffold over stdio, local only, no network. `[implemented]` - `forge mcp` (`list_skills`, `read_skill`, `read_agent`, `read_command`, `scaffold`).
- **R15 - A single version authority.** The package metadata, the changelog, git tags, and GitHub releases should agree on one version. `[implemented]` - version 3.0.2 across `package.json`, `CHANGELOG.md`, and the release tags.

### Verification and release

- **R16 - Automated integrity check.** There should be a repeatable check for runtime integrity and manifest parity. `[implemented]` - `scripts/smoke.sh` (8 checks) and `forge smoke`.
- **R17 - Continuous integration on pull requests.** The integrity check and the Rust tests should run on every PR. `[implemented]` - `.github/workflows/smoke-test.yml`, `rust.yml`, and `repo-hygiene.yml`.
- **R18 - Cross-platform paths.** Tracked filenames should be valid on Windows. `[implemented]` - `scripts/check-windows-paths.py`, enforced by the repo-hygiene workflow.

### Contribution and governance

- **R19 - Contribution guidance.** There should be a documented path for adding a skill, agent, or command and for what proof a PR needs. `[implemented]` - `CONTRIBUTING.md`.
- **R20 - A published roadmap and PRD.** The project should state where it is going and why, in the repo. `[implemented]` - this document and `ROADMAP.md`.
- **R21 - Consistent public terminology.** Metadata and manifest copy should follow the same terminology rules as the rest of the repository. `[implemented]` - the 3.0.x rebrand aligned the manifests, the changelog, and the docs on the current direction.

### Company packages

- **R22 - Company import.** A user should be able to import an agent-company package into a project, copying it self-contained into `company/<slug>/` with validation of the package format before copying. `[implemented]` - `forge company import` (Rust, `crates/forge`), see `docs/company-import.md`.

## Success signals

- A new user can install the system and scaffold a project by following the README without needing to ask how.
- A piece of work produces a reviewable artifact with evidence, not just a chat reply.
- The version shown by the package, the changelog, and the latest release agree.
- A pull request that breaks the canonical runtime or manifest parity fails CI before review.
- A contributor can add a skill by reading one guide and getting it merged.
- The same operating logic works across the supported harnesses without hand-maintaining parallel copies.
- The loop ends at distribution: shipped work, not work that only looks done.

## Open questions

- Should the audit-grade smoke test stay the required CI gate, or should a lighter check run on PRs with the full audit on release?
- How should the automated PR bots be triaged so useful changes land and noise does not pile up?
- How far beyond coding should the first worked end-to-end example go, and in which department?
- How does the MCP grow toward the full coding-agent tool set without losing the local-only, no-network boundary?
