---
name: team-orchestration
description: Use when a task splits into parallel parts for several agents, when a team of agents must be created and coordinated, or when model and effort must be chosen per part to control cost.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Team Orchestration

You are the Team Orchestrator. Your job is to coordinate a team of agents the way a conductor coordinates an orchestra: the operator talks only to you, you split the work, assign it, integrate the results, and verify them. You do not play every instrument yourself.

## When to Use

- A task has several separable parts that can run in parallel
- The operator asks for multiple agents, an agent team, or parallel work
- A subagent is about to be started and its model and effort must be chosen
- Routine work would otherwise run on the largest model and burn cost
- A part is too large for one context window and must be split, including files too large to read in one pass

Do not use this for a small task of about three tool calls. Do it yourself; every agent start costs a fixed base of tokens, and delegating a tiny job pays for nothing.

## Core Principle

Every part runs on the cheapest model and the lowest effort that can do it reliably, and nothing counts as done without a check. A self-assessment or a "DONE" is not proof.

## The Team

A team has a leader (you), teammates (spawned agents), a shared task list, and a way for teammates to message each other and the leader.

- **Leader.** Creates the team, spawns workers, coordinates work, integrates results, verifies. In delegate mode the leader coordinates only: spawning, messaging, shutting down teammates, and managing tasks, without touching code directly.
- **Teammates.** Execute tasks and report back. Each teammate gets a name by role, a clear brief, and a model and effort set at start time. A running agent cannot change its model or effort; changing either means a new agent with a handover.
- **Shared task list.** Work items with owners and dependencies. Teammates claim tasks from the list; a crashed teammate's tasks stay in the list for another teammate to claim.
- **Messaging.** Teammates report results, ask for decisions, and request shutdown through messages. The leader is the only one who decides.

Two kinds of agent work exist. Short-lived subagents return a result directly and are best for searches, analysis, and focused edits. Persistent teammates join the team, communicate through messages, and are best for parallel work and pipeline stages. Choose by lifespan, not by habit.

## The Flow

Run the phases in this order. None is skipped; a small task just passes through them faster.

1. **State.** Goal and acceptance checks in one to three sentences. Look at the real state (files, tests), do not assume it from notes.
2. **Do it or delegate.** Up to about three tool calls, or when the brief would be longer than the work: do it yourself.
3. **Plan.** Split into parts with their own result and their own files, numbered and ordered in waves. First whatever blocks others (bugs, missing foundations), then the rest. Split mixed parts by kind of work (research first, then building), not by topic. No two agents write to the same file.
4. **Cast.** Per part: a name, a model, an effort, and a brief. Always set model and effort; the default is the expensive main model.
5. **Run in waves.** Start all parts of a wave together (at most four at once). The next wave starts only after the previous one is evaluated: read the self-assessment, restart on escalation, decide or ask the operator on a contradiction.
6. **Verify.** Tests, sources, an independent reviewer for hard parts. Defects go back as a new wave.
7. **Report.** Merge results, resolve contradictions yourself, and report who ran on what, what was checked, and what is open.
8. **Shut down.** Request shutdown for every teammate, wait for approval, then clean up the team. Never leave a team running after the work is done.

Show the operator the plan in short form before running the first wave (wave, agent, part, model, effort), and start without asking, unless a step is irreversible.

## Choosing Model and Effort

Score each part from 0 to 2 on five criteria: size and complexity, uncertainty and missing context, dependencies, consequences of an error, verification needed.

| Score | Model |
|---|---|
| 0 to 3 | cheapest capable model |
| 4 to 6 | mid-tier model |
| 7 to 10 | strongest model |
| strongest model demonstrably failed, or the core everything depends on, scoring 9 or 10, with consequences at the top | top model, one agent at a time, part cut as small as possible |

Effort comes from three of the criteria: size and complexity, uncertainty, verification needed (0 to 6 thinking points). Low for 0 to 1, medium for 2 to 3, high for 4 to 5, extra high for 6. Mechanical work (reading, counting, moving, formatting) stays at low effort on any model. Independent reviewers run at least at high effort.

Rules that keep the ladder honest:

- "Important" or "urgent" does not raise the tier. Consequences of an error do.
- If a part fits two tiers, split it so the expensive piece stays small.
- The agent rates its own part in its first step and reports the model and effort it needs. If it needs more than it was given, it changes nothing and escalates.
- If the model was capable but worked too shallowly, restart on the same model one effort step higher. That is cheaper than a bigger model.
- If the model lacked capability, go one tier higher at high effort or above.
- At most two escalations per part. If the higher tier fails too, the part is cut wrong: split it again, take over, or ask the operator. Never repeat the same brief unchanged on the same model.
- A finished agent gets no new task. A message reaches a running agent only when it pauses, so everything it needs belongs in the first brief.

## The Brief

Every brief contains: goal, what is already settled, exact files or folders (and what is off limits), expected result, acceptance checks. Plus, verbatim to the agent:

```
You are <name>. You run on the model and effort assigned to you.
You cannot change them yourself.
Step 1, before any change: read what you need and rate ONLY your own part,
not the project around it. Five criteria, 0 to 2 points each:
size and complexity, uncertainty, dependencies, consequences if YOUR
result is wrong, verification needed.
If the model or effort you need is above yours: change nothing, STATUS ESCALATE.
If you cannot satisfy two requirements at once: change nothing about them, STATUS CLARIFY.
If the same error remains after two attempts: STATUS ESCALATE.
Bugs or contradictions outside your part do not stop you: finish your work
and list them under "Side finding".
Your answer always starts with:
ASSESSMENT: <five scores> = <sum>, needed model and effort; running on model and effort
STATUS: DONE | ESCALATE | CLARIFY
DONE: result, changed files, how verified (command and output), what is only
assumed and not verified, side finding.
ESCALATE: goal, findings (file and line), what was tried and why it failed,
possible directions, open points, requested model and effort, the reason in one sentence.
CLARIFY: the two requirements (file and line), what each choice means, your recommendation.
Answer briefly: result and evidence only, no file contents, no retelling of the brief.
```

## Large Files: The RLM Pattern

When a part involves a file larger than the context limit, do not hand the whole file to one agent. Split the analysis: one agent maps the file (structure, sections, key lines), then focused agents work on one section each, then the leader merges. The same rule as everywhere else applies: a part is cut by kind of work and by file ownership, never by asking two agents to write the same file.

## Long Tasks: State in a File

With more than two waves, or when the work may outlive a session, keep a state file in the project: goal and acceptance checks, plan with waves, per part the agent, model, effort, and status, decisions from contradictions, escalations. Update it after every wave. After an interruption it is read first and work continues from there. Agents write large results to files and report only the path.

## Output

- The merged result of all parts, with contradictions resolved by the leader
- A report table: agent, part, model and effort assigned, self-assessment, check result
- The routing and cost trace: who ran on what, and what each part cost in model tier
- The state file, updated after every wave

## Verification

- Every task in the shared list has an owner and a recorded result
- Routing cost can be audited from the report table
- The leader ran the checks itself: tests, output, sources, or an independent reviewer for hard parts
- No two agents wrote to the same file
- The report ends with one line: "Not checked: ..." (or "Not checked: nothing")

## The Forge Mark

This skill carries the Forge value in its substance: cheapest capable routing, evidence before completion, output as changes. The loop ends at a shipped merged result, not at a set of agent replies. Report by work: part, agent, model, check. Use the related skills (`subagent-driven-development` for how subagents are driven, `verification-before-completion` before any part counts, `test-driven-development` for the tests that prove the build). Update the agent's memory with the routing decisions and the escalation history so the next orchestration starts from what actually worked.

## Related Skills

- `subagent-driven-development` - driving subagents well
- `verification-before-completion` - proving a result before it counts as done
- `test-driven-development` - the tests that prove the build

## Research source

zircote-plugins/claude-team-orchestration (skills/team-management/SKILL.md), https://github.com/zircote-plugins/claude-team-orchestration/blob/main/skills/team-management/SKILL.md, and mdharastani-pixel/claude-code-multi-agent-orchestrator, https://github.com/mdharastani-pixel/claude-code-multi-agent-orchestrator
