# Security policy

## Supported versions

Security fixes go into the latest release. Please update to it before
reporting.

| Version | Supported |
|---|---|
| 3.0.x | Yes |
| 2.x and older | No |

## Reporting a vulnerability

Please do not report security problems in public issues.

Report them privately instead, through **Security → Report a vulnerability**
on this repository, or by contacting the maintainer, Galyarder Labs, at
contact@galyarderlabs.com.

Include what you found, how to reproduce it, and what an attacker could do
with it. You will get a reply within 7 days. Once a fix is released, you are
credited in the changelog unless you would rather not be.

## Verifying a release

Each release is published by GitHub Actions from the tagged source.
The version in `package.json` is the single source of the version; the tag
and the published package carry the same number.

The `forge` CLI is distributed as a prebuilt binary through GitHub
Releases. Each release ships a `SHA256SUMS` file; the install script
verifies the downloaded binary against it before installing. You can
verify a binary yourself by comparing its SHA256 hash with the matching
entry in the release's `SHA256SUMS`.

The npm package is skills-only. It carries the skills, agents, commands,
and docs, not the CLI binary.

## What leaves your computer

Forge Anything has no server of its own and no telemetry. The CLI is a
Rust binary that runs locally. The MCP server (`forge mcp`) runs locally
over stdio and sends nothing over the network. It connects to the network
only for these:

| What | Where to | What is sent |
|---|---|---|
| Install the CLI | GitHub Releases (`github.com`, `objects.githubusercontent.com`) | A plain download of the prebuilt `forge` binary, when you run `install.sh`, with its SHA256 checked against the release's `SHA256SUMS` |
| Install the skills package | The npm registry (`registry.npmjs.org`) | A plain download of the skills-only package, when you run `npm install -g forge-anything` |
| Install skills via skills.sh | The skills.sh service | A plain download of the skills you pick, when you run `npx skills add` |
| Install a harness plugin | The harness plugin marketplace, or GitHub | A plain download of the plugin, when you run the harness install command in `docs/INTEGRATION.md` |

The skills, when run by an agent, may call the services they describe.
Each skill says so in its own file, and the agent runs them only under
your approval. The CLI (`forge`) never sends anything anywhere on its own.

## What stays on your computer

- The skills, agents, and commands, as local files in the framework
  directory.
- What the CLI writes: the repo it scaffolds into the directory you point
  it at. It writes nowhere else.
- The MCP server reads the local `skills/`, `agents/`, and `commands/`
  files and returns them over stdio. It writes nothing and sends nothing.

## Scope

Areas where a report is especially welcome:

- A skill, agent, or command that exfiltrates data or runs hidden
  commands.
- The MCP server (`forge mcp`) doing something unexpected: reading files
  outside the source repo, sending data over the network, or writing files.
- The CLI (`forge`) running something unexpected, or writing outside the
  project you pointed it at.
- The install script (`install.sh`) writing outside the install directory,
  or installing a binary whose SHA256 does not match the release's
  `SHA256SUMS`.
- A plugin manifest that points at an unexpected source, or registers an
  MCP server you did not expect.
- The smoke test passing when it should fail.
