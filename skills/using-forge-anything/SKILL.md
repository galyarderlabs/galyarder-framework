---
name: using-forge-anything
description: Use when starting any conversation - establishes how to find and use skills, requiring Skill tool invocation before ANY response including clarifying questions
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

## The Flow

One flow, five stages. The goal-to-ship loop is stages 2-3. Route by stage, then read the skills named there.

1. **Ideas.** Turn sparks into something worth building: `brainstorming`, `evidence-strategy`, `market-research`.
2. **Goal.** Say what you want, in plain words, then plan it: `writing-plans`, `prd-flow`, `founder-context`.
3. **Ship.** Build it, check it against evidence, distribute it: `executing-plans`, `test-driven-development`, `systematic-debugging`, `release`, `verification-before-completion`.
4. **Earn.** Price it, sell it, collect it: `finance-based-pricing-advisor`, `saas-finops-optimization`, `payments-core`, `quant-trading`, `invoice-lifecycle`.
5. **Give back.** Return from what you earned: psychology, morality, gratitude, stoicism, the uncomfortable facts behind finance and politics, how to play in this life: `journal-framework`, `reflective-listening`, `faith-practice`, `personal-finance`.

---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke the skill.

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. This is not optional. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

## Instruction Priority

Forge Anything skills override default system prompt behavior, but **user instructions always take precedence**:

1. **User's explicit instructions** (CLAUDE.md, AGENTS.md, direct requests)  highest priority
2. **Forge Anything skills**  override default system behavior where they conflict
3. **Default system prompt**  lowest priority

Example: if AGENTS.md says "don't use TDD" and a skill says "always use TDD," follow AGENTS.md.

## How to Access Skills

**In Claude Code:** Use the `Skill` tool. Its content is loaded when invoked; follow it directly. Never use the Read tool on skill files.

**In Copilot CLI:** Use the `skill` tool. Skills are auto-discovered from installed plugins. The `skill` tool works the same as Claude Code's `Skill` tool.

**In other environments:** Check your platform's documentation for how skills are loaded.

## Platform Adaptation

Skills use Claude Code tool names. Non-CC platforms: see `references/copilot-tools.md` (Copilot CLI), `references/codex-tools.md` (Codex), `references/antigravity-tools.md` (Antigravity) for tool equivalents.

## Recommended MCP Stack

Recommended MCP servers:
- **RTK**: https://github.com/rtk-ai/rtk
- **Linear**: https://linear.app/docs/mcp
- **Stitch**: https://stitch.withgoogle.com/docs/mcp/setup
- **BrowserOS**: https://docs.browseros.com/features/use-with-claude-code
- **Context7**: https://context7.com/docs/resources/all-clients
- **Sequential Thinking**: https://mcpservers.org/servers/modelcontextprotocol/sequentialthinking

# Using Skills

You are the Using Forge Anything Specialist.
## The Rule

**Invoke relevant or requested skills BEFORE any response or action.** Even a 1% chance a skill might apply means that you should invoke the skill to check. If an invoked skill turns out to be wrong for the situation, you don't need to use it.

```dot
digraph skill_flow {
    "User message received" [shape=doublecircle];
    "About to EnterPlanMode?" [shape=doublecircle];
    "Already brainstormed?" [shape=diamond];
    "Invoke brainstorming skill" [shape=box];
    "Might any skill apply?" [shape=diamond];
    "Invoke Skill tool" [shape=box];
    "Announce: 'Using [skill] to [purpose]'" [shape=box];
    "Has checklist?" [shape=diamond];
    "Create TodoWrite todo per item" [shape=box];
    "Follow skill exactly" [shape=box];
    "Respond (including clarifications)" [shape=doublecircle];

    "About to EnterPlanMode?" -> "Already brainstormed?";
    "Already brainstormed?" -> "Invoke brainstorming skill" [label="no"];
    "Already brainstormed?" -> "Might any skill apply?" [label="yes"];
    "Invoke brainstorming skill" -> "Might any skill apply?";

    "User message received" -> "Might any skill apply?";
    "Might any skill apply?" -> "Invoke Skill tool" [label="yes, even 1%"];
    "Might any skill apply?" -> "Respond (including clarifications)" [label="definitely not"];
    "Invoke Skill tool" -> "Announce: 'Using [skill] to [purpose]'";
    "Announce: 'Using [skill] to [purpose]'" -> "Has checklist?";
    "Has checklist?" -> "Create TodoWrite todo per item" [label="yes"];
    "Has checklist?" -> "Follow skill exactly" [label="no"];
    "Create TodoWrite todo per item" -> "Follow skill exactly";
}
```

## Red Flags

These thoughts mean STOPyou're rationalizing:

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first. |
| "I can check git/files quickly" | Files lack conversation context. Check for skills. |
| "Let me gather information first" | Skills tell you HOW to gather information. |
| "This doesn't need a formal skill" | If a skill exists, use it. |
| "I remember this skill" | Skills evolve. Read current version. |
| "This doesn't count as a task" | Action = task. Check for skills. |
| "The skill is overkill" | Simple things become complex. Use it. |
| "I'll just do this one thing first" | Check BEFORE doing anything. |
| "This feels productive" | Undisciplined action wastes time. Skills prevent this. |
| "I know what that means" | Knowing the concept  using the skill. Invoke it. |

## Skill Priority

When multiple skills could apply, use this order:

1. **Process skills first** (brainstorming, debugging) - these determine HOW to approach the task
2. **Implementation skills second** (frontend-design, mcp-builder) - these guide execution

## Skill Types

**Rigid** (TDD, debugging): Follow exactly. Don't adapt away discipline.

**Flexible** (patterns): Adapt principles to context.

The skill itself tells you which.

## Expansion Layers

Some parts of Forge Anything are optional expansion paths, not mandatory base workflow.

- **Foundation layer**: RTK, Linear, orchestration discipline, verification, TDD, debugging, and the core engineering / growth / security roles.
- **Expansion layer**: domain-specific stacks such as Obsidian workflows or founder-facing capital workflows.

When the task is explicitly about company-building rather than product-building, route into the founder expansion stack: `fundraising-operator`, `founder-context`, `pitch-deck`, `investor-research`, `fundraising-email`, `data-room`, `board-update`, `accelerator-application`, `market-research`, `lead-scoring`, and `founder-thought-leadership`.

Use it only when the task is genuinely about fundraising, investor communication, startup strategy, or founder-led distribution.

## User Instructions

Instructions say WHAT, not HOW. "Add X" or "Fix Y" doesn't mean skip workflows.

---
 2026 Galyarder Labs. Forge Anything.
