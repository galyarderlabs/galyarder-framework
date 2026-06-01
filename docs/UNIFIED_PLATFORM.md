# Galyarder Ecosystem: Unified Agentic Company Platform

The Galyarder ecosystem is a modular agentic-company platform where Framework, Agent, HQ, and Ledger work together without forcing everything into one monolithic app.

## The vision

One coordinated environment where you can:

1. **Structure work** with Framework agents, skills, commands, and review protocols.
2. **Stay connected** through Galyarder Agent's memory, channels, and tools.
3. **Govern execution** through Galyarder HQ's goals, approvals, departments, reports, and operating visibility.
4. **Preserve evidence** through Ledger-backed finance and operational records where needed.
5. **Scale across projects** while keeping a shared execution model.

## Distributed architecture

```text
       [ GALYARDER HQ ]
       command and visibility
  ______________|________________
  |             |               |
[ Project A ] [ Project B ] [ Project C ]
  docs/issues   docs/issues     docs/issues
      |              |              |
      |       [ GALYARDER FRAMEWORK ]
      |        intelligence layer
      |              |
      +------ [ GALYARDER AGENT ]
              continuity and tools
```

1. **Galyarder Framework** provides the agent profiles, skills, commands, and operating protocols.
2. **Project Operating Structure** is created by `galyarder scaffold` so each project has a place for plans, reports, departments, and decisions.
3. **Galyarder HQ** discovers and displays the operating state.
4. **Galyarder Agent** connects the workflow to real channels and tools.
5. **Galyarder Ledger** can be added for financial execution, approvals, and evidence-heavy work.

## Implementation protocol

### 1. Intelligence injection

Install Framework to give your agents reusable operating protocols instead of one-off prompts.

### 2. Project scaffolding

Run `galyarder scaffold` in your project root to create a structure HQ and agents can read:

- `docs/departments/`: department reports and durable operating knowledge.
- `docs/plans/`: execution blueprints and implementation plans.
- `docs/reports/`: status updates, audit notes, release reports, and decision summaries.

### 3. HQ discovery loop

Galyarder HQ reads the project structure to:

- map active work by department;
- show blocked or completed work;
- surface reports and decisions;
- connect project state back to goals, approvals, and operating history.

## User experience

### Standalone Framework

1. Work through your AI assistant or coding tool.
2. Use Framework commands and skills for planning, implementation, review, docs, and release.
3. Read generated plans, reports, and diffs directly in the project.

### Framework + Agent + HQ

1. Talk to Galyarder Agent through the configured channel.
2. Let Framework route the work to the right specialist workflow.
3. Open Galyarder HQ to inspect goals, reports, departments, approvals, and activity.
4. Add Ledger when the workflow needs finance, sales, accounting, audit, tax, approvals, or evidence-backed records.

## Conclusion

The unified platform keeps each layer clear. Framework defines how work is done. Agent gives it continuity. HQ gives it command visibility. Ledger gives financial execution an evidence trail.

Together, they turn loose AI-agent usage into structured agentic company execution.
