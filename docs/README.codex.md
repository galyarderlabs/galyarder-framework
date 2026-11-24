# Forge Anything for Codex

Guide for using Forge Anything with OpenAI Codex via its native plugin.

## Install

Codex loads Forge Anything through its native plugin manifest
(`.codex-plugin/plugin.json`). The plugin reads the root `skills/`
directly — no clone or symlink is needed. The plugin also registers
the Forge Anything MCP server (`forge mcp`), which runs locally over
stdio.

See [Multi-Platform Integration Protocol](INTEGRATION.md) for the
supported platforms.

### Subagent skills (optional)

Skills like `dispatching-parallel-agents` and
`subagent-driven-development` require Codex's multi-agent feature. Add
to your Codex config (`~/.codex/config.toml`):

```toml
[features]
multi_agent = true
```

## How It Works

Codex has native skill discovery — it reads the plugin's `skills/` at
startup, parses SKILL.md frontmatter, and loads skills on demand.
The `using-forge-anything` skill is discovered automatically and enforces skill usage discipline — no additional configuration needed.

## Usage

Skills are discovered automatically. Codex activates them when:
- You mention a skill by name (e.g., "use brainstorming")
- The task matches a skill's description
- The `using-forge-anything` skill directs Codex to use one

## Subagents and Agent Roles

Codex and Forge Anything work together in two layers:

- `skills/` are discovered natively by Codex
- `agents/*.md` are role definitions, not a native Codex agent registry

When a skill says to dispatch a named agent such as
`forge-anything:code-reviewer`, read that as a cross-platform workflow
instruction:

1. On hosts with named agent dispatch, use the named agent directly.
2. On Codex, read the relevant `agents/*.md` file or local prompt template.
3. Spawn a native Codex subagent with those instructions using `spawn_agent`.

In other words: Codex runs native subagents, while Forge Anything supplies the role
prompt those subagents should follow.

This adaptation layer translates runtime mechanics only. It does not weaken or
rewrite the framework's core agent constitution. The strict workflow,
expectations, and foundations defined in `agents/*.md` remain authoritative; the
Codex adapter is responsible only for mapping those roles onto Codex-native
subagent capabilities.

For the exact Codex mapping, see
[`skills/using-forge-anything/references/codex-tools.md`](../skills/using-forge-anything/references/codex-tools.md).

### Personal Skills

Create your own skills in `~/.agents/skills/`:

```bash
mkdir -p ~/.agents/skills/my-skill
```

Create `~/.agents/skills/my-skill/SKILL.md`:

```markdown
name: my-skill
description: Use when [condition] - [what it does]

# My Skill

[Your skill content here]
```

The `description` field is how Codex decides when to activate a skill automatically — write it as a clear trigger condition.

## Updating

Update the Forge Anything plugin through Codex's plugin management.
Skills are read directly from `skills/`, so updates apply on the next
Codex start.

## Uninstalling

Remove the Forge Anything plugin from Codex.

## Troubleshooting

### Skills not showing up

1. Verify the Forge Anything plugin is installed and enabled in Codex.
2. Restart Codex — skills are discovered at startup.

## Getting Help

- Report issues: https://github.com/galyarderlabs/forge-anything/issues
- Main documentation: https://github.com/galyarderlabs/forge-anything
