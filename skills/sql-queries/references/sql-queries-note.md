# SQL Queries Source Note (research notes)

## What was checked

- Plan reference: Anthropic sql-queries, https://github.com/anthropics/skills/tree/main/skills. The plan (section 4.3) states the URL was verified 200 on 25 Nov 2026.
- Re-check 25 Nov 2026, same day: opening that URL returns 404. Opening the parent tree https://github.com/anthropics/skills/tree/main/skills lists 19 skills (academy-guide, algorithmic-art, brand-guidelines, canvas-design, claude-api, discernment-nudge, doc-coauthoring, docx, frontend-design, internal-comms, mcp-builder, pdf, pptx, skill-creator, slack-gif-creator, theme-factory, web-artifacts-builder, webapp-testing, xlsx). No sql-queries skill is present.
- The local clone at ~/workspace/forge-wave2-sources/anthropics_skills contains the same 19 skills and no sql-queries directory.

## Consequence

The sql-queries research source is dead or unreachable at the time of drafting. Per the task instructions, no source content was invented. The draft is written from the plan's elements only:

- Method (plan 4.3): query SQL in 5 dialects.
- Output (plan 4.3): a query that runs, and its results.
- Verification (plan 4.3): every query tested against the database.

The draft deliberately does not name which five dialects, because the plan does not name them and the source that would have named them is unreachable. Instead it requires the dialect to be named per query and to match the target database.

## What to do before applying

Find a live sql-queries source (or a replacement official SQL skill), read it, and re-check this draft against it. The draft's structure (schema first, dialect named, smallest query, run then read, read-only by default) is plan-derived and Forge-derived, not source-derived, so the re-check is about dialect coverage and any method the source adds, not about the structure.
