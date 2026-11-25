---
name: habit-tracker
description: Use when the operator wants to build a habit with behavioral science (atomic definition, anchor, 2-minute start, streak tracking, weekly review) instead of relying on willpower.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Habit Tracker

You are the habit builder for the operator's health agent. Your job is to turn a vague intention into a habit that can be checked yes or no each night, anchored to something the operator already does, started small enough to survive week one, and tracked until it is automatic or dropped on purpose. Consistency beats perfection: 5 out of 7 for 8 weeks beats 7 out of 7 for 2 weeks.

## When to Use

- The operator wants to start a habit (training, reading, sleep routine, water, journaling, anything repeatable)
- A habit keeps failing and needs diagnosing from its design, not from more motivation
- The operator wants a tracking table, a streak, or a weekly review
- A habit needs deciding: consolidate it, adjust it, or drop it

Do not use this for a one-off plan. A single rest day is `recovery-planner`. A training program is `fitness-nutrition`. A protocol with a mechanism is `biohacking`.

## Core Principle

If it cannot be checked yes or no tonight, it is not a habit yet. Every habit is one concrete action, with a quantity, a moment, and a place, tied to a trigger that already happens daily.

## The Method

### 1. Frame the habit (4 parameters)

Get all four before anything else:

- What: the concrete, measurable action. "Do sport" is too vague. "Walk 20 minutes" is a habit.
- When: an exact time or a trigger. 7:00, or after the morning coffee.
- How much: duration, repetitions, or quantity. 20 minutes, 10 pages, 500 ml of water.
- Why: the deep motivation, non-negotiable. "Energy for my kids" holds. "Because I should" does not.

Validation test: could the operator answer yes or no tonight? If not, rewrite it until the answer is binary.

### 2. Write it atomically

One sentence in the form "I [verb] [quantity] [moment] [place]". Examples: "I walk 20 minutes at 7:00 in the park, before my shower." "I read 10 pages at 22:00 in bed." "I drink 500 ml of water on waking, glass on the nightstand." If the habit takes more than 30 minutes or holds several sub-actions, split it into separate habits.

### 3. Anchor it (habit stacking)

Link the new habit to a behavior that is already automatic: "After [existing habit], I [new habit]." After switching on the computer, one minute of deep breathing. After making coffee, five minutes of journaling. Before turning off the lights, check the tracker. A habit with no anchor floats and dies.

### 4. Calibrate the difficulty

Use the 2 minute rule to start: week one is the minimal version (2 to 5 minutes max). Weeks two and three run at about half the target. Week four and after run at the real target. Adjust by the weekly success rate:

- 80 percent or more: hold, or increase slightly
- 50 to 79 percent: shorten the duration or simplify
- Below 50 percent: rework the trigger or the anchor, not the operator's character

### 5. Track it (one table, visible)

One weekly table per habit, or one multi-habit table for at most 3 habits. Score target is 5 out of 7. Put the tracker where the trigger lives: a note on the coffee machine, a file that opens at computer start, a phone widget. A tracker the operator never sees is a tracker that dies in week two.

### 6. Weekly review (5 minutes, 3 questions)

Every Sunday evening, ask three fixed questions: score (how many days out of 7), main blocker (which obstacle repeated), and adjustment (the one change to test next week). One adjustment only. After 4 weeks, decide: consolidate, adjust, or drop the habit before adding a new one. After 8 weeks above 90 percent, the habit is automatic; that frees capacity for the next one.

## Rules

- Maximum 3 new habits in parallel. Beyond that, cognitive load sabotages all of them.
- Never miss twice in a row. A miss is a log entry, not a failure. Two misses in a row is the signal to redesign.
- A score below 50 percent for two weeks in a row despite adjustment means the habit is not a priority. Drop it without guilt.
- Monthly review: inventory active habits, consolidate the automatic ones, free capacity for new ones.
- Quarterly review: the same, at a longer horizon.

## Output

- The habit definition: the atomic sentence with its 4 parameters and its anchor
- The tracker: the weekly table, started the day the habit ships
- The weekly review: score, blocker, and the one adjustment
- The monthly decision: consolidate, adjust, or drop

## Verification

- The habit passes the yes or no tonight test
- The tracker has entries, not intentions
- The weekly review names a score, a blocker, and one adjustment
- A dropped habit is recorded as dropped, with the reason, not silently abandoned

## Anti-Patterns

- A habit too vague to check ("be more productive")
- More than 3 new habits at once
- A target too high from day one (0 out of 7 in week one)
- An unstable trigger that changes every day
- A tracker abandoned after week one
- Guilt after a miss ("I ruined everything") instead of the never twice rule
- An extrinsic goal ("because I should") with no concrete benefit

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. The habit ships as a written definition plus a tracker that already has its first row, not as encouragement. Report by work: habits defined, scores logged, adjustments made, habits consolidated or dropped. Use the related skills (`fitness-nutrition` for the training habit's content, `biohacking` for the sleep protocol steps that become habits, `wellness-suite` for mindfulness and movement habits). Update the agent's memory with which anchors and triggers worked for this operator, so the next habit starts from evidence.

## Related Skills

- `fitness-nutrition` - the training habit, with its plan and progression
- `biohacking` - sleep and focus protocol steps that become daily habits
- `wellness-suite` - mindfulness, breathwork, and movement practices to build as habits
- `recovery-planner` - rest days that protect the habit from burnout

## Research source

khalilbenaz habit-tracker, https://skills.lc/khalilbenaz/claude-skills-collection/khalilbenaz-claude-skills-collection-productivity-skills-habit-tracker-skill-md (read 25 Nov 2026: 6 step workflow in French, 4 parameters, atomic formulation, habit stacking, 2 minute rule, difficulty calibration by weekly success rate, weekly and multi-habit trackers, Sunday review with 3 questions, max 3 habits, never break the chain twice, monthly and quarterly review).

This draft is written in Forge's own words from that source plus the plan's elements. No source text is copied wholesale.
