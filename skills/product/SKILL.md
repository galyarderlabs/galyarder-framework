---
name: product
description: "Consolidated Forge Anything Product intelligence bundle."
---

# FORGE PRODUCT BUNDLE

This bundle contains 8 high-integrity SOPs for the Product department.


---
## SKILL: company-creator
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Company Creator

Create agent company packages that conform to the Agent Companies specification.

Spec references:

- Normative spec: `references/companies-spec.md` (read this before generating files)
- Web spec: https://agentcompanies.io/specification
- Protocol site: https://agentcompanies.io/

## Two Modes

### Mode 1: Company From Scratch

The user describes what they want. Interview them to flesh out the vision, then generate the package.

### Mode 2: Company From a Repo

The user provides a git repo URL, local path, or tweet. Analyze the repo, then create a company that wraps it.

See [references/from-repo-guide.md](references/from-repo-guide.md) for detailed repo analysis steps.

## Process

### Step 1: Gather Context

Determine which mode applies:

- **From scratch**: What kind of company or team? What domain? What should the agents do?
- **From repo**: Clone/read the repo. Scan for existing skills, agent configs, README, source structure.

### Step 2: Interview (Use AskUserQuestion)

Do not skip this step. Use AskUserQuestion to align with the user before writing any files.

**For from-scratch companies**, ask about:

- Company purpose and domain (1-2 sentences is fine)
- What agents they need - propose a hiring plan based on what they described
- Whether this is a full company (needs a CEO) or a team/department (no CEO required)
- Any specific skills the agents should have
- How work flows through the organization (see "Workflow" below)
- Whether they want projects and starter tasks

**For from-repo companies**, present your analysis and ask:

- Confirm the agents you plan to create and their roles
- Whether to reference or vendor any discovered skills (default: reference)
- Any additional agents or skills beyond what the repo provides
- Company name and any customization
- Confirm the workflow you inferred from the repo (see "Workflow" below)

**Workflow  how does work move through this company?**

A company is not just a list of agents with skills. It's an organization that takes ideas and turns them into work products. You need to understand the workflow so each agent knows:

- Who gives them work and in what form (a task, a branch, a question, a review request)
- What they do with it
- Who they hand off to when they're done, and what that handoff looks like
- What "done" means for their role

**Not every company is a pipeline.** Infer the right workflow pattern from context:

- **Pipeline**  sequential stages, each agent hands off to the next. Use when the repo/domain has a clear linear process (e.g. plan  build  review  ship  QA, or content ideation  draft  edit  publish).
- **Hub-and-spoke**  a manager delegates to specialists who report back independently. Use when agents do different kinds of work that don't feed into each other (e.g. a CEO who dispatches to a researcher, a marketer, and an analyst).
- **Collaborative**  agents work together on the same things as peers. Use for small teams where everyone contributes to the same output (e.g. a design studio, a brainstorming team).
- **On-demand**  agents are summoned as needed with no fixed flow. Use when agents are more like a toolbox of specialists the user calls directly.

For from-scratch companies, propose a workflow pattern based on what they described and ask if it fits.

For from-repo companies, infer the pattern from the repo's structure. If skills have a clear sequential dependency (like `plan-ceo-review  plan-eng-review  review  ship  qa`), that's a pipeline. If skills are independent capabilities, it's more likely hub-and-spoke or on-demand. State your inference in the interview so the user can confirm or adjust.

**Key interviewing principles:**

- Propose a concrete hiring plan. Don't ask open-ended "what agents do you want?" - suggest specific agents based on context and let the user adjust.
- Keep it lean. Most users are new to agent companies. A few agents (3-5) is typical for a startup. Don't suggest 10+ agents unless the scope demands it.
- From-scratch companies should start with a CEO who manages everyone. Teams/departments don't need one.
- Ask 2-3 focused questions per round, not 10.

### Step 3: Read the Spec

Before generating any files, read the normative spec:

```
references/companies-spec.md
```

Also read the quick reference: [references/companies-spec.md](references/companies-spec.md)

And the example: [references/example-company.md](references/example-company.md)

### Step 4: Generate the Package

Create the directory structure and all files. Follow the spec's conventions exactly.

**Directory structure:**

```
<company-slug>/
 COMPANY.md
 agents/
    <slug>/AGENTS.md
 teams/
    <slug>/TEAM.md        (if teams are needed)
 projects/
    <slug>/PROJECT.md     (if projects are needed)
 tasks/
    <slug>/TASK.md        (if tasks are needed)
 skills/
    <slug>/SKILL.md       (if custom skills are needed)
 .forge.yaml            (Forge Anything vendor extension)
```

**Rules:**

- Slugs must be URL-safe, lowercase, hyphenated
- COMPANY.md gets `schema: agentcompanies/v1` - other files inherit it
- Agent instructions go in the AGENTS.md body, not in .forge.yaml
- Skills referenced by shortname in AGENTS.md resolve to `skills/<shortname>/SKILL.md`
- For external skills, use `sources` with `usage: referenced` (see spec section 12)
- Do not export secrets, machine-local paths, or database IDs
- Omit empty/default fields
- For companies generated from a repo, add a references footer at the bottom of COMPANY.md body:
  `Generated from [repo-name](repo-url) with the company-creator skill from [Forge Anything](https://github.com/galyarderlabs/forge-anything)`

**Reporting structure:**

- Every agent except the CEO should have `reportsTo` set to their manager's slug
- The CEO has `reportsTo: null`
- For teams without a CEO, the top-level agent has `reportsTo: null`

**Writing workflow-aware agent instructions:**

Each AGENTS.md body should include not just what the agent does, but how they fit into the organization's workflow. Include:

1. **Where work comes from**  "You receive feature ideas from the user" or "You pick up tasks assigned to you by the CTO"
2. **What you produce**  "You produce a technical plan with architecture diagrams" or "You produce a reviewed, approved branch ready for shipping"
3. **Who you hand off to**  "When your plan is locked, hand off to the Staff Engineer for implementation" or "When review passes, hand off to the Release Engineer to ship"
4. **What triggers you**  "You are activated when a new feature idea needs product-level thinking" or "You are activated when a branch is ready for pre-landing review"

This turns a collection of agents into an organization that actually works together. Without workflow context, agents operate in isolation  they do their job but don't know what happens before or after them.

### Step 5: Confirm Output Location

Ask the user where to write the package. Common options:

- A subdirectory in the current repo
- A new directory the user specifies
- The current directory (if it's empty or they confirm)

### Step 6: Write README.md and LICENSE

**README.md**  every company package gets a README. It should be a nice, readable introduction that someone browsing GitHub would appreciate. Include:

- Company name and what it does
- The workflow / how the company operates
- Org chart as a markdown list or table showing agents, titles, reporting structure, and skills
- Brief description of each agent's role
- Citations and references: link to the source repo (if from-repo), link to the Agent Companies spec (https://agentcompanies.io/specification), and link to Forge Anything (https://github.com/galyarderlabs/forge-anything)
- A "Getting Started" section explaining how to import: `forge company import --from <path> [dir]`, which copies the package into `company/<slug>/` inside the target directory (no dir means the current directory). Add `--force` to overwrite an existing import.

**LICENSE**  include a LICENSE file. The copyright holder is the user creating the company, not the upstream repo author (they made the skills, the user is making the company). Use the same license type as the source repo (if from-repo) or ask the user (if from-scratch). Default to MIT if unclear.

### Step 7: Write Files and Summarize

Write all files, then give a brief summary:

- Company name and what it does
- Agent roster with roles and reporting structure
- Skills (custom + referenced)
- Projects and tasks if any
- The output path

## .forge.yaml Guidelines

The `.forge.yaml` file is the Forge Anything vendor extension. It configures adapters and env inputs per agent.

### Adapter Rules

**Do not specify an adapter unless the repo or user context warrants it.** If you don't know what adapter the user wants, omit the adapter block entirely  Forge Anything will use its default. Specifying an unknown adapter type causes an import error.

Forge Anything's supported adapter types (these are the ONLY valid values):
- `claude_local`  Claude Code CLI
- `codex_local`  Codex CLI
- `opencode_local`  OpenCode CLI
- `pi_local`  Pi CLI
- `cursor`  Cursor
- `openclaw_gateway`  OpenClaw gateway

Only set an adapter when:
- The repo or its skills clearly target a specific runtime (e.g. gstack is built for Claude Code, so `claude_local` is appropriate)
- The user explicitly requests a specific adapter
- The agent's role requires a specific runtime capability

### Env Inputs Rules

**Do not add boilerplate env variables.** Only add env inputs that the agent actually needs based on its skills or role:
- `GH_TOKEN` for agents that push code, create PRs, or interact with GitHub
- API keys only when a skill explicitly requires them
- Never set `ANTHROPIC_API_KEY` as a default empty env variable  the runtime handles this

Example with adapter (only when warranted):
```yaml
schema: forge/v1
agents:
  release-engineer:
    adapter:
      type: claude_local
      config:
        model: claude-sonnet-4-6
    inputs:
      env:
        GH_TOKEN:
          kind: secret
          requirement: optional
```

Example  only agents with actual overrides appear:
```yaml
schema: forge/v1
agents:
  release-engineer:
    inputs:
      env:
        GH_TOKEN:
          kind: secret
          requirement: optional
```

In this example, only `release-engineer` appears because it needs `GH_TOKEN`. The other agents (ceo, cto, etc.) have no overrides, so they are omitted entirely from `.forge.yaml`.

## External Skill References

When referencing skills from a GitHub repo, always use the references pattern:

```yaml
metadata:
  sources:
    - kind: github-file
      repo: owner/repo
      path: path/to/SKILL.md
      commit: <full SHA from git ls-remote or the repo>
      attribution: Owner or Org Name
      license: <from the repo's LICENSE>
      usage: referenced
```

Get the commit SHA with:

```bash
git ls-remote https://github.com/owner/repo HEAD
```

Do NOT copy external skill content into the package unless the user explicitly asks.

---
## SKILL: executing-plans
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Executing Plans

You are the Executing Plans Specialist at Galyarder Labs.
## Overview

Load plan, review critically, execute all tasks, report when complete.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Note:** Tell your human partner that Forge Anything works much better with access to subagents. The quality of its work will be significantly higher if run on a platform with subagent support (such as Claude Code or Codex). If subagents are available, use forge-anything:subagent-driven-development instead of this skill.

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Tasks

For each task:
1. Mark as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed

### Step 3: Complete Development

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use forge-anything:finishing-a-development-branch
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit user consent

## Integration

**Required workflow skills:**
- **forge-anything:using-git-worktrees** - REQUIRED: Set up isolated workspace before starting
- **forge-anything:writing-plans** - Creates the plan this skill executes
- **forge-anything:finishing-a-development-branch** - Complete development after all tasks

---
 2026 Galyarder Labs. Forge Anything.

---
## SKILL: ubiquitous-language
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Ubiquitous Language

You are the Ubiquitous Language Specialist at Galyarder Labs.
Extract and formalize domain terminology from the current conversation into a consistent glossary, saved to a local file.

## Process

1. **Scan the conversation** for domain-relevant nouns, verbs, and concepts
2. **Identify problems**:
   - Same word used for different concepts (ambiguity)
   - Different words used for the same concept (synonyms)
   - Vague or overloaded terms
3. **Propose a canonical glossary** with opinionated term choices
4. **Write to `UBIQUITOUS_LANGUAGE.md`** in the working directory using the format below
5. **Output a summary** inline in the conversation

## Output Format

Write a `UBIQUITOUS_LANGUAGE.md` file with this structure:

```md
# Ubiquitous Language

## Order lifecycle

| Term | Definition | Aliases to avoid |
|------|-----------|-----------------|
| **Order** | A customer's request to purchase one or more items | Purchase, transaction |
| **Invoice** | A request for payment sent to a customer after delivery | Bill, payment request |

## People

| Term | Definition | Aliases to avoid |
|------|-----------|-----------------|
| **Customer** | A person or organization that places orders | Client, buyer, account |
| **User** | An authentication identity in the system | Login, account |

## Relationships

- An **Invoice** belongs to exactly one **Customer**
- An **Order** produces one or more **Invoices**

## Example dialogue

> **Dev:** "When a **Customer** places an **Order**, do we create the **Invoice** immediately?"
> **Domain expert:** "No  an **Invoice** is only generated once a **Fulfillment** is confirmed. A single **Order** can produce multiple **Invoices** if items ship in separate **Shipments**."
> **Dev:** "So if a **Shipment** is cancelled before dispatch, no **Invoice** exists for it?"
> **Domain expert:** "Exactly. The **Invoice** lifecycle is tied to the **Fulfillment**, not the **Order**."

## Flagged ambiguities

- "account" was used to mean both **Customer** and **User**  these are distinct concepts: a **Customer** places orders, while a **User** is an authentication identity that may or may not represent a **Customer**.
```

## Rules

- **Be opinionated.** When multiple words exist for the same concept, pick the best one and list the others as aliases to avoid.
- **Flag conflicts explicitly.** If a term is used ambiguously in the conversation, call it out in the "Flagged ambiguities" section with a clear recommendation.
- **Keep definitions tight.** One sentence max. Define what it IS, not what it does.
- **Show relationships.** Use bold term names and express cardinality where obvious.
- **Only include domain terms.** Skip generic programming concepts (array, function, endpoint) unless they have domain-specific meaning.
- **Group terms into multiple tables** when natural clusters emerge (e.g. by subdomain, lifecycle, or actor). Each group gets its own heading and table. If all terms belong to a single cohesive domain, one table is fine  don't force groupings.
- **Write an example dialogue.** A short conversation (3-5 exchanges) between a dev and a domain expert that demonstrates how the terms interact naturally. The dialogue should clarify boundaries between related concepts and show terms being used precisely.

## Re-running

When invoked again in the same conversation:

1. Read the existing `UBIQUITOUS_LANGUAGE.md`
2. Incorporate any new terms from subsequent discussion
3. Update definitions if understanding has evolved
4. Mark changed entries with "(updated)" and new entries with "(new)"
5. Re-flag any new ambiguities
6. Rewrite the example dialogue to incorporate new terms

## Post-output instruction

After writing the file, state:

> I've written/updated `UBIQUITOUS_LANGUAGE.md`. From this point forward I will use these terms consistently. If I drift from this language or you notice a term that should be added, let me know.

---
 2026 Galyarder Labs. Forge Anything.

---
## SKILL: writing-plans
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Writing Plans

You are the Writing Plans Specialist at Galyarder Labs.
## Overview

Write comprehensive implementation plans assuming the engineer has zero context for our codebase and questionable taste. Document everything they need to know: which files to touch for each task, code, testing, docs they might need to check, how to test it. Give them the whole plan as bite-sized tasks. DRY. YAGNI. TDD. Frequent commits.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. Assume they don't know good test design very well.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Context:** This should be run in a dedicated worktree (created by brainstorming skill).

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`
- (User preferences for plan location override this default)

## Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans  one per subsystem. Each plan should produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. If the codebase uses large files, don't unilaterally restructure - but if a file you're modifying has grown unwieldy, including a split in the plan is reasonable.

This structure informs the task decomposition. Each task should produce self-contained changes that make sense independently.

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make the test pass" - step
- "Run the tests and make sure they pass" - step
- "Commit" - step

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use forge-anything:subagent-driven-development (recommended) or forge-anything:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

## Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

- [ ] **Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

- [ ] **Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

- [ ] **Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```
````

## No Placeholders

Every step must contain the actual content an engineer needs. These are **plan failures**  never write them:
- "TBD", "TODO", "implement later", "fill in details"
- "Add appropriate error handling" / "add validation" / "handle edge cases"
- "Write tests for the above" (without actual test code)
- "Similar to Task N" (repeat the code  the engineer may be reading tasks out of order)
- Steps that describe what to do without showing how (code blocks required for code steps)
- References to types, functions, or methods not defined in any task

## Remember
- Exact file paths always
- Complete code in every step  if a step changes code, show the code
- Exact commands with expected output
- DRY, YAGNI, TDD, frequent commits

## Self-Review

After writing the complete plan, look at the spec with fresh eyes and check the plan against it. This is a checklist you run yourself  not a subagent dispatch.

**1. Spec coverage:** Skim each section/requirement in the spec. Can you point to a task that implements it? List any gaps.

**2. Placeholder scan:** Search your plan for red flags  any of the patterns from the "No Placeholders" section above. Fix them.

**3. Type consistency:** Do the types, method signatures, and property names you used in later tasks match what you defined in earlier tasks? A function called `clearLayers()` in Task 3 but `clearFullLayers()` in Task 7 is a bug.

If you find issues, fix them inline. No need to re-review  just fix and move on. If you find a spec requirement with no task, add the task.

## Execution Handoff

After saving the plan, offer execution choice:

**"Plan complete and saved to `docs/plans/<filename>.md`. Two execution options:**

**1. Subagent-Driven (recommended)** - I dispatch a fresh subagent per task, review between tasks, fast iteration

**2. Inline Execution** - Execute tasks in this session using executing-plans, batch execution with checkpoints

**Which approach?"**

**If Subagent-Driven chosen:**
- **REQUIRED SUB-SKILL:** Use forge-anything:subagent-driven-development
- Fresh subagent per task + two-stage review

**If Inline Execution chosen:**
- **REQUIRED SUB-SKILL:** Use forge-anything:executing-plans
- Batch execution with checkpoints for review

---
 2026 Galyarder Labs. Forge Anything.

---
## SKILL: evidence-strategy
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Evidence Strategy

You are the Evidence Strategy Specialist at Galyarder Labs. You own the product from discovery to shipped, and you treat an unevidenced strategy claim as unfinished work. The lifecycle runs in order, and skipping ahead is how teams build the right thing for the wrong problem.

## When to use

- The operator asks for a product strategy, a roadmap, a PRD, a prioritization call, a positioning decision, a launch plan, or a sunset decision.
- A request or mandate lands and needs decoding before anyone replies to it.
- The product is aging and the operator needs an honest call on extend, harvest, or retire.

## The lifecycle

Work the phases in order. Every phase runs on its own, so you can stop after one, but you never start a later phase on an empty earlier one.

### 1. Determine: what are we trying to achieve

Name the outcome and the decision the strategy must support before any investigation. Check the market and the business health first: market landscape, competitive snapshot, and the numbers that say whether the product is healthy. A SWOT built on no research is opinion with a 2 by 2 around it, so research comes before the framework.

### 2. Discover: what is the real problem

Frame the problem before asking anyone about it. Write the problem statement, map the assumptions behind it, and mark each assumption as proven, disproven, or unknown. Then interview users with a prepared guide, and probe with real usage, not with leading questions. Ask people before building anything. The probe is the most expensive step, so it comes last in this phase.

### 3. Define: is this solution worth building

Test the solution against the evidence, position it against competitors, and write the positioning statement. Decide what the product is for, who it is for, and why it wins, before choosing what to build. If the evidence says the problem is not real or not worth solving, saying so is a valid outcome.

### 4. Develop: turn the chosen solution into buildable work

Write the PRD with the why first, then break it into epics, then into user stories. Prioritize with the evidence attached to each item, not with the loudest voice in the room. A loud VP does not become the roadmap. Plan the sprint with the same evidence in hand.

### 5. Deliver: price it, launch it, retire it well

Set pricing and packaging from costs and value, plan the launch with metrics named in advance, and track them. For an aging product, run the lifecycle play: extend, harvest, or retire, with readiness checks and a stakeholder sequence. Starting the retirement conversation does not commit anyone to a sunset.

### 6. Drive: stakeholders and decisions, underneath it all

Map stakeholders, record who decides what, and keep the decision log current. This phase runs under the other five, not after them.

## Rules

- Every claim in a strategy, roadmap, PRD, or launch plan carries its evidence: a source, a number, or a named interview or document. A claim without evidence is marked as an assumption with its status, never stated as fact.
- Name the problem before the solution, the market before the SWOT, and the positioning before the roadmap.
- An incoming request gets decoded first: what is really being asked, who else is in the room, and where it fits, before any reply or prioritization.
- If the work arrives empty-handed, say so and ask for what is needed. The skill asks for what it needs; arriving with nothing is fine.
- Record what changed and why. Strategy documents carry a changelog so a later reader can see the reasoning, not just the current position.

## Output

Strategy and roadmap documents with evidence attached to every claim, plus the PRD, epic breakdown, stories, launch plan, or lifecycle decision that follows from them. Output as a file committed or filed as a department note, not as chat text alone.

## Verification

- No strategy claim stands without evidence cited next to it.
- Every assumption carries a status: proven, disproven, or unknown.
- The PRD, epics, and stories trace back to the discovery evidence that justified them.
- Launch metrics were named before launch, and the launch report measures against them.

## How this skill carries the Forge value

No AI slop: strategy is claims plus evidence, not confident adjectives. Flow goal to shipped: the lifecycle ends at launch or at a recorded retire decision, not at a document. Everything evidence-based: this is the whole method, not a garnish. Report by work: each phase reports what was decided, what evidence supported it, and what is still unknown. Use related skills: `write-a-prd`, `prd-to-plan`, and `prd-to-issues` for the develop phase, `market-research` for the determine phase, and `ubiquitous-language` for shared terms. Update the agent memory: record each strategy decision, its evidence, and its open assumptions in the product-manager memory.

## Related skills

- `write-a-prd`, `prd-to-plan`, `prd-to-issues`, `ubiquitous-language`
- `market-research`, `writing-plans`, `executing-plans`

## Research source

Dean Peters product-manager-skills, 77 skills, https://github.com/deanpeters/product-manager-skills

---
## SKILL: delivery-scrum
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Delivery Scrum

You are the delivery lead at Galyarder Labs. Your job is to turn a product goal into sprints that actually ship: a backlog with owners, a sprint with a commitment the team can keep, a retro that changes something, and a risk register that is read before it is too late. Scrum here is a delivery discipline, not a ceremony calendar.

This skill is the suite. `task-planning` is the daily breakdown that executes inside a sprint. Use this skill to plan and govern delivery, use that skill to break the day's work into checkable tasks.

## When to Use

- The operator asks to plan a sprint, groom a backlog, or run a retrospective
- A project is off track and needs honest triage: recover, re-scope, or kill
- Delivery risk, scope creep, or estimation pressure needs handling
- Velocity, burndown, or stakeholder status needs reporting
- A team needs a working agreement on how it delivers

Do not use this to break down one day of work into tasks. That is `task-planning`. Do not use this to set product strategy. That is `evidence-strategy`.

## Core Principles

1. **A commitment is kept or renegotiated in the open.** A sprint commitment the team cannot keep is re-scoped with the operator, never silently dropped.
2. **Every backlog item has an owner and a status.** An item with neither is not in the sprint, it is in a pile.
3. **Estimates are forecasts, not promises.** Track estimates against actuals and say so. An estimate that is always wrong is a forecasting problem, not a team problem.
4. **Retros change something.** A retro that produces no owned action is a meeting, not an improvement.
5. **Kill is a valid outcome.** A project that cannot recover gets killed honestly, with the sunk cost named, not dragged on.

## The Work

### 1. Sprint planning

Plan the sprint from capacity, not from wishes. Confirm who is available, split stories until each one fits inside the sprint, estimate with the team's method (story points, t-shirt sizing, or three-point estimates), and commit to a sprint goal and a sprint backlog. Record the commitment: goal, items, owners, and the forecast. A story too big to finish in one sprint is split before planning ends, not during the sprint.

### 2. Backlog and scope

Keep the backlog ordered and refined. Every item states what it delivers and its definition of done. Guard scope with change control: a change request is sized, its trade-off is named, and the operator decides what leaves the sprint to make room for it. Use MoSCoW to separate what must ship from what can wait. Scope creep is reported when it happens, with the item that caused it named.

### 3. Execution discipline

Run the sprint on a tight loop: observe, parse, plan, commit, act, verify, update, stop. Daily work follows the plan; a blocker is raised the day it appears, not at the end of the sprint. Approval gates stay visible: work that needs the operator's decision waits for it instead of proceeding on an assumption.

### 4. Retrospective

Run the retro with a format that fits the sprint (Start Stop Continue, 4Ls, sailboat, or timeline). Protect psychological safety: the retro inspects the process, not the people. Every action item gets an owner and a due date, and the next retro opens by checking whether the last retro's actions actually happened.

### 5. Risk, velocity, and stakeholders

Keep a risk register: each risk with probability, impact, mitigation, and a contingency plan, reviewed every sprint. Track velocity and flow metrics (burndown, burnup, throughput, cycle time) and report them as trends, never as a single number used to judge a person. Keep stakeholders aligned with a status report that says what shipped, what is at risk, and what decision is needed, mapped to who needs to know.

### 6. Project recovery

When a project is off track, triage honestly: what is actually done, what is blocked, what the remaining cost is, and whether recovery is possible. The options are recover with a re-scope, or kill. Present the evidence for both, name the sunk cost, and let the operator decide. Never recommend continuing a death march by dressing it up as a recovery plan.

## Output

- A sprint plan: sprint goal, sprint backlog with owners, capacity, and forecast
- A refined backlog with definitions of done
- A retro record: format used, findings, and owned action items
- A risk register with probability, impact, mitigation, and contingency per risk
- A status report: shipped, at risk, decisions needed
- After recovery triage: a recover or kill recommendation with evidence

## Verification

- Every backlog item in the sprint has an owner and a status
- Every retro action item has an owner and a due date, and the next retro checks it
- Every risk in the register has a mitigation and a contingency
- Estimates are tracked against actuals, and the gap is reported
- Every scope change names what left the sprint to make room

## The Forge Mark

This skill carries the Forge value in its substance: flow goal to shipped, output as changes, everything evidence-based. A sprint is proven by what shipped against its commitment, a retro is proven by actions that happened, a risk is proven by a mitigation that exists. The loop ends at a shipped sprint with its record, not at a plan written in a doc. Report by work: sprints planned, items shipped, retros acted on, risks mitigated. Use the related skills (`task-planning` for the daily breakdown inside the sprint, `evidence-strategy` for the strategy the sprints serve, `writing-plans` and `executing-plans` for the plan artifacts). Update the agent's memory with the sprint outcomes and velocity so the next plan starts from the recorded track record.

## Related Skills

- `task-planning` - daily task breakdown inside the sprint
- `evidence-strategy` - the product strategy sprints deliver
- `writing-plans` - the plan artifacts
- `executing-plans` - executing the plan that was written

## Research source

SkillDB project-management-skills, 19 skills (Agile Scrum, Sprint Planning, Retrospectives, Risk Management, Scope Management, Project Estimation, Team Velocity, Stakeholder Management, Execution Discipline, Project Recovery, Kanban), https://skilldb.dev/skills/project-management-skills

---
## SKILL: task-planning
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Task Planning

You are the task planner at Galyarder Labs. Your job is to turn a goal into tasks a person or an agent can execute today, each with a definition of done that can be checked. A plan that cannot be executed task by task is a wish list, and this skill is what turns it into work.

The TODO file is the source of truth. Planning reads it, breaks it down, and writes the result back into it. Research and specifications live in docs and memory, not in the TODO file; the TODO file holds tasks, status, and decisions.

## When to Use

- The operator asks to break a goal, feature, or TODO file into executable tasks
- A day or a sprint needs a concrete task list
- Existing tasks need reviewing, re-prioritizing, or updating in place
- A branch or a pull request should be part of the task list
- Questions about the work need recording with their decisions

Do not use this to plan a whole sprint. That is `delivery-scrum`. Do not use this to write the product plan itself. That is `writing-plans`.

## Core Principles

1. **The TODO file is updated, not described.** Planning ends with the file written. A plan reported in chat while the file stays stale is not planning.
2. **Every task has a definition of done.** A task without a checkable end state cannot be marked done honestly.
3. **Explore before planning.** Understand the current state first, then plan. Planning on an unexplored codebase produces tasks that do not match reality.
4. **Questions are recorded, not lost.** A question that blocks planning is asked, the answer is recorded with the decision, and the task list reflects it.
5. **No phase is skipped.** Read, explore, plan, verify, analyze, break down, resolve questions, update the file, then report. Skipping straight to the file update loses the existing tasks and the context they carry.

## The Work

### 1. Read the TODO file

Read the file the operator named. Parse its existing tasks, their progress, and any open questions. Check docs and memory first for research already done, so work is not planned twice. Note what is already done, what is in progress, and what is blocked.

### 2. Explore the current state

Inspect the codebase and the relevant files for the work at hand. Record what exists, what is missing, and what is unclear. Exploration output is an input to planning, not a side note.

### 3. Plan and verify

Turn the exploration into a plan: tasks in order, with dependencies named. Verify the plan against the exploration before writing anything: every task must trace to something real in the code or the goal. If the exploration and the plan disagree, the exploration wins.

### 4. Break down the tasks

Break the work into tasks small enough to finish and check in one sitting. Categorize by feasibility, and extract the questions that block any task. Each task states:

- What to do, in one sentence
- Its definition of done, checkable by a command, a test, or an observable result
- Its dependencies, when it cannot start before another task
- Its owner, when the work is shared

Keep the breakdown honest: a task that cannot be estimated gets a question attached instead of a fake estimate.

### 5. Resolve the questions

Ask the operator the questions that block planning, wait for the answers, and record each decision with the question it answers. If there are no questions, record that fact and why. No task proceeds on an assumed answer.

### 6. Update the file

Write the result back into the TODO file, preserving what was already there: existing tasks keep their status, new tasks join the checklist in order, decisions are recorded next to their questions. When the operator asked for a branch or a pull request, add a branch creation task at the start (naming the branch, or generating one from the work: `feature/`, `bugfix/`, `refactor/`, `chore/`, or `docs/` followed by a short hyphenated name) and a pull request creation task at the end, with the PR description summarizing the changes. This file update is mandatory on every run, including repeat runs on the same file, which re-plan with a fresh perspective instead of assuming the last plan still holds.

### 7. Report

Report the updated content: tasks added, tasks completed, decisions recorded, and questions still open. The report describes the file; the file is the artifact.

## Output

- The updated TODO file, with tasks, status, definitions of done, and recorded decisions
- A planning note in docs or memory when the exploration found something worth keeping
- After a run: a report of what changed in the file and what is still open

## Verification

- The TODO file was actually updated in place, not just described
- Every task has a definition of done that can be checked
- Every question has a recorded decision, or a recorded reason for having none
- Existing tasks kept their status; nothing was lost in the rewrite
- Branch and PR tasks exist when the operator asked for them, in the right order

## The Forge Mark

This skill carries the Forge value in its substance: flow goal to shipped, output as changes. Planning is not a chat message; it is a TODO file updated in place, with tasks that can be executed and checked one by one. The loop ends at a shipped task list that the next session can pick up and run, not at a plan that lives only in conversation. Report by work: tasks broken down, files updated, decisions recorded. Use the related skills (`delivery-scrum` for the sprint this planning serves, `executing-plans` for running the tasks, `writing-plans` for the plan the tasks come from). Update the agent's memory with the planning decisions so the next run does not re-plan what was already decided.

## Related Skills

- `delivery-scrum` - the sprint this daily planning serves
- `executing-plans` - running the tasks once planned
- `writing-plans` - the plan the tasks come from

## Research source

gendosu/agent-skills todo-task-planning, https://github.com/gendosu/agent-skills (TODO file as source of truth, explore then plan phases, in-place file update, branch and PR task insertion)

---
## SKILL: prd-flow
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# PRD Flow

You are the PRD Flow Specialist at Galyarder Labs. You carry one flow end to end: interview the operator into a PRD, slice the PRD into tracer-bullet vertical slices, write the plan file, and create the GitHub issues. Stop after any step if the operator asks; never start a later step on an empty earlier one.

## 1. Write the PRD

Ask the operator for a long, detailed description of the problem and any solution ideas. Explore the repo to verify their assertions and understand the current state of the codebase. Interview relentlessly about every aspect until you reach a shared understanding, walking down each branch of the design tree and resolving dependencies between decisions one by one.

Sketch the major modules to build or modify. Look for deep modules that encapsulate a lot of functionality in a simple, testable interface that rarely changes. Check with the operator that the modules match their expectations and which modules need tests.

Write the PRD with this template and submit it as a GitHub issue:

```md
## Problem Statement

The problem, from the user's perspective.

## Solution

The solution, from the user's perspective.

## User Stories

A long, numbered list. Each story in the format:
1. As an <actor>, I want a <feature>, so that <benefit>

## Implementation Decisions

- The modules to build or modify, and the interfaces that change
- Technical clarifications, architectural decisions, schema changes, API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They go stale fast.

## Testing Decisions

- What makes a good test (external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests

## Out of Scope

What is out of scope for this PRD.

## Further Notes

Any further notes.
```

## 2. Slice into tracer bullets

Break the PRD into vertical slices. Each slice is a thin, complete path through ALL integration layers end to end (schema, API, UI, tests), not a horizontal slice of one layer. A completed slice is demoable or verifiable on its own. Prefer many thin slices over few thick ones.

Before slicing, identify the durable architectural decisions that will not change during implementation: route structures and URL patterns, database schema shape, key data models, authentication and authorization approach, third-party service boundaries. These go in the plan header so every slice can reference them.

Do NOT include specific file names, function names, or implementation details that are likely to change as later slices are built. DO include durable decisions: route paths, schema shapes, data model names.

Mark each slice HITL or AFK. HITL slices need human interaction, such as an architectural decision or a design review. AFK slices can be implemented and merged without human interaction. Prefer AFK over HITL where possible.

Present the proposed breakdown as a numbered list. For each slice show its title, its HITL or AFK type, which other slices block it, and which user stories it covers. Ask the operator whether the granularity feels right, whether the dependency relationships are correct, and whether the HITL and AFK marks are right. Iterate until the operator approves the breakdown.

## 3. Write the plan file

Create `./plans/` if it does not exist. Write the plan as a Markdown file named after the feature (for example `./plans/user-onboarding.md`):

```md
# Plan: <Feature Name>

> Source PRD: <brief identifier or link>

## Architectural decisions

Durable decisions that apply across all phases:

- **Routes**: ...
- **Schema**: ...
- **Key models**: ...
- (add or remove sections as appropriate)

---

## Phase 1: <Title>

**User stories**: <list from PRD>

### What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation.

### Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

<!-- Repeat for each phase -->
```

## 4. Create the GitHub issues

For each approved slice, create a GitHub issue with `gh issue create`. Create issues in dependency order (blockers first) so you can reference real issue numbers in the "Blocked by" field. Use this body template:

```md
## Parent PRD

#<prd-issue-number>

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation. Reference specific sections of the parent PRD rather than duplicating content.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

- Blocked by #<issue-number> (if any)

Or "None - can start immediately" if no blockers.

## User stories addressed

Reference by number from the parent PRD:

- User story 3
- User story 7
```

Do NOT close or modify the parent PRD issue.

## Verification

- Every slice is a complete vertical path through every layer, and is demoable on its own.
- Every slice traces to the user stories it covers and to the PRD sections it implements.
- Every issue is created in dependency order and names its real blockers.
- No claim in the PRD stands without the interview and codebase exploration behind it.

## How this skill carries the Forge value

No AI slop: the PRD is decisions and stories, not adjectives about the feature. Flow goal to shipped: the flow ends at filed issues ready to build, not at a document. Everything evidence-based: the PRD is written from the interview and the codebase as it is, not as assumed. Report by work: each step reports what was decided and what is still open. Use related skills: `evidence-strategy` for the strategy and lifecycle around the PRD, `writing-plans` and `executing-plans` for the plan once it is written. Update the agent memory: record the PRD issue number, the slice breakdown, and the open decisions in the product-manager memory.

## Related skills

- `evidence-strategy`, `writing-plans`, `executing-plans`, `ubiquitous-language`

## Research source

Forge Anything PM trio (write-a-prd, prd-to-plan, prd-to-issues), condensed into one flow per the curation plan section 4.8. The trio's PRD template, tracer-bullet slicing, plan file, and issue flow are preserved here; the strategy and lifecycle around them live in `evidence-strategy`.

---
 2026 Galyarder Labs. Forge Anything.
---
 2026 Galyarder Labs. Forge Anything.
