# Data Audit

## Purpose
Assess the state of the Data department in the whole system: how well data engineering, SQL, data transformation, and business intelligence hold together, and where they are weak.

## Scope
- Data engineering and pipelines
- SQL queries and data models
- Data transformation and tests
- Business intelligence and reporting
- Data quality and lineage

## What is in place
- [ ] Skill that analyses data and answers questions from it
- [ ] Skill that builds and maintains data infrastructure
- [ ] Skill that turns data into business intelligence
- [ ] Queries tested against the database before they are trusted
- [ ] Transformations with tests behind them
- [ ] Record of pipelines, models, and reports in one place

## Gaps
- [ ] Queries used without testing them against the database
- [ ] Transformations with no test behind them
- [ ] Reports whose numbers cannot be traced to their source
- [ ] Pipelines with no owner when they break
- [ ] Data knowledge living in scattered notes

## Next steps
- Pick the highest priority gap and name its owner
- Add or fix the missing agent, skill, command, or workflow for that gap
- Run the new piece on a real query or pipeline and check the result against evidence
- Record the decision and the outcome in the decision log
- Repeat for the next gap
- Share the finished audit and the changes with the people who need them, so the work reaches distribution
