# Forge Anything — Roadmap

Forge Anything is the Intelligence Layer of the Galyarder ecosystem: a set of agents, skills, commands, review gates, and operating protocols that turn a founder's intent into structured, reviewable work. It is for solo founders and small teams who run several AI agents across engineering, product, growth, finance, security, and docs, and who need that work to be routed, verified, and written down instead of lost in a chat thread. The problem it addresses is the gap between a goal and a trustworthy artifact: most agent setups stop at chat, and the work that follows has no durable scope, no routing, no review gate, and no audit trail.

## Where it is now

The framework ships a large, real surface. The canonical runtime lives at the repo root in `agents/` (45 agents), `skills/` (149 skills), `commands/` (25 commands), and `integrations/` (12 host surfaces: Claude Code, Cursor, Gemini CLI, Codex, OpenCode, Windsurf, KiloCode, Augment, Antigravity, OpenClaw, Hermes, and Forge Agent). A Rust CLI (`crates/forge`, binary `forge`) handles `scaffold`, `deploy`, `smoke`, and `convert`. The docs site (mkdocs-material) is generated into `docs/`, and `skills.json` lists the skill manifest.

Parts of this are still thin or inconsistent:

- **Version numbers disagree.** `package.json` and `gemini-extension.json` both say `1.8.1`, `CHANGELOG.md` opens at `2.0.0`, the newest git tag is `v2.0.0`, but `v2.0.0` is still a **draft release** — the newest published release is `v1.9.9`.
- **There is no PR test gate.** The only workflows are `deploy-docs.yml` and `publish-npm.yml`. The audit-grade `scripts/smoke.sh` exists but does not run on pull requests.
- **The contribution surface is missing.** There is no `CONTRIBUTING.md`, no issue or PR templates, and no in-repo roadmap or PRD. This file is the first.
- **The PR queue is mostly automated.** 36 pull requests are open, nearly all from the Palette/Bolt/Sentinel/Chronos bots, and they are not being consolidated into release tracks.
- **Generated copies drift from source.** `docs/skills/` and `integrations/*` mirror the canonical `skills/`, so a change in one place can leave the others stale.
- **Windows checkouts can fail.** 278 tracked files under `docs/departments/Knowledge/World-Map/` contain colons in their names, which is illegal on NTFS. One of these is tracked as issue #198.
- **The extension manifest breaks the repo's own language rules.** `gemini-extension.json` describes the project as *"Humans 3.0 Protocol … self-evolving digital enterprises"*, wording that `AGENTS.md` explicitly rejects.

## Now

- **Make the version story single-source.** `package.json`, `gemini-extension.json`, `CHANGELOG.md`, git tags, and GitHub releases should agree, and one of them should be the authority. Today they diverge, which makes every install instruction uncertain. The draft `v2.0.0` release also needs a decision: publish it or retract it.
- **Run the smoke test on every pull request.** `scripts/smoke.sh` already checks canonical runtime integrity and manifest parity. Wiring it into CI turns a manual habit into an enforced gate.
- **Add a contribution guide.** A `CONTRIBUTING.md` that explains the canonical runtime layout, how to add a skill, and what proof a PR needs lowers the cost of outside help.
- **Consolidate the open PR backlog.** Group the open bot PRs into a small number of reviewable tracks, merge what holds up, and close what does not. A 36-item queue with no triage hides real work.
- **Fix Windows-unsafe paths.** Resolve the colon-containing filenames (278 of them; issue #198 reports the class) and add a guard so new ones cannot land.
- **Correct the extension manifest copy.** Rewrite the `gemini-extension.json` description so it matches the terminology rules the rest of the repo already follows.

## Next

- **Add a worked end-to-end example.** One mission shown from goal to plan, issue, implementation, test, audit, and release artifact. The README names this as a next step; it is the clearest way to prove the protocol is more than prose.
- **Reconcile the `personas/` reference.** `AGENTS.md`, the changelog, and the v2.0.0 release notes describe `personas/` as canonical runtime, but the directory does not exist at the repo root. Either restore it or correct the references.
- **Guard manifest and generated-surface parity in CI.** `skills.json`, `docs/skills/`, and `integrations/*` should be checked against `skills/` so drift is caught before merge.
- **Add issue and PR templates.** A short template per type keeps new reports and contributions in the format the maintainers already use.
- **Sharpen the department bundles.** Make `full`, `engineering`, `growth`, and the other bundles clearly describe what they pull, so `npx skills add` users know what they are getting.

## Later

- **Turn the evidence gates into checks, not instructions.** The v2.0.0 notes say every skill now requires local verification before handoff. The longer goal is to make that verifiable rather than aspirational, where a host can run it.
- **Connect the knowledge graph to routing.** The graph engine already emits nodes and edges; the next step is letting routing read that structure so agents choose paths from real project shape.
- **Broaden the protocol beyond coding.** The workflow is written for the whole company, not just engineering. Real examples in growth, finance, and legal would show whether that holds up.
- **Keep the host surface honest.** As more hosts are added, the shared operating logic should stay in one place and each integration should stay a thin adapter.

## Not planned

- **No hosted cloud service.** The framework is a local, inspectable set of files. There is no plan to turn it into a managed SaaS.
- **No autonomous execution without approval.** Human command is a core principle. Public, financial, irreversible, or production-sensitive actions keep a human gate.
- **No model training or fine-tuning.** This layer routes and governs work; it does not train models.
- **No closed or source-available license.** The project is GPL-3.0-or-later and stays that way.
- **No replacement for a project tracker.** The framework routes and verifies work; it is not a kanban board or a PM tool.

## How to follow along

Read the docs site at https://galyarderlabs.github.io/forge-anything/ and the `docs/` directory in the repo. Watch the pull requests and releases on GitHub for what is landing. Open an issue for a concrete bug or a scoped proposal, and send a pull request against `main`. Because the project is small and early, a clear, well-scoped issue is the fastest way to get a change reviewed.
