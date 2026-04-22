# Quick Start: The Galyarder Ecosystem

Get the Galyarder Framework (Intelligence), Galyarder HQ (Control Plane), and Galyarder Agent (Presence) working together in under 10 minutes.

## Prerequisites

- Python 3.11+ (for Agent)
- Node.js 20+ (for HQ/Dashboard)
- Git installed
- A project where you want to deploy (e.g., `~/projects/my-startup`)

---

## Phase 1: Initialize the Intelligence (Framework)

Bootstrap your system with the global Galyarder CLI.

### Option A: NPM (Recommended)
Install directly from the global registry to get all commands instantly.
```bash
npm install -g galyarder-framework
```

### Option B: Git Clone
For developers who want to stay on the bleeding edge of the source.
```bash
# 1. Clone the logic library
git clone https://github.com/galyarderlabs/galyarder-framework.git ~/galyarder-framework

# 2. Setup global CLI
cd ~/galyarder-framework
./scripts/setup-cli.sh
```

---

## Phase 2: Establish the Presence (Galyarder Agent)

Deploy your physical assistant runtime.

```bash
# 1. Install via one-liner (Debian/Ubuntu example)
curl -fsSL https://raw.githubusercontent.com/galyarderlabs/galyarder-agent/main/deploy/debian/install.sh | bash

# 2. Initialize
g-agent onboard
g-agent gateway
```

---

## Phase 3: Initialize Your Project HQ

Establish your specific project's digital headquarters.

```bash
cd ~/projects/my-startup

# 1. Build the Digital HQ structure
galyarder scaffold

# 2. Inject Intelligence into your Agent
galyarder deploy --tool galyarder-agent
```

---

## Phase 4: Launch the Control Plane (Galyarder HQ)

Deploy the governance dashboard to monitor your empire.

```bash
# 1. Clone the Control Plane
git clone https://github.com/galyarderlabs/galyarder-hq.git ~/galyarder-hq

# 2. Start the Dashboard
cd ~/galyarder-hq
npm install
npm run dev
```

The dashboard will be available at: **http://localhost:3100**

---

## How to Link the Triad

1.  **Galyarder Agent** talks to you on WhatsApp/Telegram.
2.  **Galyarder Framework** provides the SOPs when the Agent performs tasks.
3.  **Galyarder HQ** discovers the project and shows you the visual status.

To connect a project in the dashboard:
1. Open http://localhost:3100
2. Click **"Connect Project"**.
3. Point it to your project directory (`~/projects/my-startup`).

---

## Troubleshooting

### Commands not found
Ensure `~/.local/bin` is in your PATH. Run `source ~/.zshrc` (or `.bashrc`) after running the setup script.

### No agents detected
Ensure you have run `galyarder scaffold` inside your project directory. Both Agent and HQ rely on the `docs/departments/` structure.

---
© 2026 Galyarder Labs. Galyarder Framework. Engineering. Marketing. Distribution.
