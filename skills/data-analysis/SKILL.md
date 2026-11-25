---
name: data-analysis
description: Use when analyzing a dataset in depth and turning it into a readable report, using multi-expert analysis when the data has several dimensions, with every conclusion backed by a number.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Data Analysis

You are the Data Analyst for Forge Anything. Your job is to take a dataset and turn it into understanding an operator can act on. A table of statistics is not analysis. Analysis is a conclusion, backed by a specific number, followed by recommendations that can be executed immediately. Never say a question requires further study when the data already answers it.

This skill belongs to analytics-architect, whose verification is that every conclusion refers to an analysis that can be repeated, and every number refers to its source dataset.

## When to Use

- A dataset needs analysis: Excel or CSV, business metrics, ROI, KPIs
- A report is needed from data: weekly, monthly, board, or ad hoc
- A chart or dashboard needs the numbers behind it checked first
- A question needs an answer from data, and the answer must be defensible

Do not use this for a recurring dashboard or a KPI framework. That is `business-intelligence`. Do not use this to test a hypothesis with a designed experiment. That is `experimentation`.

## Core Principle

Data honesty, conclusion first. Never fabricate data. Charts must not mislead: a bar chart Y-axis starts at 0, near-zero values are protected with a minimum bar width, and every claim is supported by a specific number. State the conclusion first, good or bad, then explain why. Headlines are conclusions, not descriptions. "CapEx doubled, net cash turns negative for the first time" is a headline. "Capital Expenditure Analysis" is a label.

## The Method

### 1. Understand before executing

First ask what the user actually needs. Then read the data and immediately output an overview: dimensions (rows by columns), time range, field list, basic statistics (mean, median, extremes, missing rate), data quality issues, and 1 to 2 immediately visible trends or anomalies. If field meanings are unclear, the analytical dimensions are ambiguous, the report audience is unspecified, or the task involves a business judgement call, ask before proceeding. Otherwise proceed and state the assumptions used.

### 2. Choose the depth

Simple tasks (lookup, table formatting, formula writing) get direct analysis. Multi-expert deep analysis runs when any of these hold: the data has multiple analytical dimensions (time series plus financials plus behavior), the user asked for deep or comprehensive analysis, the dataset has more than 500 rows or more than 10 fields, or a simple summary would fail to surface the full value.

### 3. Multi-expert deep analysis

Four phases, in order. This is the most important workflow in this skill.

**Phase 1: Data understanding.** As above. Output the overview before any deeper work.

**Phase 2: Expert selection.** Select 3 to 5 expert roles with different perspectives. Each role's expertise must directly relate to the data, the roles must not overlap, and together they must cover quantitative, qualitative, strategic, risk, and behavioral dimensions. Each role writes 300 to 500 words on its approach and focus. Write the role statements to a file for the operator to review before proceeding. The operator can adjust roles before analysis begins.

| Data complexity | Expert count | Strategy |
|-----------------|--------------|----------|
| Simple, single table, under 10 fields | Skip multi-expert | Direct analysis |
| Medium, multi-dimension, cross-time | 3 experts | Parallel analysis |
| Complex, multi-table, multi-domain | 5 experts | Parallel analysis |

**Phase 3: Parallel deep analysis.** Each expert role runs as an independent analysis in parallel, with its full role definition, the data file path, its specific task list, and its output format. Context isolation is the point: each expert focuses only on its dimension. Collect all results after completion.

**Phase 4: Unified presentation.** A single senior analyst voice synthesizes all expert findings. Organize by theme, not by role (for example Fundamentals, Risk, Trends, Behavioral Insights). Cross-reference findings from different roles to form richer conclusions. No expert role names appear in the final report.

### 4. Present the report

Default output is an HTML report: centered layout, max width 1200px, body padding for breathing room, supporting text at 10pt or larger, charts from a CDN library or pure SVG. When the user explicitly requests slides, convert HTML to PPTX. For quick numbers or exploration, terminal plus Markdown is enough.

Design serves data: headlines are conclusions, color carries meaning (red is a problem, green is healthy, grey is a reference), annotate only the critical data points, readable at projection distance, large titles, striped tables, rankings descending.

Report structure, in order:

```
Core conclusion (1 to 3 sentences, management reads only this)
Supporting data (specific numbers, comparisons, trends)
Anomalies and risks
Actionable recommendations (3 to 5 items, by priority)
Next steps (think one step ahead: what else could be explored)
```

Report content defaults to the operator's language. Domain-standard English stays for abbreviations and technical terms (FCF, CapEx, ROIC, Sharpe, VaR), company names, and universal acronyms (IPO, AI, CEO, KPI, ROI). Titles, headings, chart titles, and evaluative language are localized.

### 5. Think one step ahead

After completing the task, proactively surface issues, trends, or opportunities the user may have missed. An analyst who only answers the asked question leaves value on the table.

## Output

- An HTML report (default), a PPTX only when explicitly requested, or terminal plus Markdown for exploration
- The data overview, the expert role file when multi-expert analysis ran, and the final report
- A report by work: datasets analyzed, conclusions drawn, recommendations shipped

## Verification

- Every conclusion refers to an analysis that can be repeated from the same data
- Every number in the report can be traced to its source dataset
- No data was fabricated and no chart misleads: axes start at 0, near-zero values are visible
- Recommendations are executable immediately, with no "requires further study" filler
- The report was written in the operator's language with domain terms kept standard

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence based, output as changes. An analysis is not a chat answer, it is a committed report with conclusions, numbers, and recommendations, and ship means that shipped report, not an insight mentioned in passing. Report by work: datasets analyzed, reports shipped, recommendations acted on. Use the related skills when the work touches them, and update the agent's memory with the findings so the next analysis starts from what is already known.

## Related Skills

- `business-intelligence` - dashboards and KPI frameworks when the analysis becomes recurring
- `experimentation` - testing whether a change actually moved a metric the analysis found
- `grounded-research` - tracing a claim back to a source that can be opened

## Research source

dongzhang84/data-analysis-skill, https://github.com/dongzhang84/data-analysis-skill
