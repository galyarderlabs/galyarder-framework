# forge-scaffold

Drop a tidy Forge Anything repo into a folder, so an AI agent already knows
the rules, the workflow, and where to put its work.

```sh
forge-scaffold [OPTIONS] <target-dir>
```

## What it creates

- `README.md`, `AGENTS.md`, `WORKFLOW.md`, `.gitignore`, `skills.json`
- `skills/` — the curated skills (see `src/curated.rs` for the list and the
  criteria: the core loop plus 1-6 per department, defensive/compliance
  security basics instead of the offensive/threat-intel niche, no bundle
  skills except the `forge` entry point)
- `agents/` — the five Forge agents plus the lead role agent per department
- `commands/` — all slash commands
- `docs/` — specs, plans, reports, templates, design, and the 8 departments
  (`docs/departments/<Dept>/`), each with a README and an audit template
- `.claude-plugin/marketplace.json`, `gemini-extension.json` — host manifests
  so Claude Code and Gemini discover `skills/` directly
- `.cursor/rules/<skill>.mdc` — Cursor rules for the curated skills

Other hosts (Codex, OpenCode, Windsurf, KiloCode, Antigravity, OpenClaw,
Hermes) read `skills/` directly, so no separate copy is needed for them.

## Source

The scaffold copies from a Forge Anything checkout. It resolves the source
in order: `--source <dir>`, the `FORGE_SOURCE` environment variable, walking
up from the current directory, then next to the executable. A source checkout
contains `skills/forge/SKILL.md` and `agents/forge-ceo.md`.

```sh
# From inside a forge-anything checkout:
cargo run -p forge-scaffold -- my-project

# Anywhere, with an explicit source:
forge-scaffold --source ~/workspace/galyarder-framework my-project
```

## Options

| Flag | Meaning |
| ---- | ------- |
| `--source <dir>` | Forge Anything checkout to copy from |
| `--name <name>` | Project name for the generated README (default: target dir name) |
| `--force` | Scaffold into a non-empty directory |
| `--help`, `--version` | Help / version |

Exit codes: 0 on success, 1 on usage errors, 2 when the scaffold fails.
Refuses a non-empty target unless `--force` is given.

## Development

```sh
cargo fmt --check     # formatting
cargo clippy --all-targets -- -D warnings
cargo test            # unit tests + the e2e acceptance test (issue #212)
```

The e2e test (`tests/scaffold_e2e.rs`) runs the built binary into an empty
temp dir and asserts the result is a ready repo: structure, docs, curated
skills + agents, commands, integrations, and no "Galyarder Framework"
product name in the output.

Minimum Rust: 1.85 (edition 2024). No external dependencies; the crate is
standard-library only, so `cargo build` stays fast and offline-friendly.

## Status

Replaces the shell scaffold (`scripts/scaffold-company.sh`, invoked by the
JS `forge scaffold` command). The JS CLI still ships the shell scaffold;
wiring it to this binary is the distribution step, once the binary is
published alongside the npm package.
