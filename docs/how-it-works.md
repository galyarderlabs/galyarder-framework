# How Forge Anything works

Forge Anything is a system, not a collection. A goal goes in, in plain words, and shipped work comes out, work that earns and gives back. This page explains the pieces and the flow, start to finish. Install is in [QUICK_START.md](QUICK_START.md); the seven phases in full are in [WORKFLOW.md](../WORKFLOW.md).

## The pieces

**Skills: how each job is done.** One skill per job, a workflow with steps and exit criteria, in `skills/<name>/SKILL.md`, with `references/` and a readme when the job is complex. Skills are grouped by department, and each one carries the operating protocols and the Forge Mark: no AI slop, flow ideas to give back, everything evidence based, output as changes, report by work done, use related skills, update the agent's memory. The method lives in the skill, nowhere else.

**Agents: who does it.** One agent per recurring job, a folder with three files. `SOUL.md` is the agent: its judgment standard (verification criteria, severity scales, approval standards, from the research), its identity, its goals, and the skills it reads to do the work. `MEMORY.md` is what it remembers: decisions, findings, outcomes, lessons, progress. `README.md` is the summary: purpose, why it exists, verification, skills. An agent reads the skills named in its soul. It never improvises a method a skill already covers, and it never grades its own work.

**Commands: when it starts.** Single `.md` files in `commands/`. Some dispatch an agent, some run a skill, some do both. Role commands (`ceo`, `cfo`, `cmo`, `cto`) speak to a lead agent; job commands (`/ship`, `/review`, `/plan`, `/tdd`, `/video`) start a piece of work. The operator starts the work with one line instead of explaining it.

**Departments: where the pieces live.** Departments group related work: Executive, Product, Engineering, Creative, Growth, Security, Infrastructure, Finance, Legal, Knowledge, Operations, Customer Success, People, Data, Trading, External Relations, Life. A department is a storage folder for skills, not a skill itself. Each one has lead agents and a folder under `docs/departments/` with its audit and report templates.

**Hooks and the bootstrap: how the agent knows the system.** Hooks, one per harness, inject the bootstrap once per session: `skills/using-forge-anything/SKILL.md`, the map. The bootstrap names the flow, the protocols, and the skills that serve each stage. The agent reads the bootstrap, not the whole repo, and the hook never fires per command. Codex is not wired yet; its hook stays suppressed until it is.

**CLI, MCP, scaffold, plugins: how the pieces reach the agent.** `forge scaffold` copies the curated skills, agents, and commands into a folder, so a project starts clean. `forge company import` brings in a company package. `forge mcp` is the MCP server (stdio, four tools: list skills, read skill, read command, scaffold) that gives any agent, or even a regular chatbot, the tools to read the system. Install the MCP, not the skills. Native plugins cover Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, and Hermes.

## The flow

One flow, five stages: Ideas, Goal, Ship, Earn, Give back. The flow closes at give back and the next cycle starts at Ideas. Plan, build, verify are the inner goal-to-ship loop, stages 2 to 3.

1. **Ideas.** A spark becomes something worth building. The operator hands over a goal in plain words.
2. **Goal.** The goal gets a plan, with the rules and the workflow that fit it.
3. **Ship.** A command starts the work and dispatches an agent. The agent reads the skills named in its soul and works the inner loop: plan it, build it, check every claim against evidence, ship it. The agent's own Verification section is its done criteria. Nothing ships unverified, and no claim counts without proof that can be checked.
4. **Earn.** The shipped work is priced, sold, and collected.
5. **Give back.** What was earned returns, in whatever form fits (skills, content, tools, time, money), so the next person has hope to start and the next cycle starts at Ideas.

Through the whole flow, output lands as changes: a commit, a PR, or notes in the department, never a draft that stops halfway. The agent reports by work done and updates its memory with what was decided and what was learned.

## Where things live

```
skills/<name>/SKILL.md        how each job is done
agents/<name>/                who does it (README.md + SOUL.md + MEMORY.md)
commands/<name>.md            when it starts
docs/departments/<Dept>/      department notes, audits, reports
crates/forge                  the CLI and the MCP server
.opencode/, .pi/, .claude-plugin/, ...   harness plugins and hooks
```

## Learn more

- [WORKFLOW.md](../WORKFLOW.md): the seven phases in full (Goal, Plan, Build, Verify, Ship, Earn, Give back)
- [QUICK_START.md](QUICK_START.md): install and first run
- [Departments](departments/): what each department owns
- [Agents](../agents/): the agents that do the work
- [Skills](../skills/): the full skill list
- [Commands](../commands/): the shortcuts
- [INTEGRATION.md](INTEGRATION.md): the harnesses and how the MCP reaches them
- [comparison.md](comparison.md): how Forge Anything differs from Superpowers, Agent Skills, and Matt Pocock's skills
- [PRD.md](PRD.md): the requirements and the open questions
