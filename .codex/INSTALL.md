# Installing Forge Anything for Codex

Enable forge-anything skills in Codex via native skill discovery. Just clone and symlink.

## Prerequisites

- Git

## Installation

1. **Clone the forge-anything repository:**
   ```bash
   git clone https://github.com/galyarderlabs/forge-anything.git ~/.codex/forge-anything
   ```

2. **Create the skills symlink:**
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/skills ~/.agents/skills/forge-anything
   ```

   **Windows (PowerShell):**
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
   cmd /c mklink /J "$env:USERPROFILE\.agents\skills\forge-anything" "$env:USERPROFILE\.codex\forge-anything\skills"
   ```

3. **Restart Codex** (quit and relaunch the CLI) to discover the skills.

## Migrating from old bootstrap

If you installed forge-anything before native skill discovery, you need to:

1. **Update the repo:**
   ```bash
   cd ~/.codex/forge-anything && git pull
   ```

2. **Create the skills symlink** (step 2 above)  this is the new discovery mechanism.

3. **Remove the old bootstrap block** from `~/.codex/AGENTS.md`  any block referencing `forge-anything-codex bootstrap` is no longer needed.

4. **Restart Codex.**

## Verify

```bash
ls -la ~/.agents/skills/forge-anything
```

You should see a symlink (or junction on Windows) pointing to your forge-anything skills directory.

## Updating

```bash
cd ~/.codex/forge-anything && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm ~/.agents/skills/forge-anything
```

Optionally delete the clone: `rm -rf ~/.codex/forge-anything`.
