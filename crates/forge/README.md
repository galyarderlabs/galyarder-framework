# forge

The Forge Anything CLI, in Rust.

```sh
forge <command> [options]
```

| Command | What it does |
| ------- | ------------ |
| `scaffold [dir]` | Initialize a new Forge Anything project (native Rust) |
| `smoke [args...]` | Run system integrity checks |
| `version` | Show current Forge Anything version |
| `help` | Show this help message |

## Install

```sh
cargo install --path crates/forge
```

## Scaffold

`scaffold` runs the native Rust scaffold (`forge-scaffold` crate). No dir
means the current directory; a dir argument is honored.

```sh
forge scaffold                 # scaffold into the current directory
forge scaffold my-project      # scaffold into ./my-project
forge scaffold --name acme --force my-project
```

## The other command

`smoke` still runs the repo's script (`scripts/smoke.sh`) with the
arguments passed through, and the CLI exits with the script's exit code.
Installation is via each harness's native plugin manifest, not through
this CLI.

## Version

The version comes from the source checkout's `package.json`, falling back
to the crate version. The crate version is kept in sync with `package.json`.

## Source

The scaffold and the scripts are resolved from a Forge Anything checkout,
in order: `--source <dir>`, `FORGE_SOURCE`, walking up from the current
directory, then walking up from the executable's directory. A source
checkout contains `skills/using-forge-anything/SKILL.md` and `agents/forge-ceo/SOUL.md`.

## Development

```sh
cargo fmt --check
cargo clippy --all-targets -- -D warnings
cargo test            # unit tests + CLI behavior tests
```

The behavior tests (`tests/cli.rs`) assert the help text, the version
against `package.json`, no-args and unknown-command handling, and exercise
`scaffold` and `smoke` through the Rust CLI.

Minimum Rust: 1.85 (edition 2024). Depends on the `forge-scaffold` crate
(path dependency) for the scaffold logic and source resolution.
