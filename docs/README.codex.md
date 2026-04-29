# Galyarder Framework for Codex

Guide for using Galyarder Framework with OpenAI Codex via native skill discovery.

## Quick Install

Tell Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/galyarderlabs/refs/heads/main/.codex/INSTALL.md
```

## Manual Installation

### Prerequisites

- OpenAI Codex CLI
- Git

### Steps

1. Clone the repo:
   ```bash
   git clone https://github.com/galyarderlabs/galyarder-framework.git ~/.codex/galyarder-framework
   ```

2. Create the skills symlink:
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/skills ~/.agents/skills/galyarder-framework
   ```

3. Restart Codex.

4. **For subagent skills** (optional): Skills like `dispatching-parallel-agents` and `subagent-driven-development` require Codex's multi-agent feature. Add to your Codex config:
   ```toml
   [features]
   multi_agent = true
   ```

### Windows

Use a junction instead of a symlink (works without Developer Mode):

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\galyarder-framework" "$env:USERPROFILE\.codex\galyarder-framework\skills"
```

## How It Works

Codex has native skill discovery  it scans `~/.agents/skills/` at startup, parses SKILL.md frontmatter, and loads skills on demand. Galyarder Framework skills are made visible through a single symlink:

```
~/.agents/skills/  ~/.codex/skills/
```

The `using-galyarder-framework` skill is discovered automatically and enforces skill usage discipline  no additional configuration needed.

## Usage

Skills are discovered automatically. Codex activates them when:
- You mention a skill by name (e.g., "use brainstorming")
- The task matches a skill's description
- The `using-galyarder-framework` skill directs Codex to use one

## Subagents and Agent Roles

Codex and Galyarder Framework work together in two layers:

- `skills/` are discovered natively by Codex
- `agents/*.md` are role definitions, not a native Codex agent registry

When a skill says to dispatch a named agent such as
`galyarder-framework:code-reviewer`, read that as a cross-platform workflow
instruction:

1. On hosts with named agent dispatch, use the named agent directly.
2. On Codex, read the relevant `agents/*.md` file or local prompt template.
3. Spawn a native Codex subagent with those instructions using `spawn_agent`.

In other words: Codex runs native subagents, while Galyarder Framework supplies the role
prompt those subagents should follow.

This adaptation layer translates runtime mechanics only. It does not weaken or
rewrite the framework's core agent constitution. The strict workflow,
expectations, and foundations defined in `agents/*.md` remain authoritative; the
Codex adapter is responsible only for mapping those roles onto Codex-native
subagent capabilities.

For the exact Codex mapping, see
[`skills/using-references/codex-tools.md`](skills/using-galyarder-framework/references/codex-tools.md).

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

The `description` field is how Codex decides when to activate a skill automatically  write it as a clear trigger condition.

## Updating

```bash
cd ~/.codex/galyarder-framework && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm ~/.agents/skills/galyarder-framework
```

**Windows (PowerShell):**
```powershell
Remove-Item "$env:USERPROFILE\.agents\skills\galyarder-framework"
```

Optionally delete the clone: `rm -rf ~/.codex/galyarder-framework` (Windows: `Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\galyarder-framework"`).

## Troubleshooting

### Skills not showing up

1. Verify the symlink: `ls -la ~/.agents/skills/galyarder-framework`
2. Check skills exist: `ls ~/.codex/skills`
3. Restart Codex  skills are discovered at startup

### Windows junction issues

Junctions normally work without special permissions. If creation fails, try running PowerShell as administrator.

## Getting Help

- Report issues: https://github.com/galyarderlabs/issues
- Main documentation: https://github.com/galyarderlabs/galyarder-framework
