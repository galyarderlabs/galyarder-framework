---
name: founder-context
tools: [read_file, grep_search, glob, run_shell_command, write_file, replace]
description: Founder Operating Context. Use to create or update the canonical founder/startup context document so every fundraising, growth, product, and recruiting workflow runs on concrete company facts instead of generic assumptions.
model: inherit
---

# FOUNDER CONTEXT: CANONICAL STARTUP MEMORY

This skill establishes the operating context for a solo founder or lean founding team. It should be used before high-leverage founder workflows such as fundraising, investor communication, GTM planning, hiring, or strategic roadmap work.

## When To Use
- The founder is setting up the project for the first time.
- The user says "let me tell you about my startup", "set up founder context", or similar.
- A downstream founder skill needs context that does not yet exist.
- Major company facts have changed: pricing, stage, raise target, GTM motion, ICP, traction, runway, or team.

## Required Output
Create or update `.agents/founder-context.md` in the project root.

## Workflow
1. Check whether `.agents/founder-context.md` already exists.
2. If missing or stale, gather facts from the founder in compact rounds.
3. Write a factual context document. Do not hallucinate unknowns.
4. Mark unknown fields as `TBD`.
5. Reuse this file as the source of truth for fundraising, board updates, growth, recruiting, and roadmap work.

## Context Structure
```markdown
# Founder Context

## Company
- Name
- One-liner
- Stage
- Founded
- Location
- Legal entity

## Product
- What it does
- Category
- Platform
- Tech stack
- Current product state

## Market
- Target customer
- ICP
- Core pain point
- Competitors
- Positioning

## Business Model
- Revenue model
- Pricing
- Current revenue
- Key metrics

## Team
- Founders
- Team size
- Key hires needed
- Advisors / board

## Fundraising
- Total raised
- Last round
- Current runway
- Next raise target
- Use of funds

## Goals
- Next 3 months
- Next 12 months
- Biggest constraint right now
```

## Interview Sequence
### Round 1
- What does the company do, in one sentence?
- Who is it for?
- What stage are you at?
- How do you make money?

### Round 2
- Who is the ICP?
- What traction do you already have?
- Who are the main competitors?
- What is different about you?

### Round 3
- Who is on the team?
- How much runway do you have?
- What are you trying to accomplish in the next 90 days?
- Are you fundraising now or soon?

## Rules
- Keep this document factual, not aspirational.
- Update it when new information materially changes the operating picture.
- Downstream founder skills should read this first before producing output.
