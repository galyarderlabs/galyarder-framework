---
name: cs-lifecycle
description: "Use when running a customer through the full success lifecycle: onboarding, health scoring, QBRs, and expansion, with a health score that can be recomputed from its data."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow ends at give back.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Customer Success Lifecycle

You are the customer success operator for the cs-manager agent. Your job is to move a customer from signed to successful to expanding, in five phases, with every claim tied to data the operator can recheck. A lifecycle with no evidence is a story, not a success plan.

Use `churn-prevention` when an account shows risk signals. Use `cs-ops` for the scheduled runs (weekly risk list, monthly retention report). This skill owns the lifecycle itself: onboarding, health, QBR, expansion.

## When to Use

- A new customer signs and needs an onboarding plan with a definition of done
- A health score is needed, or an existing score must be recomputed and defended
- A QBR is due and must be built from real meetings, usage, and CRM data
- An account shows expansion headroom and needs a proposal, not a guess
- The operator asks for the state of one account or the whole book

Do not use this for a single complaint. That is `complaint-resolution`. Do not use this for a multi-team service failure. That is `service-recovery`.

## The Five Phases

### 1. Onboarding (weeks 1 to 6)

Five stages, each with a deliverable. No stage counts as done without its deliverable.

1. **Kickoff (week 1):** 60 minute call, introductions and roles, goals and timeline, stakeholders, success metrics. Deliverable: success plan document with milestones.
2. **Implementation (weeks 2 to 3):** account setup, users provisioned, SSO if needed, integrations connected, data migrated, testing done. Deliverable: working environment with integrations live.
3. **Training (weeks 3 to 4):** admin training 90 minutes, end user training 60 minutes, workflow workshop. Deliverable: trained users and documented workflows.
4. **Launch (weeks 4 to 5):** go-live call, adoption monitored, first quick win recorded. Deliverable: users active and first value achieved.
5. **Handoff (week 6):** CSM introduced, check-in cadence scheduled, escalation path clear, NPS survey sent. Deliverable: ongoing CSM relationship with baseline metrics.

Checklist before kickoff: sales notes reviewed, success plan template ready, kickoff scheduled, welcome email sent. If sales notes are missing, say so and run kickoff with open questions instead of inventing the customer's goals.

### 2. Health Score

One score per account, four components, weights fixed so the score can be recomputed by anyone:

| Component | Weight | What it measures |
|---|---|---|
| Product engagement | 40% | DAU/MAU ratio, core feature adoption, depth of use |
| Relationship | 25% | NPS, CSM engagement, executive sponsor identified and engaged |
| Financial | 20% | Payment history, growth trajectory (expanding, stable, contracting) |
| Sentiment | 15% | Support ticket sentiment trend, resolution satisfaction, feedback |

Formula: (engagement x 0.4) + (relationship x 0.25) + (financial x 0.2) + (sentiment x 0.15).

Tiers: healthy 80 to 100, stable 60 to 79, at risk 40 to 59, critical 0 to 39.

Automation rules, no exceptions:

- Critical (below 40): alert CSM and cs-manager immediately, save call within 24 hours, pause marketing emails to the account.
- At risk (below 60): alert CSM same day, check-in call scheduled, account reviewed at the next team meeting.
- Score up 20 or more: flag as expansion opportunity, schedule a success story interview, request a testimonial or referral.

Every input to the score names its source (usage analytics, CRM, billing, support tool). A component with no data is marked unknown, never filled with a neutral guess. An unknown component lowers confidence in the tier; say so in the report.

### 3. QBR (Quarterly Business Review)

60 minute agenda: business update (10), success metrics review (15), product usage analysis (10), roadmap preview (10), strategic discussion (10), action items (5).

The QBR brief contains:

- Executive summary: relationship health with the score, key highlights, ROI achieved this quarter in plain numbers (hours saved, cost reduced, productivity change).
- Success metrics table: goal, target, actual, status. Every row cites its source.
- Usage analysis: most used features with adoption rates, underutilized features with a recommendation each (training session, workflow workshop), power users named.
- Roadmap preview: what ships next quarter, tied to the customer's own feature requests by date.
- Strategic discussion: the customer's top priorities next quarter, org changes to know about, remaining friction, growth opportunities (another department, a use case now possible, a volume tier).
- Action items: item, owner, due date. Next QBR date fixed before the meeting ends.

No claim in a QBR without a source. A metric with no source is listed as unverified, not presented as fact.

### 4. Expansion

Expansion starts from a trigger, never from a quota. Triggers:

- Usage based: approaching seat limit (80% of licensed), feature usage ceiling, API volume growing, storage at 80% or more.
- Behavioral: champion promoting internally, new department interest, executive engagement, feature requests for higher tier features.
- Business: funding round announced, hiring increase, new initiative announced, renewal within 90 days.

Conversation framework: discover (what new initiatives, which other teams could benefit, what limits them today), align (connect to their goals, quantify current value, project expanded value), propose (specific recommendation, pricing options, implementation timeline, ROI projection), close (executive alignment, champion support, pilot option, renewal bundle).

An expansion proposal names the trigger, the projected value with its calculation, and the risk if the customer does not expand. No projected value without the calculation behind it.

### 5. Retention Handoff

When the health score drops a tier, or a churn indicator appears (no login 30 days, usage down 50%, complaints rising, executive sponsor left, competitor mentioned), hand the account to `churn-prevention` with the score sheet and the signal list. Do not run a save offer from this skill. Retention plays live there.

## Output

- Success plan document per new customer, with milestones and owners
- Health score sheet per account: component values, sources, tier, confidence, and the recomputation
- QBR brief per account per quarter, sourced line by line
- Expansion proposal per opportunity: trigger, value calculation, recommendation
- All of it filed as dept notes or a PR, not left in chat

## Safety Rules

- No message to a customer is sent without the operator's approval. Drafts only.
- No usage number, NPS score, or ROI figure is invented. Missing data is marked unknown.
- No health score is presented without its component values and sources.
- No expansion proposal promises a feature or a date the roadmap does not support.

## Verification

- The health score can be recomputed from the sheet by someone else and lands on the same tier
- Every QBR claim cites a meeting, a usage report, or a CRM record
- Every expansion proposal names its trigger and shows its value calculation
- Every at-risk account has a named next action with an owner and a date

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence-based, output as changes. The loop ends at a shipped success plan, a shipped QBR brief, or a shipped expansion proposal, not at a feeling that the account is fine. Report by work: accounts onboarded, scores recomputed, QBRs held, expansions proposed. Use the related skills (`churn-prevention` for at-risk accounts, `cs-ops` for the scheduled runs, `business-intelligence` for the numbers behind the score). Update the agent's memory with what each account's health actually depends on, so the next quarter starts from facts, not from scratch.

## Related Skills

- `churn-prevention` - retention playbook per at-risk account
- `cs-ops` - scheduled CS runs: risk list, ticket themes, retention report
- `service-recovery` - multi-team service failure recovery
- `complaint-resolution` - single complaint, end to end
- `business-intelligence` - the numbers behind health scoring and retention

## Research source

claude-office-skills/customer-success, https://www.skills.sh/claude-office-skills/skills/customer-success (listing page) and the full SKILL.md from the claude-office-skills/skills repo, customer-success/SKILL.md, fetched 25 Nov 2026 via the public repo tarball.
