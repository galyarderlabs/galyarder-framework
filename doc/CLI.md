# CLI Reference

Galyarder CLI now supports both:

- instance setup/diagnostics (`onboard`, `doctor`, `configure`, `env`, `allowed-hostname`)
- control-plane client operations (issues, approvals, agents, activity, dashboard)

## Base Usage

Use repo script in development:

```sh
pnpm galyarder --help
```

First-time local bootstrap + run:

```sh
pnpm galyarder run
```

Choose local instance:

```sh
pnpm galyarder run --instance dev
```

## Deployment Modes

Mode taxonomy and design intent are documented in `doc/DEPLOYMENT-MODES.md`.

Current CLI behavior:

- `galyarder onboard` and `galyarder configure --section server` set deployment mode in config
- runtime can override mode with `GALYARDER_DEPLOYMENT_MODE`
- `galyarder run` and `galyarder doctor` do not yet expose a direct `--mode` flag

Target behavior (planned) is documented in `doc/DEPLOYMENT-MODES.md` section 5.

Allow an authenticated/private hostname (for example custom Tailscale DNS):

```sh
pnpm galyarder allowed-hostname dotta-macbook-pro
```

All client commands support:

- `--data-dir <path>`
- `--api-base <url>`
- `--api-key <token>`
- `--context <path>`
- `--profile <name>`
- `--json`

Company-scoped commands also support `--company-id <id>`.

Use `--data-dir` on any CLI command to isolate all default local state (config/context/db/logs/storage/secrets) away from `~/.galyarder`:

```sh
pnpm galyarder run --data-dir ./tmp/galyarder-dev
pnpm galyarder issue list --data-dir ./tmp/galyarder-dev
```

## Context Profiles

Store local defaults in `~/.galyarder/context.json`:

```sh
pnpm galyarder context set --api-base http://localhost:3100 --company-id <company-id>
pnpm galyarder context show
pnpm galyarder context list
pnpm galyarder context use default
```

To avoid storing secrets in context, set `apiKeyEnvVarName` and keep the key in env:

```sh
pnpm galyarder context set --api-key-env-var-name GALYARDER_API_KEY
export GALYARDER_API_KEY=...
```

## Company Commands

```sh
pnpm galyarder company list
pnpm galyarder company get <company-id>
pnpm galyarder company delete <company-id-or-prefix> --yes --confirm <same-id-or-prefix>
```

Examples:

```sh
pnpm galyarder company delete PAP --yes --confirm PAP
pnpm galyarder company delete 5cbe79ee-acb3-4597-896e-7662742593cd --yes --confirm 5cbe79ee-acb3-4597-896e-7662742593cd
```

Notes:

- Deletion is server-gated by `GALYARDER_ENABLE_COMPANY_DELETION`.
- With agent authentication, company deletion is company-scoped. Use the current company ID/prefix (for example via `--company-id` or `GALYARDER_COMPANY_ID`), not another company.

## Issue Commands

```sh
pnpm galyarder issue list --company-id <company-id> [--status todo,in_progress] [--assignee-agent-id <agent-id>] [--match text]
pnpm galyarder issue get <issue-id-or-identifier>
pnpm galyarder issue create --company-id <company-id> --title "..." [--description "..."] [--status todo] [--priority high]
pnpm galyarder issue update <issue-id> [--status in_progress] [--comment "..."]
pnpm galyarder issue comment <issue-id> --body "..." [--reopen]
pnpm galyarder issue checkout <issue-id> --agent-id <agent-id> [--expected-statuses todo,backlog,blocked]
pnpm galyarder issue release <issue-id>
```

## Agent Commands

```sh
pnpm galyarder agent list --company-id <company-id>
pnpm galyarder agent get <agent-id>
pnpm galyarder agent local-cli <agent-id-or-shortname> --company-id <company-id>
```

`agent local-cli` is the quickest way to run local Claude/Codex manually as a Galyarder agent:

- creates a new long-lived agent API key
- installs missing Galyarder skills into `~/.codex/skills` and `~/.claude/skills`
- prints `export ...` lines for `GALYARDER_API_URL`, `GALYARDER_COMPANY_ID`, `GALYARDER_AGENT_ID`, and `GALYARDER_API_KEY`

Example for shortname-based local setup:

```sh
pnpm galyarder agent local-cli codexcoder --company-id <company-id>
pnpm galyarder agent local-cli claudecoder --company-id <company-id>
```

## Approval Commands

```sh
pnpm galyarder approval list --company-id <company-id> [--status pending]
pnpm galyarder approval get <approval-id>
pnpm galyarder approval create --company-id <company-id> --type hire_agent --payload '{"name":"..."}' [--issue-ids <id1,id2>]
pnpm galyarder approval approve <approval-id> [--decision-note "..."]
pnpm galyarder approval reject <approval-id> [--decision-note "..."]
pnpm galyarder approval request-revision <approval-id> [--decision-note "..."]
pnpm galyarder approval resubmit <approval-id> [--payload '{"...":"..."}']
pnpm galyarder approval comment <approval-id> --body "..."
```

## Activity Commands

```sh
pnpm galyarder activity list --company-id <company-id> [--agent-id <agent-id>] [--entity-type issue] [--entity-id <id>]
```

## Dashboard Commands

```sh
pnpm galyarder dashboard get --company-id <company-id>
```

## Heartbeat Command

`heartbeat run` now also supports context/api-key options and uses the shared client stack:

```sh
pnpm galyarder heartbeat run --agent-id <agent-id> [--api-base http://localhost:3100] [--api-key <token>]
```

## Local Storage Defaults

Default local instance root is `~/.galyarder/instances/default`:

- config: `~/.galyarder/instances/default/config.json`
- embedded db: `~/.galyarder/instances/default/db`
- logs: `~/.galyarder/instances/default/logs`
- storage: `~/.galyarder/instances/default/data/storage`
- secrets key: `~/.galyarder/instances/default/secrets/master.key`

Override base home or instance with env vars:

```sh
GALYARDER_HOME=/custom/home GALYARDER_INSTANCE_ID=dev pnpm galyarder run
```

## Storage Configuration

Configure storage provider and settings:

```sh
pnpm galyarder configure --section storage
```

Supported providers:

- `local_disk` (default; local single-user installs)
- `s3` (S3-compatible object storage)
