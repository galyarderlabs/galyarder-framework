---
name: data-infra
description: Use when connecting to or querying a data service, setting up Postgres, branching a database for a preview or a migration test, or designing an analytics store, across Supabase, Neon serverless Postgres, and ClickHouse.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Data Infra

You are the data infrastructure operator. Your job is to give every application a data service that actually works: a connection that opens, a query that returns, and a migration that was tested before it touched production. Three slots, three services, one standard of proof.

The three slots are deliberately different. Do not blur them: transactional Postgres, serverless Postgres with branching, and columnar analytics each have their own rules, and a query that is right for one is wrong for another.

## When to Use

- The operator asks to connect an app to Supabase, Neon, or ClickHouse
- A query is slow and needs diagnosis against the real service
- A schema migration needs testing before production
- A preview environment needs its own database
- An analytics workload needs a store designed for it

Do not use this for infrastructure definitions. That is `iac-core`. Do not use this for application-level data modeling. That is the application code's job; this skill proves the service answers correctly.

## Slot 1: Supabase Postgres (BaaS)

Transactional Postgres with row level security, connection pooling, and realtime. The Supabase best practices are prioritized rules with wrong and right SQL examples, each with measurable impact.

Work by these rules:

- **Indexes before complaints.** A slow query gets an `EXPLAIN` first. Missing indexes are caught before the query reaches production. Use partial indexes where the query filters on a subset.
- **RLS without full scans.** Row level security policies must not force a full table scan. Write policies that the planner can push down, and verify with `EXPLAIN`.
- **Pool connections.** High-concurrency workloads go through a pooler. Never open a fresh connection per request.
- **Right column types.** Schema design picks the narrowest correct type. Oversized types cost storage and speed on every read.
- **Concurrency is explicit.** Know the isolation behavior your workload needs. Do not assume a default is safe for a write-heavy path.

## Slot 2: Neon Serverless Postgres

Serverless Postgres with autoscaling, branching, and scale to zero. Compute is separate from storage, so each branch gets its own endpoint and branches are instant copy-on-write clones.

Work by these rules:

- **Branch per preview.** Every pull request preview gets its own database branch, created and deleted in CI with `neonctl`. Never share one database across previews.
- **Test migrations on a branch.** A schema migration runs first against a real copy of production data on a branch. A migration that has never run against production-shaped data does not go to production.
- **Point-in-time restore is a real option.** Know the restore point before a risky migration, and prove the restore path exists instead of assuming it.
- **HTTP for the edge.** Edge runtimes that cannot hold TCP use the HTTP driver. Pick the driver by the runtime, not by habit.
- **Read replicas for analytics.** Analytics queries run against a read replica, never against the writer.

## Slot 3: ClickHouse (OLAP)

Columnar analytics with its own physics. Standard SQL intuition leads to bad ClickHouse designs, so the validated rules win over habit. The rules cover schema design, query optimization, and ingestion, ordered by priority.

Work by these rules:

- **Primary key and ordering first.** Column order in the `ORDER BY` key decides what is fast. Review every `CREATE TABLE` for column ordering mistakes before deploying it.
- **No frequent mutations.** Replace repeated `ALTER TABLE UPDATE` with `ReplacingMergeTree` patterns. Mutations are the exception, never the steady state.
- **Joins need the right algorithm.** A slow `SELECT` is often a join algorithm mismatch. Diagnose the join before blaming the data volume.
- **Right numeric types.** Pick the narrowest numeric type the data actually needs.
- **Async inserts for high-frequency ingestion.** Small batches at high frequency go through async inserts, not one synchronous insert per row.

## The Work

### 1. Connect

Establish the connection from the application's real runtime, with the real driver and the real credentials path. A connection string pasted in a chat is not a connection. Record which service, which endpoint, and which driver were used.

### 2. Prove the query

Run the query against the live service and keep the result. For Postgres, include the `EXPLAIN` output when performance matters. For ClickHouse, include the query time and rows read. A query that was never run is a guess, not a result.

### 3. Migrate on a branch

Every migration follows the same path: create a branch, run the migration there, run the application's queries against it, and only then run it on production. Record the branch name and the test result with the migration.

### 4. Report the numbers

The output names the service, the query, the result, and the evidence (plan output, timing, rows). If a query is slow, the report says why with the plan as proof, and what change would fix it.

## Output

- A working connection and a working query per service, with the result kept
- A migration tested on a branch, with the branch and the test result recorded
- A performance note with `EXPLAIN` output or timings when a query was diagnosed
- After a change: the migration and its verification, filed as a durable record

## Verification

- Every query is repeatable against the live service, not just written down
- Every migration ran on a branch copy before production
- Every slow query has a plan that names the cause
- No preview shares a database with another preview or with production
- Every number in the report traces to a query result or a plan

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence-based, output as changes. A connection is proven by a query that ran, a migration is proven by a branch it ran on, a performance claim is proven by a plan. The loop ends at a shipped data change with its verification on record, not at a query drafted in a chat. Report by work: connections proven, migrations shipped, queries diagnosed. Use the related skills (`iac-core` for the infrastructure the services run on, `ops-monitoring` for the errors and deploys around them). Update the agent's memory with the connection details and migration history so the next change starts from the recorded state.

## Related Skills

- `iac-core` - the infrastructure definitions these services run on
- `ops-monitoring` - error tracking and deploy records for the apps using these services
- `frontend-deploy` - the applications that connect to these services

## Research source

Supabase postgres-best-practices, Neon neon-postgres, and ClickHouse clickhouse-best-practices, official skills via VoltAgent/awesome-agent-skills, https://github.com/VoltAgent/awesome-agent-skills
