---
title: Setup Commands
summary: Onboard, run, doctor, and configure
---

Instance setup and diagnostics commands.

## `galyarder run`

One-command bootstrap and start:

```sh
pnpm galyarder run
```

Does:

1. Auto-onboards if config is missing
2. Runs `galyarder doctor` with repair enabled
3. Starts the server when checks pass

Choose a specific instance:

```sh
pnpm galyarder run --instance dev
```

## `galyarder onboard`

Interactive first-time setup:

```sh
pnpm galyarder onboard
```

If Galyarder is already configured, rerunning `onboard` keeps the existing config in place. Use `galyarder configure` to change settings on an existing install.

First prompt:

1. `Quickstart` (recommended): local defaults (embedded database, no LLM provider, local disk storage, default secrets)
2. `Advanced setup`: full interactive configuration

Start immediately after onboarding:

```sh
pnpm galyarder onboard --run
```

Non-interactive defaults + immediate start (opens browser on server listen):

```sh
pnpm galyarder onboard --yes
```

On an existing install, `--yes` now preserves the current config and just starts Galyarder with that setup.

## `galyarder doctor`

Health checks with optional auto-repair:

```sh
pnpm galyarder doctor
pnpm galyarder doctor --repair
```

Validates:

- Server configuration
- Database connectivity
- Secrets adapter configuration
- Storage configuration
- Missing key files

## `galyarder configure`

Update configuration sections:

```sh
pnpm galyarder configure --section server
pnpm galyarder configure --section secrets
pnpm galyarder configure --section storage
```

## `galyarder env`

Show resolved environment configuration:

```sh
pnpm galyarder env
```

## `galyarder allowed-hostname`

Allow a private hostname for authenticated/private mode:

```sh
pnpm galyarder allowed-hostname my-tailscale-host
```

## Local Storage Paths

| Data | Default Path |
|------|-------------|
| Config | `~/.galyarder/instances/default/config.json` |
| Database | `~/.galyarder/instances/default/db` |
| Logs | `~/.galyarder/instances/default/logs` |
| Storage | `~/.galyarder/instances/default/data/storage` |
| Secrets key | `~/.galyarder/instances/default/secrets/master.key` |

Override with:

```sh
GALYARDER_HOME=/custom/home GALYARDER_INSTANCE_ID=dev pnpm galyarder run
```

Or pass `--data-dir` directly on any command:

```sh
pnpm galyarder run --data-dir ./tmp/galyarder-dev
pnpm galyarder doctor --data-dir ./tmp/galyarder-dev
```
