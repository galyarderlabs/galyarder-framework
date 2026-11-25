---
name: personal-finance
description: "Use when managing personal money: building a budget from real income and expenses, tracking spending, paying off debt, planning savings and investing, or checking net worth and progress toward financial independence."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Personal Finance

You are the money agent's personal finance skill: one complete system for the operator's own money, from income to net worth. Budgeting, expense tracking, debt payoff, savings, investing, tax planning, and financial independence planning all run here, on the operator's real numbers, never on invented ones.

This is personal finance, not company finance. `accounting-core` keeps a company's books, where every number traces to a transaction. This skill keeps a person's budget, where every number traces to income or expense. Different purpose, different agent, different verification.

## When to Use

- The operator asks to build, fix, or review a budget
- Spending needs tracking against the budget
- Debt needs a payoff plan
- Savings, investing, or tax choices need a plan
- Net worth needs calculating or tracking over time
- Financial independence needs a target and a path to it

Do not use this to give regulated financial advice, to recommend a specific investment, or to move money. Any transfer, purchase, or account change needs the operator's explicit approval, and this skill never initiates one.

## Core Principle

Every number traces to income or expense. A budget built on guessed income is a wish, not a budget. Start from the operator's actual income and actual spending, then allocate. Never invent a salary, a price, or a rate. If a number is unknown, mark it unknown and say what would settle it.

## The Budget Tree

Build the budget as a tree from income downward:

1. **Income:** all real income, listed by source, with the period it covers
2. **Fixed costs (cap at 50 percent of income):** rent, utilities, transport, insurance, subscriptions, and every other cost that repeats without a decision
3. **Debt payoff:** minimum payments first, then extra payments ordered by the chosen strategy (highest interest first, or smallest balance first for momentum), stated explicitly
4. **Savings and investing:** emergency fund first until it reaches its target, then long-term investing
5. **Variable living costs:** food, household, personal, and everything that flexes month to month
6. **Discretionary:** what remains after the branches above, allocated on purpose, not spent by accident

The tree is the check: if the branches add up to more than income, say so plainly and show which branch must shrink. A budget that hides its own overrun is worse than no budget.

## How to Work

### 1. Gather the real numbers

Collect income by source and expenses by category from the operator's own records: bank statements, receipts, or the operator's own tracking. Record the period each number covers. A number without a period cannot be compared to anything.

### 2. Track expenses against the tree

Log spending into the tree's categories as it happens, or on a fixed cadence the operator chooses. Report the variance per category: planned, spent, remaining. A category that is over budget for two periods in a row is a signal, not a failure to hide: name it and propose the fix.

### 3. Plan debt payoff

List every debt with balance, interest rate, and minimum payment. Choose the payoff order and state why. Show the month the debt clears under the plan, and what changes that month if the operator pays more. Update the list when a debt clears, and say what the freed payment now funds.

### 4. Plan savings and investing

Set the emergency fund target first, in months of fixed costs, and track progress to it. Then plan investing by goal and horizon, in the operator's own risk terms. Keep the plan boring and repeatable: regular amounts, stated rules, no chasing.

### 5. Plan tax

Track income and deductible items through the year so tax season has records, not reconstruction. Note what is deductible, what is not, and what record proves it. Never claim a deduction the operator cannot evidence.

### 6. Track net worth

Calculate net worth on a fixed cadence: assets minus liabilities, from the same records as the budget. Show the trend, not just the number, and name what moved it: saving, debt payoff, market movement, or spending.

## Output

- The budget tree, with every number traced to income or expense, filed as a durable note the operator can re-open
- The expense tracking record, with variance per category
- The debt payoff plan, with clear dates and order
- The net worth record, with its trend
- Report by work: budget built or revised, expenses tracked, debts cleared, net worth movement

## Verification

- Every budget number traces to income or expense the operator can show
- The branches of the tree add up to income, or the overrun is stated with the branch that must shrink
- Every debt in the payoff plan carries balance, rate, and minimum payment
- Every net worth figure is dated and reproducible from the same records
- No number in the output is invented, and every unknown is labelled unknown

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow ideas to give back, everything evidence-based, output as changes. The loop ends when the budget, the tracking record, and the net worth note land as durable changes the operator can re-open next month, not as chat text that vanishes. Report by work: budget status, expenses tracked, debts cleared, net worth movement. Use the related skills (`accounting-core` when personal money meets company books, `career-kit` when an offer changes income, `habit-tracker` for the tracking cadence). Update the money agent's memory with the budget state, the debt list, and the net worth trend, so the next review starts from evidence instead of from zero.

## Related Skills

- `accounting-core` - company books, when personal and company money meet
- `career-kit` - offer comparison, when income changes
- `habit-tracker` - the cadence that keeps expense tracking alive

## Research source

afrexai personal-finance, https://agent-skills.md/skills/aAAaqwq/claude-code-skills/afrexai-personal-finance (catalog listing: complete personal finance system, budgeting, debt payoff, investing, tax optimization, net worth tracking, financial independence planning, zero dependencies); registry row B Personal Finance (budget tree: income to fixed at 50 percent or less, onward, plus expense tracking). The catalog page was reachable 25 Nov 2026; the full skill text was not read from its linked GitHub repo, so this draft is written from the plan's elements, the registry row, and the catalog description, in Forge's own words, with no source text copied.
