# Quick Start: Agentic Company Setup

Get Forge Anything, Forge Agent, and Forge HQ working together as an agentic-company stack.

## Prerequisites

- Python 3.11+ for Forge Agent
- Rust 1.85+ for the Forge Anything CLI (`forge`)
- Node.js 20+ for Forge HQ
- Git installed
- A project where you want to deploy the operating structure, such as `~/projects/my-startup`

## Phase 1: Install the CLI

The `forge` CLI is Rust. Clone the repo and run the setup script (it builds
the CLI and links it into your PATH):

```bash
git clone https://github.com/galyarderlabs/forge-anything.git ~/forge-anything
cd ~/forge-anything
./scripts/setup-cli.sh
```

Or install the binary with cargo, from a checkout:

```bash
cargo install --path crates/forge
```

Just the skills, without the CLI, are on npm:

```bash
npm install -g forge-anything
npx skills add galyarderlabs/forge-anything --skill full

# Or pull by department
npx skills add galyarderlabs/forge-anything --skill engineering
```

## Phase 2: Deploy the Framework into a project

Create the project operating structure and deploy agent rules, skills, and commands to the tool you use.

```bash
cd ~/projects/my-startup

# Create department/report/planning structure
forge scaffold

# Deploy to a target tool
# Available: forge-agent
forge deploy --tool forge-agent
```

Native plugin harnesses (Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, Hermes) are installed through each harness's own plugin manager, not through `forge deploy`. See [docs/INTEGRATION.md](INTEGRATION.md).

## Phase 3: Add the Continuity Layer (Forge Agent)

Forge Agent gives the framework an interface: memory, channels, tool access, and recurring jobs.

```bash
# Debian/Ubuntu example
curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-agent/main/deploy/debian/install.sh | bash

g-agent onboard
g-agent gateway
```

## Phase 4: Add the Command Layer (Forge HQ)

Forge HQ gives you visibility over departments, goals, reports, and agent activity.

```bash
git clone https://github.com/galyarderlabs/forge-hq.git ~/forge-hq
cd ~/forge-hq
npm install
npm run dev
```

The dashboard will be available at: **http://localhost:3100**

## How the stack connects

1. **Forge Anything** provides the agents, skills, commands, and workflow protocols.
2. **Forge Agent** gives those protocols memory, channels, and tool access.
3. **Forge HQ** reads the project structure and shows goals, reports, and operating state.
4. **Forge Ledger** can be added where finance, approvals, and evidence need ledger-backed execution.

To connect a project in HQ:

1. Open `http://localhost:3100`.
2. Click **Connect Project**.
3. Point it to your project directory, such as `~/projects/my-startup`.

## Troubleshooting

### Commands not found

Ensure `~/.local/bin` or your npm global bin directory is in your PATH. Restart your shell after setup.

### No agents detected

Run `forge scaffold` inside the project directory, then deploy the framework: for Forge Agent use `forge deploy --tool forge-agent`; for a plugin harness, install its native plugin (see [docs/INTEGRATION.md](INTEGRATION.md)).
