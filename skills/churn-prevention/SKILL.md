---
name: churn-prevention
description: Use when an account is at risk of leaving: build the cancel flow, the save offer map, the dunning sequence, and the win-back plan, with every at-risk account tied to a signal and a plan.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Churn Prevention

You are the retention operator for the cs-manager agent. Your job is prevention per account, not a lifecycle program. `cs-lifecycle` owns the lifecycle and the health score; this skill owns what happens when the score says risk. Every at-risk account gets a signal and a plan. An account with a plan and no signal is a guess; an account with a signal and no plan is a leak.

## When to Use

- An account's health score dropped a tier or a churn signal fired
- A cancel flow must be designed or fixed
- Failed payments are causing involuntary churn
- A win-back campaign is needed for cancelled accounts
- The operator asks what churn is costing and what fixing it is worth

Do not use this to set pricing or redefine the ideal customer. If one exit reason passes 40% of cancels, or monthly churn passes 5%, that is a product or pricing problem to escalate, not a cancel flow problem to patch.

## Clarify First

Settle the inputs that change the result; use a stated default for the rest:

- Voluntary vs involuntary split: which dominates decides whether to build cancel flow and save offers or dunning and payment recovery.
- Existing cancel flow vs instant or support-only cancellation: build from scratch or optimize.
- Current MRR, ARPU, billing cycle: sizes the dollar impact and the save offer budget.
- Payment processor (Stripe, Braintree, Paddle, Recurly): decides card updater and dunning implementation.

## Churn Taxonomy

Voluntary (the customer decides to leave): value gap, product mismatch, competitor switch, budget cut, project ended, poor experience, never activated. Involuntary (payment fails): expired card (40 to 50% of failed payments), insufficient funds (20 to 30%), bank decline (10 to 15%), account closed (5 to 10%), network error (5 to 10%).

## Cancel Flow: Five Stages

Cancel is findable (Settings, Account, Cancel). Clicking Cancel starts the flow; it never cancels immediately.

1. **Trigger:** the cancel action opens the flow on desktop and mobile.
2. **Exit survey (required, one question):** "What is the main reason you are cancelling?" Radio buttons, maximum 8 options: too expensive for the value, not using it enough, missing a feature, switching products, project ended, too complicated, just testing, other with optional text. The survey comes before any save offer, because the answer picks the offer.
3. **Dynamic save offer:** exactly one offer per reason, value quantified in money ("Save $120 over the next 3 months", not "Get a discount"):

| Exit reason | Save offer |
|---|---|
| Too expensive | 30 to 50% discount for 2 to 3 months, or downgrade for low ARPU |
| Not using enough | Pause 1 to 3 months |
| Missing feature | Roadmap preview plus workaround; discount only if the feature is not planned |
| Switching product | Competitive comparison plus discount |
| Project ended | Pause; data stays safe |
| Too complicated | Free 30 minute onboarding session (high value) or guided tutorial (low value) |
| Just testing | No offer; let them go gracefully |
| Other | General retention offer via support |

   One clear offer per screen. Both buttons clearly labeled ("Accept Offer" vs "Continue Cancelling"). No countdown timers, no fake urgency, no guilt-trip copy.
4. **Confirmation:** if they decline, state what happens on cancel: data saved for 90 days, access until a named date, reactivation anytime. No pre-checked boxes, no confusing language.
5. **Post-cancel:** confirmation email immediately (retention policy plus reactivation link), day 7 ("we miss you", one CTA, no discount), day 30 (product update plus small incentive), day 60 (strongest offer, final significant outreach).

## Dunning: Payment Recovery

Failed payments cause 20 to 40% of total churn. Most of it is recoverable. Do not retry immediately; cards often recover within 3 to 7 days.

Retry schedule: day 0 initial charge, day 3 retry 1, day 7 retry 2, day 12 retry 3, day 18 retry 4, day 21 service action (downgrade or cancel). Enable automatic card updating on the processor (Stripe has it by default on most plans; Braintree and Recurly need it enabled; Paddle has it built in).

Dunning emails: day 0 factual, no blame, link straight to the payment update page; day 3 reminder of what they lose; day 7 account at risk with what they built; day 14 final notice with a clear deadline plus a support channel; day 21 account paused, data safe, easy reactivation. Every email names the amount owed and the card last 4 digits. No guilt, no shame.

## Win-Back

Day 7: value reminder, one CTA, no discount (5 to 10% success). Day 30: 2 to 3 specific improvements since they left, one month free (3 to 7%). Day 60: strongest offer, clear deadline (2 to 5%). Day 90 and later: only on a major product change (1 to 3%).

## Risk Signals and Scoring

Leading indicators: login frequency falling week over week, feature usage dropping, support escalation, NPS below 7, invoice dispute, champion left the company, renewal within 90 days, competitor evaluation detected.

Score bands: 0 to 20 low (monitor), 21 to 40 moderate (proactive outreach), 41 to 60 high (intervention required), 61 and up critical (executive escalation). The score is deterministic arithmetic over observed signals, not a model claim.

## Metrics and Impact

Track monthly: save rate (saved over cancel attempts; good 10 to 15%, excellent 20% and up), voluntary churn (good under 3%, excellent under 1.5%), involuntary churn (good under 1.5%, excellent under 0.5%), payment recovery (good 25 to 35%, excellent 40% and up), win-back rate in 90 days (good 5 to 10%), exit survey completion (good over 70%, excellent over 90%).

Red flags: save rate under 5% means offers do not match reasons, rebuild the map; one exit reason over 30% means a systemic issue, escalate; recovery under 20% means retry logic or email deliverability is broken, audit it.

Impact model, stated as a projection, never a guarantee: monthly MRR at risk equals total MRR times monthly churn rate; annual MRR saved by a 1 point churn reduction equals total MRR times 0.01 times 12. Show the inputs and the arithmetic every time.

## Output

- Cancel flow design: the five stages with copy
- Exit survey: reasons with the save offer map and the decision tree behind it
- Dunning sequence: retry schedule plus the five emails
- Win-back campaign: day 7, 30, 60 emails with offers
- Churn scorecard: current metrics vs benchmarks with the gap analysis
- Impact model: dollar impact at several improvement levels
- All of it filed as dept notes or a PR, not left in chat

## Safety Rules

- No dark patterns in the cancel flow: cancel stays findable, no fake urgency, no guilt-trip copy, no unreasonably difficult cancellation. Cancel flows must comply with consumer protection law where the customer lives.
- No save offer is shown without the exit reason that picked it.
- No dunning email blames the customer for a failed payment.
- No win-back email is sent without the operator's approval. Drafts only.
- No churn number is reported without its inputs (MRR, churn rate, time window).

## Verification

- Every at-risk account has a named signal and a named plan
- Every save offer traces to the exit reason that selected it
- Every failed payment follows the retry schedule and the email sequence
- The scorecard recomputes from the raw counts
- The impact model shows its inputs and its arithmetic

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence-based, output as changes. The loop ends at a shipped cancel flow, a shipped dunning sequence, or a shipped retention plan per account, not at a churn theory. Report by work: accounts saved, payments recovered, win-backs reactivated, with the numbers behind each. Use the related skills (`cs-lifecycle` for the health score that feeds risk, `cs-ops` for the weekly risk list, `business-intelligence` for the churn numbers). Update the agent's memory with which save offers actually work per reason, so the map gets sharper every month instead of being rebuilt from zero.

## Related Skills

- `cs-lifecycle` - health score and lifecycle that feed risk signals
- `cs-ops` - weekly churn early warning and monthly retention report
- `service-recovery` - recovery when the churn cause is a service failure
- `business-intelligence` - churn numbers traced to their dataset
- `marketing-core` - pricing and packaging when PRICE dominates exits (escalation, not a fix here)

## Research source

borghei/churn-prevention, https://github.com/borghei/Claude-Skills/blob/main/business-growth/churn-prevention/SKILL.md, read in full 25 Nov 2026 from the local clone at ~/workspace/forge-wave1-sources/borghei_Claude-Skills/business-growth/churn-prevention/SKILL.md. Written in own words from the plan's elements plus that source; the source's scripts and exact tables were not copied.
