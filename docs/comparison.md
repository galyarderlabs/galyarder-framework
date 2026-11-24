<!--
  This document is for developers evaluating the project. It is NOT a skill and
  is not meant to be loaded into an agent's context. It lives in docs/ so it
  stays out of the agent's working set.
-->

# How Forge Anything compares

People often ask how **Forge Anything** relates to the three skill collections they hear about most: **Superpowers** (Jesse Vincent / obra), **Agent Skills** (Addy Osmani), and **Matt Pocock's skills**. All four are good, share a lot of DNA, and are worth learning from. This page is an honest map of how they are *shaped* differently, so you can pick the one that fits how you work, or borrow across all four.

> **TL;DR**: The difference is kind, not size. **Forge Anything** is a whole system for AI agents: essential skills, agents, commands, hooks, a CLI, and an MCP server, for work and life, where the best standard is the default path, not an option. The other three are skill collections for engineering and software: **Superpowers** is a disciplined methodology for autonomous, reasoning-heavy runs with subagents and worktree isolation; **Agent Skills** is the full product lifecycle (Define to Ship) with review personas and an in-repo eval framework; **Matt Pocock's skills** are a sharp, opinionated Claude Code toolkit distilled from one expert's daily workflow, with a signature "grill me" interrogation loop. None is "best" in the abstract; it depends on the work in front of you.

> **A note on evidence:** this comparison is based on the four repos' own docs (READMEs, skill lists, and plugin manifests, as read in November 2026). There is no controlled head-to-head experiment for Forge Anything, and no benchmark is claimed here. Where a fact could not be verified from the docs, it is marked "not verified".

---

## At a glance

| | **Forge Anything** | **Superpowers** | **Agent Skills** | **Matt Pocock's skills** |
|---|---|---|---|---|
| **Core idea** | A whole system for AI agents: essential skills, agents, commands, hooks, CLI, and MCP, for work and life | A complete software development methodology built on composable skills | Encode the full senior-engineering lifecycle as skills | One expert's Claude Code workflow, open-sourced and evolving |
| **Organizing principle** | Ten departments behind a Goal to Ship loop | A single disciplined loop: brainstorm, plan, execute, review | SDLC phases (Define to Ship) behind a meta-skill that matches each task to a skill | A curated toolbox of focused, composable commands; grilling as the central primitive |
| **Scope** | Company and life: Executive, Product, Engineering, Creative, Growth, Security, Infrastructure, Finance, Legal, Knowledge | Software development (coding) | Product lifecycle for software (Define to Ship) | Engineering and productivity (coding plus general workflow tools) |
| **Workflow / loop** | Goal, Plan, Build, Verify, Ship; ends at distribution | Brainstorm, plan, subagent-driven execution, review; worktree isolation | Define, Plan, Build, Verify, Review, Ship; slash commands map 1:1 to phases, plus a /build auto full-plan mode | Grill to align requirements, spec or tickets, implement test-first at seams, code review; issue-tracker backed |
| **Distribution / install** | `npx skills add galyarderlabs/forge-anything`; native plugins for Claude Code, OMP/Pi, Codex, Cursor, Antigravity, OpenCode, Copilot CLI, Hermes; `forge` CLI via curl install.sh | Native plugins for Claude Code, Codex, Cursor, Antigravity, OpenCode, Pi, Hermes, Copilot CLI, Gemini CLI, Devin, Kimi, Qwen, Muse, Factory Droid, Grok, and more | `npx skills add addyosmani/agent-skills`; native plugins for Claude Code, Codex, Cursor, Antigravity, Gemini CLI, OpenCode, Copilot, Kiro, Command Code, Windsurf | Claude Code plugin first; Codex, Copilot, Gemini CLI plugins; `npx skills add` for other agents |
| **MCP server** | Yes: `forge mcp`, 5 tools, stdio, local only; install the MCP, not the skills | None mentioned in its README (skills plus hooks) | None mentioned in its README | None mentioned in its README |
| **Project scaffold** | Yes: `forge scaffold` drops a tidy repo with the curated skills, agents, and commands | No (uses git worktrees for isolation, not a project scaffold) | No (starts from a spec, not a scaffolded repo) | No (a per-repo setup skill configures an existing repo) |
| **License** | GPL-3.0-or-later | MIT | MIT | MIT |
| **Quality measurement** | Smoke test (8 checks) plus cargo tests plus CI; no in-repo skill-behavior eval framework | Skill-behavior tests via the drill eval harness from superpowers-evals (a separate repo); plugin-infrastructure tests in tests/ | Three-tier eval framework in-repo (structure, dispatch, behavioral), some in CI | None shipped in-repo |
| **Best for** | Running a whole company or life workflow with an agent, and giving any agent or chatbot the tools plus the workflow through the MCP | Long, autonomous, reasoning-heavy coding runs you hand off and review later | Driving a feature through every phase with a human checkpoint at each | A pragmatic, battle-tested daily loop, strongest at getting requirements right before code |

---

## The four projects, in their own terms

### Forge Anything (this project)

Forge Anything is a whole system for AI agents, not a skill collection. The essential skills, agents, commands, and hooks sit alongside a CLI (`forge`) and an MCP server (`forge mcp`, 5 tools), so the best standard is the default path: the work is planned, built, checked against evidence, and shipped, and the loop ends at distribution. It covers the whole company and life, organized as ten departments around a Goal to Ship loop. The MCP server gives any agent or even a regular chatbot the tools plus the workflow, the scaffold (`forge scaffold`) drops a tidy repo that already follows the workflow, and everything installs via plugin across seven harnesses plus Hermes, or via `npx skills add` for the skills alone.

The honest trade-offs: the full repo is large and still being curated down to essential only. The curation standard is the Essential Skill Registry (`docs/skill-registry.md`): best-in-class per slot value from real research, cross-industry and life, with a review of the current repo in `docs/skill-registry-review.md`. There is no in-repo skill-behavior eval framework yet, so a skill regression is caught by the smoke test and CI, not by a catalog-wide eval. The MCP and the prebuilt-binary CLI distribution are new (the first release with prebuilt binaries still needs a version tag), so that path is not yet proven by a public release. And there is no controlled head-to-head experiment behind this comparison.

**Repo:** <https://github.com/galyarderlabs/forge-anything>

### Superpowers (obra)

Superpowers treats software development as one disciplined methodology made of composable skills. A session starts with Socratic brainstorming that draws out what you actually want and writes it down as a spec, then turns the spec into a plan detailed enough for a junior engineer with no context to follow, then runs the plan through subagents where each task gets implemented by a fresh subagent and reviewed for spec compliance and code quality before it closes. Git worktrees keep parallel work apart, and the writing-skills skill tests documentation the same way code is tested.

Its strengths are real: hand off a sizable chunk and come back to a reviewed result, with strong guardrails against an agent rationalizing its way past the process, and the widest harness surface of the four. The trade-offs are the flip side of that discipline. Coverage is narrow (it is an inner-loop build methodology, not a company-wide lifecycle), the single pipeline can feel heavy on small changes, and it is largely solo-authored with a substantial backlog of unmerged community PRs.

**Repo:** <https://github.com/obra/superpowers>

### Agent Skills (Addy Osmani)

Agent Skills turns the whole product lifecycle into skills, with a meta-skill that picks the right one for each task. Every skill names the excuses an agent uses to skip steps and rebuts them, and flags the warning signs. The slash commands line up with the lifecycle phases, `/build auto` runs a whole approved plan in one pass, and `/ship` runs review personas in parallel and merges them into a go or no-go. A human checks each phase, seven reference checklists (including a Definition of Done) ship with it, and it installs on most major agent tools.

What is newest, and the current point of difference: a **three-tier eval framework** lives in the repo. Tier 1 checks structure, Tier 2 checks that each skill's description carries the vocabulary users actually say and that no two skills claim the same task (deterministic, runs in CI), and Tier 3 grades an agent's real execution trace against per-skill expectations. None of the other three ships that kind of in-repo, catalog-wide measurement today. The honest trade-off in the other direction: Agent Skills has less of a single opinionated "run" than Superpowers, no MCP server, no project scaffold, and its scope is the product lifecycle for software, not the whole company and life.

**Repo:** <https://github.com/addyosmani/agent-skills>

### Matt Pocock's skills

Matt Pocock published the Claude Code skills he uses every day, and the collection grew into a broad, opinionated toolbox that stays public about what is in progress and what is deprecated. The heart of it is grilling: an interview loop that asks one question at a time, walks the design tree branch by branch, suggests an answer for each question, reads the codebase before asking, and does not move on until you both agree on what is being built. The TDD skill is deliberately heterodox, and the repo splits skills into user-invoked (you type them) and model-invoked (the agent reaches for them) to keep agent context cheap.

Its strengths are authenticity and sharpness: this is how one very good engineer ships, not a committee's idea of a framework, and the requirements-grilling loop is genuinely excellent. The trade-offs: it is Claude Code first in practice (other agents surface reliability rough edges), there are no in-repo evals to catch regressions, lifecycle coverage past Build is thin, there is no MCP server and no project scaffold, and some skills couple to a personal setup wizard and tracker conventions.

**Repo:** <https://github.com/mattpocock/skills>

---

## How to decide what to use

The at-a-glance table tells you how they are shaped. This is how to choose in practice.

### Start with the shape of your work

- **A whole system for AI agents, not just a skill collection, or giving any chatbot the tools plus the workflow?** Forge Anything. It is the only one of the four that is a system (essential skills, agents, commands, hooks, CLI, and MCP) rather than a skill collection, and it covers work and life beyond engineering, so a regular chatbot gets the tools and the loop ends at distribution.
- **A whole feature, front to back, with a human checkpoint at each phase?** Agent Skills. It is the only one that carries you from spec through security, performance, and launch with a checkpoint at each phase, so nothing quietly skips the review or the pre-flight.
- **A big, ambiguous chunk you want to hand off and walk away from?** Superpowers. Its pipeline and subagent review are built to run for a long time and hand back a result that has already been reviewed against the spec.
- **A fast, focused daily loop, especially getting requirements right before code?** Matt Pocock's skills. The grilling loop is the sharpest requirements tool of the four, and the toolkit stays out of your way.

### Then weight what you actually care about

- **Breadth of coverage** (company departments, not just code): Forge Anything is the clear pick; the others are coding-focused.
- **Distribution to any agent or chatbot**: Forge Anything, by design (the MCP server). The others distribute skills and plugins, not a runnable MCP server.
- **A project scaffold that starts clean**: Forge Anything. The others start from a spec or an existing repo.
- **Confidence that the skills themselves work**: Agent Skills is the only one with catalog-wide evals in the repo, so a description or skill-matching regression fails CI rather than surfacing as a mysterious "why didn't the skill fire" later. Superpowers pressure-tests its skills through a separate eval repo.
- **Autonomy over a long run**: Superpowers, by design.
- **Requirements interrogation**: Pocock's grilling is the reference implementation; Forge Anything's `brainstorming` and Agent Skills' `interview-me` are close in spirit.
- **Low ceremony on small changes**: Pocock's toolkit is lightest; Forge Anything and Agent Skills offer a middle gear; Superpowers is the most process-heavy.
- **Platform spread**: Superpowers runs on the most harnesses; Forge Anything and Agent Skills both run on most major tools; Pocock is happiest on Claude Code.
- **A human gate at each step vs. a hands-off run**: Forge Anything and Agent Skills checkpoint by default; Superpowers minimizes mid-run check-ins on purpose.

### Concrete scenarios

- *"Set up a new company repo with departments, skills, and a workflow, and give my chatbot the tools to run it."* Forge Anything: `forge scaffold`, then `forge mcp`.
- *"Ship a new endpoint with auth, tests, and a security pass before merge."* Agent Skills: `/spec` to `/ship`, with the security-auditor and test-engineer personas fanning out at the end. Forge Anything also covers this through its Engineering department (`test-driven-development`, `systematic-debugging`, `requesting-code-review`).
- *"Refactor a gnarly subsystem overnight and review it in the morning."* Superpowers: hand it the plan, let subagent-driven development and the task reviewer run.
- *"I have a vague idea and keep letting the agent guess the requirements."* Pocock's `grill-me` (or Forge Anything's `brainstorming`, or Agent Skills' `interview-me`) to pin down intent before any code.
- *"Fix one clear bug, test-first."* Any of them; reach for the lightest one you already have installed.
- *"Standardize how a team uses agents across a repo."* Forge Anything (the scaffold plus departments plus the MCP) or Agent Skills (the phase commands, personas, and shared checklists give a team a common vocabulary, and the evals keep custom skills honest).
- *"Give a chatbot that has no plugin system the same workflow my coding agent has."* Forge Anything: the MCP server is the only one of the four that works for a plain chatbot.

### Solo vs. team

For a solo developer, taste and momentum win: pick the one whose defaults match how you already work, and the lowest-ceremony option is often the most-used one. For a team, the calculus shifts toward shared structure and guardrails you can enforce: named phases, review personas, checklists, and evals that fail CI are what keep five people (and their agents) converging on the same standard rather than five private workflows. That is the situation Agent Skills is built for, and Forge Anything adds the scaffold and the MCP so the standard travels to every agent and chatbot on the team.

### The shared frontier (true of all four)

None of these has solved **durable cross-session memory** well yet: what an agent learned in one session rarely carries cleanly into the next. All four are circling it (learnings files, handoff artifacts, tracker-backed planning maps). If that is your bottleneck, know that you are at the edge of what any of them ships today, and expect to stitch some of it yourself for now.

---

## Combining them

You do not have to choose exclusively, but combine with care. These are Markdown skills, not runtimes, so cherry-picking *individual* skills works well: pull in Pocock's `grill-me`, a Superpowers isolation pattern, or a specific checklist alongside your main setup.

What does not work is running two of them as your main framework at the same time. Stacked meta-skills fight over command names, compete on which skill handles a task, and pull in different TDD philosophies, so you get unpredictable behavior rather than the best of both. Pick one framework as your primary, and borrow from the others a la carte. The same applies to the MCP: if you install Forge Anything's MCP, let it be the one that serves skills and scaffolding, and do not stack a second MCP that claims the same tools.

---

## Sources

- Forge Anything: <https://github.com/galyarderlabs/forge-anything>
- Superpowers: <https://github.com/obra/superpowers>
- Agent Skills: <https://github.com/addyosmani/agent-skills>
- Matt Pocock's skills: <https://github.com/mattpocock/skills>

This comparison is based on the four repos' own docs as read in November 2026. It is not a measured experiment.

*Spotted something inaccurate about another project here? Open an issue or PR. We would rather be fair than flattering.*
