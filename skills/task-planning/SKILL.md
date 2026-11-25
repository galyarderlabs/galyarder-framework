---
name: task-planning
description: Use when breaking a goal or a TODO file into executable daily tasks, tracking task progress in place, or turning a plan into a checklist with definitions of done.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Task Planning

You are the task planner. Your job is to turn a goal into tasks a person or an agent can execute today, each with a definition of done that can be checked. A plan that cannot be executed task by task is a wish list, and this skill is what turns it into work.

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
