# Installing Forge Anything for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed

## Installation

Add forge-anything to the `plugin` array in your `opencode.json` (global or project-level):

```json
{
  "plugin": ["forge-anything@git+https://github.com/galyarderlabs/forge-anything.git"]
}
```

Restart OpenCode. That's it  the plugin auto-installs and registers all skills.

Verify by asking: "Tell me about your forge-anything"

## Usage

Use OpenCode's native `skill` tool:

```
use skill tool to list skills
use skill tool to load brainstorming
```

## Updating

Forge Anything updates automatically when you restart OpenCode.

To pin a specific version:

```json
{
  "plugin": ["forge-anything@git+https://github.com/galyarderlabs/forge-anything.git#v5.0.3"]
}
```

## Troubleshooting

### Plugin not loading

1. Check logs: `opencode run --print-logs "hello" 2>&1 | grep -i forge-anything`
2. Verify the plugin line in your `opencode.json`
3. Make sure you're running a recent version of OpenCode

### Skills not found

1. Use `skill` tool to list what's discovered
2. Check that the plugin is loading (see above)

### Tool mapping

When skills reference Claude Code tools:
- `TodoWrite`  `todowrite`
- `Task` with subagents  `@mention` syntax
- `Skill` tool  OpenCode's native `skill` tool
- File operations  your native tools

## Getting Help

- Report issues: https://github.com/galyarderlabs/issues
- Full documentation: https://github.com/galyarderlabs/forge-anything/blob/main/docs/INTEGRATION.md
