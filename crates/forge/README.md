# forge

The Forge Anything CLI, in Rust. Replaces `bin/forge.js` with the same
interface, help text, and exit codes.

```sh
forge <command> [options]
```

| Command | What it does |
| ------- | ------------ |
| `scaffold [dir]` | Initialize a new Forge Anything project (native Rust) |
| `deploy [args...]` | Deploy agents to your IDE or global environment |
| `smoke [args...]` | Run system integrity checks |
| `convert [args...]` | Run conversion engine for different AI platforms |
| `sync [args...]` | Synchronize skills with your local environment |
| `version` | Show current Forge Anything version |
| `help` | Show this help message |

## Scaffold

`scaffold` runs the native Rust scaffold (`forge-scaffold` crate). No dir
means the current directory, matching the JS CLI. A dir argument is honored
(in the JS CLI it was ignored and the scaffold always landed in the
working directory).

```sh
forge scaffold                 # scaffold into the current directory
forge scaffold my-project      # scaffold into ./my-project
forge scaffold --name acme --force my-project
```

## The other commands

`deploy`, `smoke`, `convert` and `sync` still run the repo's scripts
(`scripts/install.sh`, `scripts/smoke.sh`, `scripts/convert.sh`,
`scripts/sync-codex-skills.py`) with the arguments passed through, exactly
as the JS CLI did, and the CLI exits with the script's exit code.
Reimplementing those in Rust is the follow-up; the CLI surface is Rust now.

## Version

The version comes from the source checkout's `package.json` (the same file
the JS CLI read), falling back to the crate version. The crate version is
kept in sync with `package.json`.

## Source

The scaffold and the scripts are resolved from a Forge Anything checkout,
in order: `--source <dir>`, `FORGE_SOURCE`, walking up from the current
directory, then walking up from the executable's directory. A source
checkout contains `skills/forge/SKILL.md` and `agents/forge-ceo.md`.

## Development

```sh
cargo fmt --check
cargo clippy --all-targets -- -D warnings
cargo test            # unit tests + CLI parity tests against bin/forge.js
```

The parity tests (`tests/cli_parity.rs`) compare help, version, no-args and
unknown-command output byte-for-byte against the JS CLI (they skip the
JS comparison when `node` is not installed), and exercise `scaffold` and
`smoke` through the Rust CLI.

Minimum Rust: 1.85 (edition 2024). Depends on the `forge-scaffold` crate
(path dependency) for the scaffold logic and source resolution.
