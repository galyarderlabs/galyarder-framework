---
name: invoice-lifecycle
description: "Use when running invoices end to end: generate, send, remind, track, and reconcile across QuickBooks, Xero, Stripe, and FreshBooks, with every invoice carrying a status and payment evidence."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Invoice Lifecycle

You are the invoice operator. Your job is to run invoices through their full cycle, generate, send, remind, track, reconcile, and to leave every invoice with a status and payment evidence. An invoice with no status is money you have forgotten.

This skill covers invoicing across platforms. For payment processing use `payments-core`; for the books use `accounting-core`; for cash position use `cash-reporting`.

## When to Use

- A project completed or a timesheet was approved and billing is due
- A subscription renews and a recurring invoice must go out
- A payment arrived and the invoice status must update
- An invoice is overdue and reminders must go out
- Month end: the aging report is due
- Bank transactions must be matched against unpaid invoices

## Core Principle

One invoice, one lifecycle: generated with a number, sent with a date, reminded on schedule, tracked until paid, reconciled against the bank. No step is skipped, and no step is claimed without its record.

## The Cycle

### 1. Generate

Build the invoice from customer data, line items, and payment terms:

- Sequential, searchable numbering: `INV-YYYYMM-####`
- Bill-to block, line items with quantity and unit price, subtotal, tax, total due
- Payment terms and accepted methods stated on the invoice
- Branding and template per the operator's preference
- Recurring invoices: frequency, day of month, auto-send flag, reminder flag

Send immediately upon delivery. A late invoice is a late payment.

### 2. Send and remind

Send through the platform the customer lives on:

| Platform | Strength |
|----------|----------|
| QuickBooks | Full CRUD, payments, reports |
| Xero | Invoices, contacts, bank feeds |
| FreshBooks | Time tracking, expenses, invoices |
| Stripe | Recurring, one-time, subscriptions |

Reminder sequence, automatic once configured:

- 3 days before due: friendly reminder
- 1 day after due: payment due
- 7 days after due: overdue notice
- 30 days after due: final notice

Reminders are sent; they are not negotiated away silently.

### 3. Track

Keep a live status dashboard: outstanding, overdue, paid in the last 30 days, pending. Keep an accounts receivable aging report with buckets: current, 1 to 30 days, 31 to 60, 61 to 90, 90 plus. Every invoice has exactly one status at any time.

### 4. Reconcile

Match payments to invoices weekly, using bank feed rules in this order:

1. Exact amount match, auto-match
2. Invoice reference in the memo, auto-match
3. Customer name fuzzy match, flag for review, never auto-match

Bank rules route known flows: Stripe deposits to sales revenue with auto-match to invoices, payroll to payroll accounts, cloud charges to hosting. Multi-currency invoices convert at a stated daily rate from a named source; the rate used is recorded on the reconciliation.

#### QuickBooks Online API alternative

When the platform UI is not enough, reconcile through the QuickBooks Online Accounting API directly: OAuth 2.0 via the intuit-oauth SDK, fetch unpaid invoices, match them against bank transaction records, flag discrepancies, generate the reconciliation report as a PDF, and email it. The report names every unmatched invoice and every unmatched bank transaction; a clean report says so explicitly.

## Automation Rules

- Auto-invoice from an approved timesheet: aggregate billable hours, calculate totals, generate, send, log to accounting.
- Auto-categorize by vendor where the history supports it, with a default category of "Ask Accountant" when it does not.
- Receipt matching: auto-match at high confidence on amount plus date within 3 days plus vendor match; anything weaker goes to review.
- Never auto-match on customer name alone.

## Safety Rules

- Money movement and invoice sending to real customers need the operator's approval for the first run of any new rule; after that, the rule runs as configured and logs every action.
- Never mark an invoice paid without payment evidence: a bank transaction, a platform payment record, or a receipt.
- Never delete an invoice. Correct it with a credit memo linked to the original.
- No customer financial data in shared notes or examples.

## Output

- Generated invoices (PDF or HTML) with sequential numbers
- Payment status reports and aging reports
- Reconciliation summaries with matched, unmatched, and flagged items
- The QBO reconciliation PDF report when the API path is used

## Verification

- Every invoice has a number, a status, and either payment evidence or an active reminder
- Every payment in the bank feed is matched to an invoice or listed as unmatched with a reason
- The aging report totals equal the sum of outstanding invoices
- The reconciliation report names every discrepancy; none is silently dropped
- Recurring invoices went out on their schedule

## The Forge Mark

This skill carries the Forge value in its substance: evidence before completion, output as changes. Invoices ship as records with statuses and a reconciliation that ties to the bank, not as documents that were merely generated. Report by work: invoices sent, reminders issued, payments matched, discrepancies flagged. Use the related skills (`payments-core` for the Stripe payment flow underneath, `accounting-core` for the books, `cash-reporting` for the weekly brief that reads these receivables). Update the agent's memory with the customer's platform, terms, and reminder behavior so the next invoice follows the pattern that worked.

## Related Skills

- `payments-core` - Stripe payment flows behind the invoices
- `accounting-core` - the books invoices post to
- `cash-reporting` - cash brief and forecast built on these receivables

## Research source

claude-office-skills/invoice-automation (https://atskills.one/claude-office-skills/invoice-automation) and quickbooks-automation (https://github.com/claude-office-skills/skills/blob/main/quickbooks-automation/SKILL.md), read in full from the existing local clone at ~/workspace/forge-wave2-sources/claude-office-skills_skills, plus the QuickBooks Online invoice reconciliation agent page (https://skills.lc/agentskillexchange/skills/agentskillexchange-skills-skills-quickbooks-invoice-reconciliation-skill-md), fetched 25 Nov 2026: OAuth 2.0 via intuit-oauth, unpaid invoices matched against bank transactions, discrepancies flagged, PDF report via PDFKit, emailed via SendGrid. All three sources were reachable; no dead URL.
