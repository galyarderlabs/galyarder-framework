# Conventions and Patterns

### Naming
- Adapter type: `snake_case` (e.g. `claude_local`, `codex_local`)
- Package name: `@forge-anything/adapter-<kebab-name>`
- Package directory: `packages/adapters/<kebab-name>/`

### Config Parsing
- Never trust `config` values directly  always use `asString`, `asNumber`, etc.
- Provide sensible defaults for every optional field
- Document all fields in `agentConfigurationDoc`

### Prompt Templates
- Support `promptTemplate` for every run
- Use `renderTemplate()` with the standard variable set
- Default prompt: `"You are agent {{agent.id}} ({{agent.name}}). Continue your Forge Anything work."`

### Error Handling
- Differentiate timeout vs process error vs parse failure
- Always populate `errorMessage` on failure
- Include raw stdout/stderr in `resultJson` when parsing fails
- Handle the agent CLI not being installed (command not found)

### Logging
- Call `onLog("stdout", ...)` and `onLog("stderr", ...)` for all process output  this feeds the real-time run viewer
- Call `onMeta(...)` before spawning to record invocation details
- Use `redactEnvForLogs()` when including env in meta

### Forge Anything Skills Injection

Forge Anything ships shared skills (in the repo's top-level `skills/` directory) that agents need at runtime  things like the `forge` API skill and the `forge-create-agent` workflow skill. Each adapter is responsible for making these skills discoverable by its agent runtime **without polluting the agent's working directory**.

**The constraint:** never copy or symlink skills into the agent's `cwd`. The cwd is the user's project checkout  writing `.claude/skills/` or any other files into it would contaminate the repo with Forge Anything internals, break git status, and potentially leak into commits.

**The pattern:** create a clean, isolated location for skills and tell the agent runtime to look there.

**How claude-local does it:**

1. At execution time, create a fresh tmpdir: `mkdtemp("forge-skills-")`
2. Inside it, create `.claude/skills/` (the directory structure Claude Code expects)
3. Symlink each skill directory from the repo's `skills/` into the tmpdir's `.claude/skills/`
4. Pass the tmpdir to Claude Code via `--add-dir <tmpdir>`  this makes Claude Code discover the skills as if they were registered in that directory, without touching the agent's actual cwd
5. Clean up the tmpdir in a `finally` block after the run completes

```ts
// From claude-local execute.ts
async function buildSkillsDir(): Promise<string> {
  const tmp = await fs.mkdtemp(path.join(os.tmpdir(), "forge-skills-"));
  const target = path.join(tmp, ".claude", "skills");
  await fs.mkdir(target, { recursive: true });
  const entries = await fs.readdir(FORGE_SKILLS_DIR, { withFileTypes: true });
  for (const entry of entries) {
    if (entry.isDirectory()) {
      await fs.symlink(
        path.join(FORGE_SKILLS_DIR, entry.name),
        path.join(target, entry.name),
      );
    }
  }
  return tmp;
}

// In execute(): pass --add-dir to Claude Code
const skillsDir = await buildSkillsDir();
args.push("--add-dir", skillsDir);
// ... run process ...
// In finally: fs.rm(skillsDir, { recursive: true, force: true })
```

**How codex-local does it:**

Codex has a global personal skills directory (`$CODEX_HOME/skills` or `~/.codex/skills`). The adapter symlinks Forge Anything skills there if they don't already exist. This is acceptable because it's the agent tool's own config directory, not the user's project.

```ts
// From codex-local execute.ts
async function ensureCodexSkillsInjected(onLog) {
  const skillsHome = path.join(codexHomeDir(), "skills");
  await fs.mkdir(skillsHome, { recursive: true });
  for (const entry of entries) {
    const target = path.join(skillsHome, entry.name);
    const existing = await fs.lstat(target).catch(() => null);
    if (existing) continue;  // Don't overwrite user's own skills
    await fs.symlink(source, target);
  }
}
```

**For a new adapter:** figure out how your agent runtime discovers skills/plugins, then choose the cleanest injection path:

1. **Best: tmpdir + flag** (like claude-local)  if the runtime supports an "additional directory" flag, create a tmpdir, symlink skills in, pass the flag, clean up after. Zero side effects.
2. **Acceptable: global config dir** (like codex-local)  if the runtime has a global skills/plugins directory separate from the project, symlink there. Skip existing entries to avoid overwriting user customizations.
3. **Acceptable: env var**  if the runtime reads a skills/plugin path from an environment variable, point it at the repo's `skills/` directory directly.
4. **Last resort: prompt injection**  if the runtime has no plugin system, include skill content in the prompt template itself. This uses tokens but avoids filesystem side effects entirely.

**Skills as loaded procedures, not prompt bloat.** The Forge Anything skills (like `forge` and `forge-create-agent`) are designed as on-demand procedures: the agent sees skill metadata (name + description) in its context, but only loads the full SKILL.md content when it decides to invoke a skill. This keeps the base prompt small. When writing `agentConfigurationDoc` or prompt templates for your adapter, do not inline skill content  let the agent runtime's skill discovery do the work. The descriptions in each SKILL.md frontmatter act as routing logic: they tell the agent when to load the full skill, not what the skill contains.

**Explicit vs. fuzzy skill invocation.** For production workflows where reliability matters (e.g. an agent that must always call the Forge Anything API to report status), use explicit instructions in the prompt template: "Use the forge skill to report your progress." Fuzzy routing (letting the model decide based on description matching) is fine for exploratory tasks but unreliable for mandatory procedures.

---
