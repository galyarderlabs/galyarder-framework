# Forge Anything — Product Requirements

**Status**: Draft
**Scope**: The Intelligence Layer — the agents, skills, commands, review gates, and operating protocols that turn operator intent into routed, verified, and documented work across departments.

## Problem

Most AI-agent setups stop at chat or code generation. An agent can help with a task, but the work around it stays loose. There is no durable scope for what was asked, no routing to the right specialist, no review gate before a result is called done, and no audit trail after the fact. A solo founder running several agents ends up as the only integration point: they re-explain context, judge quality by feel, and lose the reasoning behind decisions once the session ends.

The missing piece is not another coding agent or a prompt pack. It is the operating layer around the work: a way to receive intent, route it to a domain, produce a plan, execute through tools, verify the result, and hand control back with evidence. Forge Anything packages that layer so the same protocol applies whether the work is engineering, growth, finance, legal, security, or documentation.

## Who it is for

- **Solo founders and small technical teams** running multiple AI agents across more than one function, who need the work to be structured and reviewable.
- **Operators already using an agentic coding tool** (Claude Code, Cursor, Gemini CLI, Codex, OpenCode, Windsurf, KiloCode, Augment, Antigravity, OpenClaw, Hermes, or Forge Agent) who want reusable operating protocols instead of one-off prompts.
- **Maintainers and contributors** who add skills, agents, and commands and need a clear contract for what a good addition looks like.
- **Teams building on the wider Forge Anything stack** who want the intelligence layer to connect cleanly to the continuity, command, and financial layers.

## Goals

- Give every mission a route, a plan, and a verification contract instead of a direct "just do the task" instruction.
- Keep the operating logic host-agnostic, so the same agents, skills, and commands work across the supported tools from one canonical source.
- Make completion claims evidence-backed: tests, diffs, logs, citations, or reports, not confidence.
- Leave durable artifacts behind, so knowledge and decisions survive the session.
- Keep human command central: agents expand what the operator can do without removing judgment or approval.
- Keep the framework inspectable and local: a set of files a user can read, copy, and modify.

## Non-goals

- Not a kanban board, project tracker, or general PM tool.
- Not another coding agent; coding is one surface among many.
- Not a hosted or managed service; the framework runs locally.
- Not a model provider, training pipeline, or fine-tuning system.
- Not a way to remove human approval from public, financial, irreversible, or production-sensitive actions.

## Requirements

### Routing and structure

- **R1 — Department routing.** Work should route to the correct domain (executive, engineering, product, growth, sales, finance/legal, security, infrastructure, knowledge) with named owners. `[implemented]` — see `AGENTS.md` department map and `docs/ORG_CHART.md`.
- **R2 — Canonical runtime source.** Agents, skills, commands, and integrations should have one authoritative source that host bundles are generated from, so logic is not duplicated by hand. `[implemented]` — root `agents/`, `skills/`, `commands/`, `integrations/`; documented in `.lore.md`.
- **R3 — A single version authority.** Package metadata, the extension manifest, the changelog, git tags, and GitHub releases should agree on one version. `[partial]` — `package.json` and `gemini-extension.json` say `1.8.1`, `CHANGELOG.md` opens at `2.0.0`, the latest tag is `v2.0.0`, but that release is still a **draft**; the latest published release is `v1.9.9`.

### Execution protocol

- **R4 — Intent to artifact loop.** A mission should follow intent intake, routing, blueprinting, execution, verification, and reporting, ending in a reviewable artifact. `[implemented]` — described in `README.md` and `WORKFLOW.md`.
- **R5 — Operating modes.** BUILD, INCIDENT, and EXPERIMENT should each have defined rules and evidence expectations. `[implemented]` — `WORKFLOW.md`.
- **R6 — Verification ladder.** Cheaper proof (logic, interface, system) should be used before human review gates, and completion claims should cite evidence. `[implemented]` — `WORKFLOW.md`, and per-skill evidence gates noted in the v2.0.0 changelog.

### Skills, agents, and commands

- **R7 — Reusable skills with a stable contract.** Skills should have a discoverable entry point and manifest entry. `[implemented]` — `skills/*/SKILL.md` and `skills.json` (149 skills).
- **R8 — Skill quality review.** New or changed skills should be reviewable against a quality bar before merge. `[partial]` — `scripts/review-new-skills.sh` exists (Tessl + auditors, default threshold 70) but is not wired into CI.
- **R9 — Slash commands for common workflows.** Common workflows should have commands (`/tdd`, `/review`, `/release`, and others). `[implemented]` — `commands/` (25 commands).
- **R10 — Specialty agents with clear roles.** Specialist agents should be documented with role and scope. `[implemented]` — `agents/` (45 agents) and `docs/agents/`.

### Installation and distribution

- **R11 — Multiple install paths.** Users should be able to install via npm, via the skills registry, or from source. `[implemented]` — `npm install -g forge-anything`, `npx skills add`, and `git clone` + `./scripts/setup-cli.sh`.
- **R12 — Per-project scaffold and deploy.** A user should be able to scaffold an operating structure and deploy assets to a chosen host. `[implemented]` — `forge scaffold` and `forge deploy --tool <name>`.
- **R13 — Host integrations stay thin.** Each supported host should be a thin adapter over the canonical runtime, not a fork of it. `[partial]` — 12 integration surfaces exist under `integrations/`, and copies can drift from the source.

### Verification and release

- **R14 — Automated integrity check.** There should be a repeatable check for runtime integrity and manifest parity. `[implemented]` — `scripts/smoke.sh` (8-step audit-grade check).
- **R15 — Continuous integration on pull requests.** The integrity check and relevant tests should run on every PR. `[not implemented]` — only `deploy-docs.yml` and `publish-npm.yml` exist; there is no PR test workflow.
- **R16 — Release automation.** Publishing should be automated from a release. `[implemented]` — `.github/workflows/publish-npm.yml` publishes to npm with provenance on release.
- **R17 — Cross-platform paths.** Tracked filenames should be valid on Windows. `[not implemented]` — 278 files under `docs/departments/Knowledge/World-Map/` contain colons (illegal on NTFS); issue #198 reports the class of problem.

### Contribution and governance

- **R18 — Contribution guidance.** There should be a documented path for adding a skill, agent, or command and for what proof a PR needs. `[not implemented]` — no `CONTRIBUTING.md`, issue templates, or PR templates.
- **R19 — A published roadmap and PRD.** The project should state where it is going and why, in the repo. `[planned]` — this document and `ROADMAP.md` are the first; neither existed before.
- **R20 — Traceability of work.** Work should map to a scoped issue, brief, plan, or decision. `[implemented]` — stated as a foundation protocol in `WORKFLOW.md`.
- **R21 — Consistent public terminology.** Metadata and manifest copy should follow the same terminology rules as the rest of the repository. `[not implemented]` — `gemini-extension.json` still describes the project as "Humans 3.0 Protocol" and "self-evolving digital enterprises", wording `AGENTS.md` rejects.

## Success signals

- A new user can install the framework and scaffold a project by following the README without needing to ask how.
- A mission produces a reviewable artifact with evidence, not just a chat reply.
- The version shown by the package, the manifest, the changelog, and the latest release agree.
- A pull request that breaks the canonical runtime or manifest parity fails CI before review.
- A contributor can add a skill by reading one guide and getting it merged.
- The open pull-request queue stays small enough to review, instead of accumulating untriaged bot changes.
- The same operating logic works across the supported hosts without hand-maintaining parallel copies.
- The extension manifest and package metadata describe the project in the same terms the rest of the repo uses.

## Open questions

- Which file is the single version authority: `package.json`, the changelog, or the git tag?
- Should `personas/` be restored as canonical runtime, or should the references to it in `AGENTS.md` and the changelog be removed? The directory does not currently exist at the repo root.
- Should `integrations/*` and `docs/skills/` be generated only, or may they be hand-edited? The current drift risk depends on the answer.
- Should the audit-grade smoke test be the required CI gate, or a lighter check with the full audit on release?
- How should the automated PR bots (Palette, Bolt, Sentinel, Chronos) be triaged so useful changes land and noise does not pile up?
- Is the department-bundle model (`npx skills add --skill engineering`) the primary distribution path, or a secondary one behind npm?
- Should the draft `v2.0.0` release be published or retracted, and does that decide the version authority?
- How far beyond coding should the first worked end-to-end example go, and in which department?
