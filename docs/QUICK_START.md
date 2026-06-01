# Quick Start: Agentic Company Setup

Get Galyarder Framework, Galyarder Agent, and Galyarder HQ working together as an agentic-company stack.

## Prerequisites

- Python 3.11+ for Galyarder Agent
- Node.js 20+ for Galyarder HQ and the Framework CLI
- Git installed
- A project where you want to deploy the operating structure, such as `~/projects/my-startup`

## Phase 1: Install the Intelligence Layer

Bootstrap Galyarder Framework with the global CLI.

### Option A: NPM (recommended)

```bash
npm install -g galyarder-framework
```

### Option B: Skills.sh

Pull all intelligence bundles, or install a department bundle only.

```bash
# Pull everything
npx skills add galyarderlabs/galyarder-framework --skill full

# Or pull by department
npx skills add galyarderlabs/galyarder-framework --skill engineering
```

### Option C: Git clone

Use the source directly when you want to inspect, modify, or contribute.

```bash
git clone https://github.com/galyarderlabs/galyarder-framework.git ~/galyarder-framework
cd ~/galyarder-framework
./scripts/setup-cli.sh
```

## Phase 2: Deploy the Framework into a project

Create the project operating structure and deploy agent rules, skills, and commands to the tool you use.

```bash
cd ~/projects/my-startup

# Create department/report/planning structure
galyarder scaffold

# Deploy to a target tool
# Available: cursor, windsurf, kilocode, augment, openclaw, hermes, antigravity, galyarder-agent
galyarder deploy --tool <name>
```

## Phase 3: Add the Continuity Layer (Galyarder Agent)

Galyarder Agent gives the framework an interface: memory, channels, tool access, and recurring jobs.

```bash
# Debian/Ubuntu example
curl -fsSL https://raw.githubusercontent.com/galyarderlabs/galyarder-agent/main/deploy/debian/install.sh | bash

g-agent onboard
g-agent gateway
```

## Phase 4: Add the Command Layer (Galyarder HQ)

Galyarder HQ gives you visibility over departments, goals, reports, and agent activity.

```bash
git clone https://github.com/galyarderlabs/galyarder-hq.git ~/galyarder-hq
cd ~/galyarder-hq
npm install
npm run dev
```

The dashboard will be available at: **http://localhost:3100**

## How the stack connects

1. **Galyarder Framework** provides the agents, skills, commands, and workflow protocols.
2. **Galyarder Agent** gives those protocols memory, channels, and tool access.
3. **Galyarder HQ** reads the project structure and shows goals, reports, and operating state.
4. **Galyarder Ledger** can be added where finance, approvals, and evidence need ledger-backed execution.

To connect a project in HQ:

1. Open `http://localhost:3100`.
2. Click **Connect Project**.
3. Point it to your project directory, such as `~/projects/my-startup`.

## Troubleshooting

### Commands not found

Ensure `~/.local/bin` or your npm global bin directory is in your PATH. Restart your shell after setup.

### No agents detected

Run `galyarder scaffold` inside the project directory, then deploy the framework to your target tool with `galyarder deploy --tool <name>`.
