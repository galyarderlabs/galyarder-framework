# Multi-Platform Integration Protocol

Forge Anything is a host-agnostic logic library for agentic company execution across AI tools.

## Supported Platforms

The framework ships native plugins for these harnesses:

1.  **Claude Code**: Advanced CLI marketplace integration.
2.  **OMP/Pi (Oh My Pi)**: Native Pi extension; OMP is a fork of Pi.
3.  **OpenAI Codex**: Native plugin; Codex reads the root `skills/` directly. See [Forge Anything for Codex](README.codex.md).
4.  **Cursor**: Native plugin (portable root `plugin.json`).
5.  **Antigravity**: Native plugin.
6.  **OpenCode**: Specialized plugin ecosystem. See [Forge Anything for OpenCode](README.opencode.md).
7.  **GitHub Copilot CLI**: Native plugin (portable root `plugin.json`).
8.  **Hermes Agent**: Local-first autonomous assistant runtime. Hermes is our own agent, always a target.

Forge Agent (native identity and memory layer) and Forge HQ (command layer for goals, departments, approvals, and operating visibility) are the framework's own layers, not external harnesses.

## Official Marketplace Integration

For cloud-native orchestrators, use the standard plugin protocol:

### Claude Code & Copilot CLI
1. **Connect Marketplace**:
   ```bash
   /plugin marketplace add galyarderlabs/forge-anything
   ```
2. **Install Asset**:
   ```bash
   # Full Intelligence Bundle
   /plugin install forge-anything@galyarderlabs-marketplace

   # Selective Department (e.g., Engineering)
   /plugin install engineering-dept@galyarderlabs-marketplace
   ```

### Hermes Agent

Install Forge Anything as a Hermes plugin from this repository:

```bash
hermes plugins install galyarderlabs/forge-anything --enable
```

Restart any active Hermes sessions after installing. The plugin registers all 99 skills with Hermes' native skill loader and injects the `using-forge-anything` bootstrap on the first turn via the `pre_llm_call` hook. Note: Hermes has no post-compaction hook, so a very long session that compacts over its first turn loses the bootstrap — start a fresh session if skills stop triggering.

## Command Silo Structure (Universal Architecture)

The repository is organized into 8 departments. All assets are mapped to a flat structure that every supported harness can read:

```text
Silo/
├── agents/             # Personas + Specialized Agents
├── skills/             # Strategic SOPs + Aesthetic Design
├── commands/           # Rapid orchestration triggers
├── plugin.json         # Portable plugin manifest (Claude Code, Codex, Cursor, Copilot CLI)
├── .claude-plugin/     # Claude Code manifest
├── .codex-plugin/      # Codex manifest
├── .antigravity-plugin/ # Antigravity manifest
├── .hermes-plugin/     # Hermes manifest
└── .pi/                # Pi/OMP extension
```

## Context loading standard

Legacy context-bloat patterns have been removed so agents load only what they need. This keeps:
- **Context integrity**: lower noise and less unnecessary prompt surface.
- **Deterministic loads**: only the required instructions are loaded into the agent context.

## Conversion Engine

The Forge conversion engine generates the Forge Agent surface only. Every other harness uses its native plugin manifest, which reads the canonical `skills/`, `agents/`, and `commands/` directories directly — no generated copies.

```bash
# Generate the Forge Agent surface
forge deploy --tool forge-agent
```
