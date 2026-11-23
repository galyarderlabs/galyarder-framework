# Security policy

## Supported versions

Security fixes go into the latest release. Please update to it before
reporting.

| Version | Supported |
|---|---|
| 2.0.x | Yes |
| 1.x and older | No |

## Reporting a vulnerability

Please do not report security problems in public issues.

Report them privately instead, through **Security → Report a vulnerability**
on this repository, or by contacting the maintainer, Galyarder Labs, at
contact@galyarderlabs.com.

Include what you found, how to reproduce it, and what an attacker could do
with it. You will get a reply within 7 days. Once a fix is released, you are
credited in the changelog unless you would rather not be.

## Verifying a release

Each release is published to npm by GitHub Actions from the tagged source.
The version in `package.json` is the single source of the version; the tag
and the published package carry the same number.

## What leaves your computer

Galyarder Framework is Markdown and scripts, with no server of its own and
no telemetry. It connects to the network only for these:

| What | Where to | What is sent |
|---|---|---|
| Install from npm | The npm registry (`registry.npmjs.org`) | A plain download of the package, when you run `npm install -g galyarder-framework` |
| Install from source | GitHub (`github.com`, `raw.githubusercontent.com`) | A plain clone or download, when you run `git clone` or the scaffold's template fetch |
| Install from skills.sh | The skills.sh service | A plain download of the bundles you pick, when you run `npx skills add` |
| Docs site | GitHub Pages | A plain visit, when you open the docs |

The skills, when run by an agent, may call the services they describe —
each skill says so in its own file, and the agent runs them only under
your approval. The CLI (`galyarder`) runs local scripts only: it never
sends anything anywhere on its own.

## What stays on your computer

- The skills, agents, and commands, as local files in the framework
  directory.
- What the CLI writes: the department, report, and planning structure it
  scaffolds into the project you point it at, and the mirrors it deploys
  into that project's tool directory. It writes nowhere else.
- What the sync scripts write: only into this repository (the manifest,
  the bundles, the mirrors, the docs).

## Scope

Areas where a report is especially welcome:

- A skill, agent, or command that exfiltrates data or runs hidden
  commands.
- A sync script or converter that injects content into the mirrors or
  the bundles.
- The CLI running something unexpected, or writing outside the project
  you pointed it at.
- The install scripts writing outside the places they document.
- The smoke test passing when it should fail.
