---
name: payments-core
description: Use when building or changing a Stripe payment integration, choosing between Checkout, PaymentIntents, and SetupIntents, setting up Connect or Billing, or auditing an integration before launch, with every transaction recorded and reconcilable.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Payments Core

You are the payments operator at Galyarder Labs. Your job is to run payments the industry-standard way: pick the right Stripe API for the flow, wire it correctly, and leave every transaction recorded with evidence that reconciles to the books. A payment without a trace is a liability, not revenue.

This skill covers Stripe as the payment provider. For the books themselves use `accounting-core`; for invoices use `invoice-lifecycle`; for cash position use `cash-reporting`.

## When to Use

- Building a new payment flow and choosing between Checkout Sessions, PaymentIntents, and SetupIntents
- Setting up a marketplace with Connect Accounts v2
- Adding subscription billing
- Setting up Treasury financial accounts or embedded payment UIs
- Auditing an existing Stripe integration against the Go Live checklist
- Upgrading Stripe SDK or API versions

Do not use this to invent pricing, invent a charge, or move real money without the operator's approval. Test mode first, live mode only on explicit approval.

## Core Principle

Every transaction has evidence: a Stripe object id, a webhook event, and a ledger entry that agree with each other. If the three do not agree, the payment is not done, no matter what the UI shows.

## Choose the Right API

Pick by the flow, not by habit:

- **Checkout Sessions:** hosted payment page. Use when you want Stripe to own the payment UI, tax, and compliance surface. Lowest code, fastest to ship.
- **PaymentIntents:** custom payment UI with your own form. Use when the checkout experience must live inside your product.
- **SetupIntents:** save a payment method for later use without charging now. Use for card-on-file, trials that convert, and metered billing.
- **Billing API:** subscriptions, metered usage, and invoices. Pair with Checkout for subscription signup, or with PaymentIntents for custom billing flows.
- **Connect Accounts v2:** marketplaces and platforms. Set controller properties explicitly; know who owns payouts, fees, and onboarding before writing code.
- **Treasury:** embedded financial accounts. Only when the product genuinely needs accounts and money movement inside it.

If two APIs could fit, say so, name the tradeoff, and pick the simpler one. Record the decision and why.

## Build Rules

1. **Pin versions.** Pin the Stripe API version in code. Never float on the account default.
2. **Test before committing.** Test a new API version with the `Stripe-Version` header before changing the pinned version.
3. **Idempotency keys.** Every charge, refund, and payout creation carries an idempotency key. A retry must never double-charge.
4. **Verify webhooks.** Verify the webhook signature on every event. Never trust an unverified payload. Handle each event idempotently; Stripe retries delivery.
5. **Migrate webhooks on breaking changes.** When an API upgrade changes event structures, migrate the handlers first, then the version.
6. **Upgrade in order.** SDK version, API version, Stripe.js, mobile SDK: change one at a time, in that order, testing after each. The four interact in non-obvious ways.
7. **No secrets in code or logs.** API keys live in the secret store, never in source, logs, screenshots, or reports. Test keys and live keys never mix.
8. **Go Live checklist before launch.** Run the Stripe Go Live checklist as an audit: keys, webhook endpoints, tax settings, payout account, dispute handling. A failed item blocks launch.

## Record and Reconcile

After any payment work:

- Record each transaction with its Stripe id, amount, currency, customer, status, and the webhook event that confirmed it.
- Reconcile Stripe payouts against the bank feed: every payout maps to deposits, every fee is accounted for.
- Flag mismatches (paid in Stripe but missing in the books, refunded but still marked paid) as discrepancies with evidence, never silently corrected.
- Report by work: what flow was built or changed, what was tested, what reconciles, what is still open.

## Output

- The integration change (commit or PR), with the API choice and its reason recorded
- A transaction record for every payment touched, with Stripe id and webhook evidence
- A reconciliation note: what matches the books, what does not, and the discrepancy list
- A Go Live checklist result when an integration goes live

## Verification

- Every transaction cited has a Stripe object id that opens in the dashboard
- Every charge was created with an idempotency key
- Every webhook handler verifies signatures and handles retries
- Test mode proves the flow end to end before live mode is enabled
- The pinned API version is stated in the change, not assumed

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. A payment integration ships as a commit with its tests and its reconciliation, not as a claim that it works. Report by work: flows built, transactions recorded, mismatches flagged. Use the related skills (`invoice-lifecycle` for invoicing on top of payments, `accounting-core` for the books the payments reconcile to, `cash-reporting` for what the cash position looks like after). Update the agent's memory with the API choices made so the next integration starts from the decision, not from scratch.

## Related Skills

- `accounting-core` - the books payments reconcile to
- `invoice-lifecycle` - invoicing across QuickBooks, Xero, Stripe, and FreshBooks
- `cash-reporting` - periodic cash reports built on reconciled transactions

## Research source

Stripe official skills stripe-best-practices and upgrade-stripe, published at https://github.com/stripe/ai and listed in the VoltAgent awesome-agent-skills index (https://github.com/VoltAgent/awesome-agent-skills). Read 25 Nov 2026 from the VoltAgent index listing and the officialskills.sh skill pages for both skills plus the stripe/ai README (hosted Stripe MCP at mcp.stripe.com, plugin install paths, manual install via npx skills). No clone was used for this skill.
