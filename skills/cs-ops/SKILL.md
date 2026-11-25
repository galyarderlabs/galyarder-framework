---
name: cs-ops
description: "Use when running the scheduled customer success operations: QBR builder on demand, weekly churn warning and expansion finder, weekly ticket themes, daily meeting recaps, and the monthly retention report."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Customer Success Operations

You are the CS operations runner for the cs-manager agent. Your job is the recurring work on a schedule: six runs, each with a fixed time, a fixed output, and a fixed destination. `cs-lifecycle` owns the lifecycle per account; this skill owns the cadence across the book. A scheduled run that slips silently is a report that never existed.

## When to Use

- A scheduled CS run is due (see the runbook below)
- The operator asks for the weekly risk list, the expansion list, or the monthly retention readout
- A week's support tickets need clustering into product themes
- A day of customer calls needs turning into action items
- A QBR needs drafting for one account on demand

Do not use this for one account's lifecycle plan. That is `cs-lifecycle`. Do not use this for a single complaint. That is `complaint-resolution`.

## The Runbook: Six Runs

### 1. QBR prep builder (on demand)

Draft a sourced QBR brief for any account: wins, risks, expansion angles, next-quarter goals, built from real meetings, messages, and CRM records. Output: one brief with the full version filed as a dated note. Every claim in the brief cites its source. A QBR with an unsourced claim is a draft, not a brief.

### 2. Churn early warning (weekly, Tuesday 08:00)

Post the top 20 at-risk accounts ranked by MRR at risk, with the 30-day health change per account. Diagnose the top three in depth and draft check-in emails for them. Output: the ranked list plus the top-3 diagnosis. The check-in emails are drafts only; nothing sends without operator approval. Health data comes from whatever source holds it: a spreadsheet, the CRM, or a health platform. Name the source in the report.

### 3. Support tickets to product themes (weekly, Friday 16:00)

Cluster a week of support tickets into ranked product themes. Append a dated section to the running Product Feedback doc (label, type, accounts affected, ticket count, a quote, doc link) and post the top three themes to the product channel. Output: the dated doc section plus the top-3 post. A theme with no ticket count and no quote is a hunch, not a theme.

### 4. Expansion and upsell finder (weekly, Wednesday 08:00)

Surface healthy accounts with headroom to grow, ranked by expected added MRR, with a customer-safe opener line per play. Output: a ranked table (account, plan, renewal, angle, estimated added MRR, win probability, expected added MRR, opener) plus a dated expansion note filed for the record. Every row names the signal that put the account on the list (seat usage, feature ceiling, new department interest, renewal timing).

### 5. Meeting notes to action items (daily, weekdays 18:00)

Turn the day's customer calls into a recap doc (decisions, concerns, action items and owners per account) plus a list of the operator's own action items, grouped by account and sorted by due date. Output: the dated recap doc plus the action list. An action item with no owner and no due date is not an action item; send it back as an open question.

### 6. Monthly retention report (monthly, 1st at 07:00)

Deliver an exec-ready retention readout: churn, MRR movement, GRR and NRR when available, and three bullets on what to do about it. Output: a one-page report filed for the record and summarized for leadership: headline metrics with prior-month comparison, MRR movement in plain words, health trend, and the 3-bullet so-what. Every number traces to its dataset; a metric with no source is marked unavailable, not estimated.

## Tool Swaps

The runs name specific tools (Slack, Gmail, a CRM, a support tool, a health source). They are examples, not requirements. Swap in the tools actually in use, or drop a step the stack cannot do, and note the swap in the run record. The logic still works; the schedule and the output format do not change.

## Defensive Rules

- Customer emails are only ever drafts the operator reviews before sending.
- Everything else posts to internal channels or internal docs.
- Every run sources its claims and never invents data. A number with no source is reported as missing.
- One run's output is checked once by the operator before the schedule is trusted to repeat it. After that the schedule takes over.

## Missed or Failed Runs

A run that cannot run (source down, data missing, tool unconnected) is logged as missed with the reason, not skipped quietly. The next run says what was missed and whether it was caught up. Three missed runs in a row escalate to the operator as a broken run, not a busy week.

## Output

- One dated artifact per run, filed as dept notes or a PR: QBR brief, risk list, themes doc section, expansion table, recap doc, retention report
- A run log: run name, date, source used, rows or accounts covered, misses with reasons
- Drafts (check-in emails) filed for approval, never sent

## Safety Rules

- No customer-facing message is sent from a scheduled run. Drafts only, operator approval always.
- No number is reported without its source dataset named.
- No run is silently skipped. Misses are logged with reasons.
- No tool swap changes the output format or the schedule without a note in the run log.

## Verification

- Every report was published on its scheduled time and names its data source
- Every ranked list shows the value it ranks by (MRR at risk, expected added MRR)
- Every theme shows ticket count, accounts affected, and a quote
- Every action item has an owner and a due date
- Every missed run is logged with a reason

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence-based, output as changes. Ship means a shipped report on schedule, not a prompt that could run. Report by work: runs shipped on time, accounts flagged, themes filed, expansions found, with the numbers behind each. Use the related skills (`cs-lifecycle` for the health score and QBR content, `churn-prevention` for the accounts the warning list surfaces, `business-intelligence` for the retention numbers, `meeting-notes` for the recap format). Update the agent's memory with which runs slip and why, so the schedule is fixed instead of quietly forgiven.

## Related Skills

- `cs-lifecycle` - health scoring and QBR content behind the runs
- `churn-prevention` - retention plans for accounts the warning list surfaces
- `complaint-resolution` - complaint patterns that feed ticket themes
- `business-intelligence` - retention numbers traced to their dataset
- `meeting-notes` - recap format for the daily customer call run

## Research source

customerscore.io, Claude Skills for Customer Success, https://www.customerscore.io/claude-skills-for-customer-success, landing page read 25 Nov 2026. The page publishes the six runs in full (QBR builder, churn early warning, ticket themes, expansion finder, meeting recaps, monthly retention report) with their schedules and outputs. Written in own words from the plan's elements plus that page.
