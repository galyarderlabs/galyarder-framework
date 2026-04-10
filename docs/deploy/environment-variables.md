---
title: Environment Variables
summary: Full environment variable reference
---

All environment variables that Galyarder uses for server configuration.

## Server Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `3100` | Server port |
| `HOST` | `127.0.0.1` | Server host binding |
| `DATABASE_URL` | (embedded) | PostgreSQL connection string |
| `GALYARDER_HOME` | `~/.galyarder` | Base directory for all Galyarder data |
| `GALYARDER_INSTANCE_ID` | `default` | Instance identifier (for multiple local instances) |
| `GALYARDER_DEPLOYMENT_MODE` | `local_trusted` | Runtime mode override |

## Secrets

| Variable | Default | Description |
|----------|---------|-------------|
| `GALYARDER_SECRETS_MASTER_KEY` | (from file) | 32-byte encryption key (base64/hex/raw) |
| `GALYARDER_SECRETS_MASTER_KEY_FILE` | `~/.galyarder/.../secrets/master.key` | Path to key file |
| `GALYARDER_SECRETS_STRICT_MODE` | `false` | Require secret refs for sensitive env vars |

## Agent Runtime (Injected into agent processes)

These are set automatically by the server when invoking agents:

| Variable | Description |
|----------|-------------|
| `GALYARDER_AGENT_ID` | Agent's unique ID |
| `GALYARDER_COMPANY_ID` | Company ID |
| `GALYARDER_API_URL` | Galyarder API base URL |
| `GALYARDER_API_KEY` | Short-lived JWT for API auth |
| `GALYARDER_RUN_ID` | Current heartbeat run ID |
| `GALYARDER_TASK_ID` | Issue that triggered this wake |
| `GALYARDER_WAKE_REASON` | Wake trigger reason |
| `GALYARDER_WAKE_COMMENT_ID` | Comment that triggered this wake |
| `GALYARDER_APPROVAL_ID` | Resolved approval ID |
| `GALYARDER_APPROVAL_STATUS` | Approval decision |
| `GALYARDER_LINKED_ISSUE_IDS` | Comma-separated linked issue IDs |

## LLM Provider Keys (for adapters)

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | Anthropic API key (for Claude Local adapter) |
| `OPENAI_API_KEY` | OpenAI API key (for Codex Local adapter) |
