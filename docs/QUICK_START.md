# Quick Start

Get Forge Anything running in a project.

## Prerequisites

- A project where you want to deploy the operating structure, such as `~/projects/my-startup`
- Node.js 20+ for the skills install (`npx skills add`)
- Git installed
- Rust 1.85+ only if you build the Forge Anything CLI (`forge`) from source; the prebuilt install below needs no Rust toolchain

## Phase 1: Install the CLI

Install the prebuilt `forge` CLI binary (Linux, macOS, Windows), no Rust
toolchain needed:

```bash
curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh
```

Or install a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh -s -- --version 3.0.2
```

The script downloads the binary for your platform from the latest GitHub
Release, verifies its SHA256 checksum, and installs it to `~/.local/bin`.

Or install the binary with cargo, from a checkout (requires Rust 1.85+):

```bash
cargo install --path crates/forge
```

Just the skills, without the CLI:

```bash
npx skills add galyarderlabs/forge-anything
```

## Phase 2: Deploy the Framework into a project

Create the project operating structure, then install the framework into the tool you use.

```bash
cd ~/projects/my-startup

# Create department/report/planning structure
forge scaffold
```

Install Forge Anything into your harness through its own plugin manager, not through the CLI. See [docs/INTEGRATION.md](INTEGRATION.md) for the per-harness install commands.

## How the pieces connect

1. **Forge Anything** provides the agents, skills, commands, and workflow.
2. **The `forge` CLI** scaffolds the project structure (`forge scaffold`), imports company packages ([`forge company import`](company-import.md)), and serves the MCP server (`forge mcp`).
3. **Your harness plugin** loads the skills, commands, and MCP server into the agent you already use.

Work follows the flow in [docs/how-it-works.md](how-it-works.md): Ideas, Goal, Ship, Earn, Give back, with plan, build, verify as the inner loop. See [WORKFLOW.md](../WORKFLOW.md) for the phases in full.

## Troubleshooting

### Commands not found

Ensure `~/.local/bin` (or `~/.cargo/bin` if you built from source) is in your PATH. Restart your shell after setup.

### No agents detected

Run `forge scaffold` inside the project directory, then install your harness's native plugin (see [docs/INTEGRATION.md](INTEGRATION.md)).
