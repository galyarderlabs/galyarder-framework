# Galyarder Migration Guide: v1.7.x -> v1.8.0

Version 1.8.0 introduces a high-integrity flattening of the repository structure. The legacy `framework/` subdirectory has been removed to reduce path depth and improve tool compatibility.

## Path Mapping (Mechanical Migration)

If you have custom scripts or local references, update them according to this mapping:

| Old Path (v1.7.x) | New Path (v1.8.0) |
| :--- | :--- |
| `framework/agents/` | `[Department]/agents/` |
| `framework/skills/` | `[Department]/skills/` |
| `framework/personas/` | `Executive/personas/` |
| `personas/` | `Executive/personas/` |
| `agents/` | `[Department]/agents/` |
| `skills/` | `[Department]/skills/` |
| `.claude/marketplace.json` | `.claude-plugin/marketplace.json` |

## Migration Steps

1. **Flush Local Symlinks**:
   If using Codex or Gemini locally, remove old symlink directories:
   ```bash
   rm -rf .codex/skills .gemini/skills
   ```

2. **Re-Sync Assets**:
   Run the high-fidelity synchronization scripts:
   ```bash
   python3 scripts/sync-codex-skills.py
   python3 scripts/sync-gemini-skills.py
   ```

3. **Re-Install via Conversion Engine**:
   If using Cursor, re-run the installer to update the `.mdc` files:
   ```bash
   ./scripts/install.sh --tool cursor
   ```

4. **Update Custom Hooks**:
   If you have hooks in `hooks/hooks.json` referencing `framework/`, update them to point to the new 8-department structure.
