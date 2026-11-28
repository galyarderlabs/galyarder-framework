<div align="center">

![Forge Anything](docs/assets/social-preview.png)

Forge anything with AI agents.

[![License: GPL-3.0-or-later](https://img.shields.io/badge/license-GPL--3.0--or--later-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/galyarderlabs/forge-anything.svg)](https://github.com/galyarderlabs/forge-anything)
[![Smoke test](https://github.com/galyarderlabs/forge-anything/actions/workflows/smoke-test.yml/badge.svg)](https://github.com/galyarderlabs/forge-anything/actions/workflows/smoke-test.yml)
[![Rust](https://github.com/galyarderlabs/forge-anything/actions/workflows/rust.yml/badge.svg)](https://github.com/galyarderlabs/forge-anything/actions/workflows/rust.yml)
[![Repo hygiene](https://github.com/galyarderlabs/forge-anything/actions/workflows/repo-hygiene.yml/badge.svg)](https://github.com/galyarderlabs/forge-anything/actions/workflows/repo-hygiene.yml)
[![Latest release](https://img.shields.io/github/v/release/galyarderlabs/forge-anything.svg)](https://github.com/galyarderlabs/forge-anything/releases/latest)
![Node.js 20+](https://img.shields.io/badge/Node.js-20%2B-green.svg)
![Python 3.11+](https://img.shields.io/badge/Python-3.11%2B-blue.svg)
![Rust 1.85+](https://img.shields.io/badge/Rust-1.85%2B-orange.svg)
[![MCP](https://img.shields.io/badge/MCP-2025--06--18-blue.svg)](docs/INTEGRATION.md)
[![Sponsor](https://img.shields.io/badge/sponsor-support-ff69b4?logo=githubsponsors)](https://github.com/sponsors/galyarderlabs)

Using an AI agent shouldn't be just generating code, and the agent shouldn't be confused. Forge Anything gives the agent tools that do the work, the skills to use them right, and a scaffold to start clean, so even a regular chatbot can add the MCP and forge anything. It is not a kanban board, a prompt pack, or another AI agent. This is the right way to work: rules and a workflow, simple as that, in your company, and in your life.

</div>

## Why Forge Anything

Left to itself, an AI agent takes the shortest path and stops at a draft. It has no rules for what comes after the code, no clean place to start, no way to reach the tools and people it needs, and no way to ship. It gets confused about what to do next, and the work ends at a draft, not at a shipped thing.

Forge Anything is the whole system, not one piece: skills that say how each job is done, agents that do the work with judgment, and commands that start it. The rules and the workflow hold them together. The scaffold starts clean, the CLI builds, serves, and checks, the MCP carries it to any agent or chatbot, and the plugins put it in the harness the agent already uses. One system, from ideas to shipped work, earned from and given back, in the company and in life.

It covers the whole company and life, not just code: product, growth, security, infrastructure, legal and finance, and knowledge, alongside engineering. The pieces fit together and give back closes the cycle, so the work ships instead of sitting as a draft.

## How it works

One flow, five stages:

1. **Ideas**: turn sparks into something worth building.
2. **Goal**: say what you want, in plain words. The work gets a plan, with the rules and the workflow that fit it.
3. **Ship**: the agent plans it, builds it, checks every claim against evidence, and ships it. Distribution is where the build loop ends.
4. **Earn**: price it, sell it, collect it.
5. **Give back**: return what you earned, in whatever form fits (skills, content, tools, time, money), so the next person has hope to start and the next cycle starts at Ideas.

Three pieces do the work:

- **Skills**: how each job is done. One skill per job, a workflow with steps and exit criteria, grouped by department, from engineering and product to finance, legal, and life.
- **Agents**: who does it. One agent per recurring job, a role with a judgment standard, a memory of what was decided, and the skills it reads to do the work.
- **Commands**: when it starts. One line that dispatches agents or a skill, like `/ship` for a release, so the operator starts the work instead of explaining it.

Three pieces deliver it to the agent:

- **Scaffold**: `forge scaffold` drops a tidy repo into a folder, with the curated skills, agents, and commands. Start clean, not from a blank page.
- **CLI**: `forge` is the command line tool. It scaffolds a project, imports company packages ([docs/company-import.md](docs/company-import.md)), serves the MCP, and smoke-tests the repo.
- **MCP**: `forge mcp` is the MCP server. It gives any agent, or even a regular chatbot, the tools to read skills, agents, and commands, and to scaffold a project. Install the MCP, not the skills, and the agent gets the tools plus the workflow.

The full workflow, with the goal-to-ship phases in detail, is in [WORKFLOW.md](WORKFLOW.md). The harness plugins are in [docs/INTEGRATION.md](docs/INTEGRATION.md).

## How it compares

Wondering how this stacks up against [Superpowers](https://github.com/obra/superpowers), [Agent Skills](https://github.com/addyosmani/agent-skills) by Addy Osmani, or [Matt Pocock's skills](https://github.com/mattpocock/skills)? See [docs/comparison.md](docs/comparison.md) for an honest, side-by-side look at how the four are shaped differently and when to reach for each.

## Rules

- Human-directed: public, financial, and production actions need a human's approval.
- Evidence before completion: no claim counts without proof you can check.
- Tests before fixes: nothing ships unverified.
- Ship it: distribution is where the build loop ends, not at a draft.

## Install

Get the `forge` CLI as a prebuilt binary (Linux, macOS, Windows), no Rust
toolchain needed:

```sh
curl -fsSL https://raw.githubusercontent.com/galyarderlabs/forge-anything/main/install.sh | sh
```

Or get just the skills, without the CLI:

```sh
npx skills add galyarderlabs/forge-anything
```

Native plugins cover Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes; see [docs/INTEGRATION.md](docs/INTEGRATION.md).

Step by step, including local install and other tools, is in [docs/QUICK_START.md](docs/QUICK_START.md).

## Documentation

- [Quick start](docs/QUICK_START.md): install and first run
- [How it works](docs/how-it-works.md): the pieces and the flow, start to finish
- [Workflow](WORKFLOW.md): the five phases, in full
- [Comparison](docs/comparison.md): how it compares with Superpowers, Agent Skills, and Matt Pocock's skills
- [Integration](docs/INTEGRATION.md): the tools it plugs into
- [Departments](docs/departments/): the departments and what each owns
- [Agents](agents/): the personas that do the work
- [Skills](skills/): the full skill list
- [Commands](docs/commands.md): every command, when to use it, and what it returns
- [Roadmap](ROADMAP.md): what we are building next
- [Changelog](CHANGELOG.md): what changed

## Contributing

Bug reports, ideas and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md) for how to build, test and send changes,
and [CHANGELOG.md](CHANGELOG.md) for what changed. Everyone taking part
follows the [Code of Conduct](CODE_OF_CONDUCT.md); please report security
problems privately as described in [SECURITY.md](SECURITY.md).

## Support

Forge Anything is free and always will be. If it makes your agents work the right way, you can [sponsor Galyarder Labs on GitHub](https://github.com/sponsors/galyarderlabs). A star, a bug report or telling a friend helps just as much.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=galyarderlabs/forge-anything&type=Date)](https://star-history.com/#galyarderlabs/forge-anything&Date)

## License

Forge Anything is free software: you can redistribute it and/or modify it under the terms of the [GNU General Public License](LICENSE) as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the [GNU General Public License](LICENSE) for more details.
