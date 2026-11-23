<div align="center">

![Forge Anything](docs/assets/social-preview.png)

Forge anything with AI agents.

[![npm version](https://img.shields.io/npm/v/forge-anything.svg)](https://www.npmjs.com/package/forge-anything)
[![npm downloads](https://img.shields.io/npm/dm/forge-anything.svg)](https://www.npmjs.com/package/forge-anything)
[![License: GPL-3.0-or-later](https://img.shields.io/badge/license-GPL--3.0--or--later-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/galyarderlabs/forge-anything.svg)](https://github.com/galyarderlabs/forge-anything)
[![Smoke test](https://github.com/galyarderlabs/forge-anything/actions/workflows/smoke-test.yml/badge.svg)](https://github.com/galyarderlabs/forge-anything/actions/workflows/smoke-test.yml)
![Node.js 20+](https://img.shields.io/badge/Node.js-20%2B-green.svg)
![Python 3.11+](https://img.shields.io/badge/Python-3.11%2B-blue.svg)
![Rust 1.85+](https://img.shields.io/badge/Rust-1.85%2B-orange.svg)
[![Sponsor](https://img.shields.io/badge/sponsor-support-ff69b4?logo=githubsponsors)](https://github.com/sponsors/galyarderlabs)

Using an AI agent shouldn't be just generating code, and the agent shouldn't be confused. Forge Anything gives the agent tools that do the work, the skills to use them right, and a scaffold to start clean, so even a regular chatbot can add the MCP and forge anything. It is not a kanban board, a prompt pack, or another AI agent. This is the right way to work: rules and a workflow, simple as that, in your company, and in your life.

</div>

## How it works

1. **Goal**: say what you want, in plain words.
2. **Plan**: the work is routed to the right department and planned.
3. **Build**: the agent does the work, with tests before anything ships.
4. **Verify**: every claim is checked against evidence before it counts.
5. **Ship**: the work goes out. Distribution is where the loop ends.

The full workflow, with the five phases in detail, is in [docs/WORKFLOW.md](docs/WORKFLOW.md).

## Rules

- Human-directed: public, financial, and production actions need a human's approval.
- Evidence before completion: no claim counts without proof you can check.
- Tests before fixes: nothing ships unverified.
- Ship it: the loop ends at distribution, not at a draft.

## Install

The `forge` CLI is Rust. From a checkout:

```sh
cargo install --path crates/forge
```

Or get just the skills, without the CLI:

```sh
npm install -g forge-anything
npx skills add galyarderlabs/forge-anything --skill full
```

Step by step, including local install and other tools, is in [docs/QUICK_START.md](docs/QUICK_START.md).

## Documentation

- [Quick start](docs/QUICK_START.md): install and first run
- [Workflow](docs/WORKFLOW.md): the five phases, in full
- [Integration](docs/INTEGRATION.md): the tools it plugs into
- [Codex guide](docs/README.codex.md): using it with OpenAI Codex
- [OpenCode guide](docs/README.opencode.md): using it with OpenCode
- [Departments](docs/departments/): the departments and what each owns
- [Agents](docs/agents/): the personas that do the work
- [Skills](docs/skills/): the full skill list
- [Commands](docs/commands/): the shortcuts
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
