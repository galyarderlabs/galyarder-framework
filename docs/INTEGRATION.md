# Multi-Platform Integration Protocol

Galyarder Framework is a host-agnostic logic library for agentic company execution across AI tools.

## Supported Platforms

The framework is converted for the following environments:

1.  **Galyarder Agent**: Native identity and memory layer.
2.  **Galyarder HQ**: Command layer for goals, departments, approvals, and operating visibility.
3.  **Claude Code**: Advanced CLI marketplace integration.
4.  **Cursor**: IDE-native `.mdc` rule sets.
5.  **Gemini CLI**: Official extension repository support.
6.  **OpenAI Codex CLI**: Direct instruction-based logic.
7.  **Windsurf**: Native plugin architecture.
8.  **OpenCode**: Specialized plugin ecosystem.
9.  **Hermes Agent**: Local-first autonomous assistant runtime.
10. **OpenClaw**: Distributed agentic logic.
11. **Kilo Code**: Coding assistant integration.
12. **Augment**: Performance-optimized AI workflow.
13. **Antigravity**: System-level skill injection.

## Official Marketplace Integration

For cloud-native orchestrators, use the standard plugin protocol:

### Claude Code & Copilot CLI
1. **Connect Marketplace**:
   ```bash
   /plugin marketplace add galyarderlabs/galyarder-framework
   ```
2. **Install Asset**:
   ```bash
   # Full Intelligence Bundle
   /plugin install galyarder-framework@galyarderlabs-marketplace

   # Selective Department (e.g., Engineering)
   /plugin install engineering-dept@galyarderlabs-marketplace
   ```

### Gemini CLI
```bash
# Install
gemini extensions install https://github.com/galyarderlabs/galyarder-framework

# Life-cycle management
gemini extensions update galyarder-framework
gemini extensions uninstall galyarder-framework
```

## Command Silo Structure (Universal Architecture)

The repository is organized into 8 departments. To ensure compatibility with Google (Gemini), Anthropic (Claude), and Microsoft (Copilot), all assets are mapped to a flat tripartite structure:

```text
Silo/
├── agents/             # Personas + Specialized Agents
├── skills/             # Strategic SOPs + Aesthetic Design
├── commands/           # Rapid orchestration triggers
├── .claude-plugin/     # Claude Code manifest
└── gemini-extension.json # Gemini CLI manifest
```

## Context loading standard

Legacy context-bloat patterns have been removed so agents load only what they need. This keeps:
- **Context integrity**: lower noise and less unnecessary prompt surface.
- **Deterministic loads**: only the required instructions are loaded into the agent context.

## Conversion Engine

To maintain parity across all 14 platforms, use the Galyarder conversion engine:

```bash
# Full recursive conversion
galyarder deploy --tool all
```

