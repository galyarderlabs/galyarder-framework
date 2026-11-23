<div align="center">

![Galyarder Framework](docs/assets/social-preview.png)

Essential skills for the full lifecycle of an AI agent, in one place — from goal to shipped.

[![npm version](https://img.shields.io/npm/v/galyarder-framework.svg)](https://www.npmjs.com/package/galyarder-framework)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/galyarderlabs/galyarder-framework.svg)](https://github.com/galyarderlabs/galyarder-framework)
[![Smoke test](https://github.com/galyarderlabs/galyarder-framework/actions/workflows/smoke-test.yml/badge.svg)](https://github.com/galyarderlabs/galyarder-framework/actions/workflows/smoke-test.yml)
![Node.js 20+](https://img.shields.io/badge/Node.js-20%2B-green.svg)

Using an AI agent shouldn't be just generating code, and the agent shouldn't be confused. This is the right way to work: rules and a workflow, simple as that. The best skills, unified in one place — in your company, and in your life.

</div>

## How it works

1. **Goal** — say what you want, in plain words.
2. **Plan** — the work is routed to the right department and planned.
3. **Build** — the agent does the work, with tests before anything ships.
4. **Verify** — every claim is checked against evidence before it counts.
5. **Ship** — the work goes out. Distribution is where the loop ends.

The full workflow, with the five phases in detail, is in [docs/WORKFLOW.md](docs/WORKFLOW.md).

## Features

The work is routed by department, so the agent always knows where a job belongs and what proof it needs.

| Department | Lead | Owns |
|---|---|---|
| Founder Office / Capital | fundraising-operator | Founder context, investor relations, board updates, diligence, narrative |
| Product | product-manager, planner | Direction, prioritization, requirements, scope, roadmap, issue decomposition |
| Engineering | super-architect, architect, elite-developer | Architecture, implementation, tests, code quality, delivery, refactoring |
| Security | security-guardian, perseus | Security review, threat modeling, authorized offensive testing, incident analysis, hardening |
| Growth | growth-strategist, growth-engineer | Acquisition, conversion, retention, distribution, analytics, messaging |
| Infrastructure / Operations | devops-engineer, release-manager | CI/CD, deployment, runtime operations, release readiness, cost controls |
| Legal / Finance | legal-counsel, finops-manager, financial-analyst | Legal and compliance, cost economics, pricing, contracts, privacy, governance |
| Knowledge / Documentation | docs, obsidian-architect | Documentation, decision history, operating reports, knowledge maps, release notes |

It plugs into Claude Code, Cursor, Gemini CLI, OpenAI Codex, Windsurf, OpenCode, Hermes Agent, OpenClaw, Kilo Code, Augment, Antigravity, Galyarder Agent, and Galyarder HQ — see [Integration](docs/INTEGRATION.md).

One source, generated everywhere: the skills, agents, and commands live once in `skills/`, `agents/`, and `commands/`, and the mirrors for each tool are generated from them. No copies to drift.

## Usage

**Scaffold a project.**
Your project gets the department, report, and planning structure.

| Do this | To |
|---|---|
| `galyarder scaffold` | Create the operating structure in your project |
| `galyarder deploy --tool <name>` | Deploy the rules, skills, and commands to your tool (cursor, windsurf, kilocode, augment, openclaw, hermes, antigravity, galyarder-agent) |

**Check it works.**

| Do this | To |
|---|---|
| `galyarder smoke` | Run the 8-point smoke test; green before anything ships |

**Add the other layers.**
The framework is the intelligence; the Agent and HQ complete the stack.

| Do this | To |
|---|---|
| Add Galyarder Agent (`g-agent onboard`, `g-agent gateway`) | Memory, channels, tool access, and recurring jobs |
| Add Galyarder HQ (clone galyarder-hq, `npm install`, `npm run dev`) | Visibility over departments, goals, reports, and agent activity |

The full how-to is in the [quick start](docs/QUICK_START.md) and the [workflow](docs/WORKFLOW.md).

## Rules

- Human-directed: public, financial, and production actions need a human's approval.
- Evidence before completion: no claim counts without proof you can check.
- Tests before fixes: nothing ships unverified.
- Ship it: the loop ends at distribution, not at a draft.

## Requirements

- **Node.js 20+** for the Framework CLI and Galyarder HQ.
- **Python 3.11+** for Galyarder Agent.
- **Git** installed.
- A project where you want to deploy the operating structure, such as `~/projects/my-startup`.

## Installation

1. Install the framework, one of three ways:

   ```sh
   npm install -g galyarder-framework
   ```

   Or pull just the skills you need:

   ```sh
   npx skills add galyarderlabs/galyarder-framework --skill full
   ```

   Or clone the source, to inspect, modify, or contribute:

   ```sh
   git clone https://github.com/galyarderlabs/galyarder-framework.git ~/galyarder-framework
   cd ~/galyarder-framework
   ./scripts/setup-cli.sh
   ```

2. Run the same command again to update; your setup stays as you set it.

Step by step, including local install and other tools, is in [docs/QUICK_START.md](docs/QUICK_START.md).

## Documentation

- [Quick start](docs/QUICK_START.md) — install and first run
- [Workflow](docs/WORKFLOW.md) — the five phases, in full
- [Integration](docs/INTEGRATION.md) — the tools it plugs into
- [Codex guide](docs/README.codex.md) — using it with OpenAI Codex
- [OpenCode guide](docs/README.opencode.md) — using it with OpenCode
- [Departments](docs/departments/) — the departments and what each owns
- [Agents](docs/agents/) — the personas that do the work
- [Skills](docs/skills/) — the full skill list
- [Commands](docs/commands/) — the shortcuts
- [Roadmap](ROADMAP.md) — what we are building next
- [Changelog](CHANGELOG.md) — what changed

## Contributing

Bug reports, ideas and pull requests are welcome. See the [issues](https://github.com/galyarderlabs/galyarder-framework/issues) and [pull requests](https://github.com/galyarderlabs/galyarder-framework/pulls), and [CHANGELOG.md](CHANGELOG.md) for what changed.

## Support

Galyarder Framework is free and always will be. If it makes your agents work the right way, you can [sponsor Galyarder Labs on GitHub](https://github.com/sponsors/galyarderlabs). A star, a bug report or telling a friend helps just as much.

## License

MIT. See [LICENSE](LICENSE).

---

<div align="center">

[![Give Galyarder Framework a star](https://img.shields.io/github/stars/galyarderlabs/galyarder-framework?style=social)](https://github.com/galyarderlabs/galyarder-framework)

</div>
