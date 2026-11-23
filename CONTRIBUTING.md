# Contributing to Forge Anything

Thanks for helping! This guide covers how to build, test and send changes.
By taking part you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).
Security problems go privately to the maintainer; see
[SECURITY.md](SECURITY.md).

## Ground rules

- **The value leads.** Essential skills for the full lifecycle of an AI
  agent, in one place — from goal to shipped. If a change adds a skill,
  agent, or command, it must fit the lifecycle and the department it
  belongs to. The loop ends at distribution.
- **One source.** Skills, agents, and commands live once in `skills/`,
  `agents/`, and `commands/`. The mirrors (`integrations/`, `.cursor/`,
  `.codex/`, `.gemini/`, `docs/skills`, `docs/agents`, `docs/commands`)
  and the bundles are generated — never edit them by hand. Run the sync
  scripts and commit their output in the same pull request.
- **The header is single-source.** The GLOBAL PROTOCOLS block lives in
  [`docs/GLOBAL-PROTOCOLS.md`](docs/GLOBAL-PROTOCOLS.md). Change it there,
  then run `scripts/sync-global-protocols.py`.
- **No counts as value.** Never quote skill, agent, or command counts as
  the value of a change. Judge a skill on substance, not on how many there
  are.
- **Rules and workflow, nothing else.** The framework is the right way to
  work with an AI agent: rules and a workflow. Do not describe it as an
  "intelligence layer", an "operating system", or a "self-evolving"
  company. Those words do not describe what this is.
- **Evidence before completion.** A claim needs proof: a test, a build,
  a log, or a source check. Nothing ships unverified.
- **Human-directed.** Nothing in a contribution changes the approval
  gates: public, financial, and production actions need a human's
  approval.
- **Smallest viable route.** The shortest path that satisfies the goal,
  without speculative architecture.
- **Use official references.** Fetch current docs for APIs, libraries,
  and platform behavior before relying on memory.

## Building

```sh
git clone https://github.com/galyarderlabs/forge-anything.git
cd forge-anything
npm install                 # the CLI (forge)
```

Regenerate the derived surfaces after changing a skill, agent, command,
or the header:

```sh
python3 scripts/sync-skills-manifest.py     # skills.json
python3 scripts/sync-bundles.py             # the 10 bundles
python3 scripts/sync-global-protocols.py    # the header block
bash scripts/convert.sh --tool all          # the host mirrors
python3 scripts/generate-docs.py            # docs/AGENTS.md, CHANGELOG.md, RELEASE-NOTES.md, WORKFLOW.md
```

## Checks

Run these before sending a pull request (CI runs the same):

```sh
bash scripts/smoke.sh                      # the 8-point smoke test
```

The smoke test checks the manifest parity (skills.json matches `skills/`),
the bundles, the header block, the mirrors, and the marketplace manifest.
If it fails, fix the source and re-run the sync scripts — do not hand-edit
a generated file to make it pass.

## Code style

- Markdown: the skills, agents, and commands are Markdown. Match the
  surrounding file.
- Every skill, agent, and command carries the GLOBAL PROTOCOLS header
  (see [`docs/GLOBAL-PROTOCOLS.md`](docs/GLOBAL-PROTOCOLS.md)).
- Every skill has frontmatter on its `SKILL.md`.
- Comments explain *why*, not *what*.
- Write public-facing text plainly and directly. No hype, no counts as
  value, no "intelligence layer" language.

## Commits and pull requests

- One topic per pull request: two fixes are two pull requests, so each can
  be reviewed, tested and taken on its own. Describe what changed and how
  you tested it.
- When `main` moves on, rebase on it rather than merging it in.
- Your commits keep your name. What ships is credited in the changelog
  ("Thanks to @you").
- By contributing you agree that your work is licensed under the GNU
  General Public License v3.0 or later, like the rest of Forge Anything.

## Releasing

1. Move the `[Unreleased]` notes in `CHANGELOG.md` under a new version
   and date, and set that version in `package.json` (the single source
   of the version).
2. Commit, then tag and push: `git tag -a v2.0.1 -m "Forge Anything
   2.0.1"` and `git push origin main v2.0.1`.
3. The publish-npm workflow publishes the tagged source to npm, and the
   deploy-docs workflow deploys the docs site.
