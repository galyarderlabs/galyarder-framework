---
name: skill-factory
description: Use when making a new skill, distributing a skill to other agents, or finding the right skill for a job, covering making, distributing, and discovering as three distinct values.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Skill Factory

You are the Skill Factory for Forge Anything, owned by forge-specialist. Your job covers the whole life of a skill in three distinct values: making it, distributing it, and discovering it. A skill that is well written but never distributed helps one agent. A skill that is distributed but never discoverable helps nobody. All three are the factory's job.

This skill is PARTIAL in the Forge repo. The repo already has `writing-skills`, which covers writing, editing, and verifying a single skill file. This design does not replace it. It covers what `writing-skills` does not: the full make loop with evals, the distribution step that puts the skill where other agents can install it, and the discovery step that lets an agent find it when it needs it. When the work is only writing one skill file, use `writing-skills`. When the work is the factory, use this skill.

## When to Use

- A new skill is needed and must be made, tested, and shipped, not just drafted
- A skill exists in one place and must reach other agents, harnesses, or repos
- An agent needs a skill for a job and must find the best existing one instead of writing a new one
- A skill's description must be tuned so it triggers when it should and stays quiet when it should not

Do not use this to write a single skill file with no distribution or discovery need. That is `writing-skills`.

## The Three Values

### 1. Making: draft, test, iterate

Making follows a loop, not a single write.

**Capture intent first.** Before writing, settle four answers, extracted from the conversation history where they already exist: what the skill should enable, when it should trigger, what its expected output format is, and whether test cases are worth setting up. Skills with objectively verifiable outputs (file transforms, data extraction, fixed workflow steps) benefit from test cases. Skills with subjective outputs (writing style, art) often do not.

**Interview and research.** Ask about edge cases, input and output formats, example files, success criteria, and dependencies. Check what already exists before writing anything new. A skill that duplicates a kept skill is a candidate for deletion, not a new file.

**Write the draft.** A skill is a folder with a SKILL.md carrying a name and a description in YAML frontmatter, then plain instructions in the body. The description is the primary triggering mechanism: it carries both what the skill does and the specific contexts when it applies. Write descriptions a little pushy, because agents undertrigger. Name the trigger phrases explicitly.

**Anatomy.** Keep SKILL.md under 500 lines. Past that, split the long content into bundled resources and point at them from the body:

```
skill-name/
├── SKILL.md (required)
├── scripts/    - executable code for deterministic, repetitive tasks
├── references/ - docs loaded into context only as needed
└── assets/     - files used in output (templates, icons, fonts)
```

Loading is progressive: metadata always in context, the SKILL.md body only when the skill triggers, bundled resources only on demand. A skill costs almost nothing until the moment it is needed.

**Test with real prompts.** Write 2 to 3 realistic test prompts, the kind a real user would actually say, and run the skill on them. Save the prompts first, draft assertions while the runs happen, then show the results and the quantitative metrics to the operator. Rewrite the skill from the feedback, both the qualitative judgement and the benchmark numbers. Repeat until satisfied, then expand the test set and try again at larger scale. A skill that was never run against a real prompt is a draft, not a skill.

**Tune the description last.** After the skill works, run the description improver to optimize triggering accuracy. A good skill with a bad description never fires.

### 2. Distributing: one source, every harness

Distribution means the skill reaches agents without hand copying. One source folder is the truth. From it, the skill ships through the paths Forge already supports: the scaffold for new repos, the harness plugins (Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, Hermes), and the MCP tools that read skills. No manual install step, no script the operator must run by hand.

Rules for distribution:

- The skill folder is self contained. No dependency on another skill's files.
- Scripts use the standard library only, CLI first, JSON plus human readable output.
- The manifest or registry entry is regenerated after any add, remove, or rename, so every platform surface stays in sync.
- Version the skill. A distributed skill that changes silently breaks every agent that installed it.

### 3. Discovering: findable beats plentiful

Discovery means an agent with a job can find the right skill before it writes a new one. A directory lists each skill with its upstream repository, its real SKILL.md, its category, and its recent activity scoped to that skill's own path, never a vanity install count. Each listing carries the install command its source supports, and a ranking method that says how listings are assessed.

When an agent needs a capability, the discovery order is: search the directory and the repo first, read the matching SKILL.md, and only write a new skill when nothing fits. A new skill written without that search is rework waiting to happen.

## Output

- A new skill folder: SKILL.md plus scripts, references, and assets as needed, with test prompts and eval results
- A distribution record: where the skill ships (scaffold, plugins, MCP) and its version
- A discovery entry: category, description, upstream link, and install command
- A report by work: skills made, skills distributed, skills found and reused instead of written

## Verification

- The new skill passes a structure test: frontmatter present, name matches the directory, body under the line limit, references resolve
- The skill was run against 2 to 3 realistic test prompts and the results were judged by the operator
- The skill can be found through discovery: a search for its capability returns it
- The distributed copy matches the source folder, with no drift between them
- No duplicate of an existing kept skill was created

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow ideas to give back, everything evidence based, output as changes. A skill is not done at the draft. It is done when it is tested, distributed, and discoverable, and ship means a commit, a PR, or a registry entry, not a file sitting in one folder. Report by work: skills made, distributed, and discovered. Use the related skills when the work touches them, and update the agent's memory with the skills created and the gaps found so the same capability is not built twice.

## Related Skills

- `writing-skills` - writing, editing, and verifying a single skill file (the making half this skill builds on)
- `memory-engineering` - the memory rules a new skill must respect when it touches agent memory
- `mcp-builder` - building the MCP server that can distribute and serve skills
- `verification-before-completion` - proving a skill works before it counts as done

## Research source

Anthropic skill-creator, https://github.com/anthropics/skills/tree/main/skills; Vercel find-skills (AgenticSkills directory), https://agenticskills.io/skills
