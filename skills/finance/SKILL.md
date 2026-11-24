---
name: finance
description: "Consolidated Forge Anything Finance intelligence bundle."
---

# FORGE FINANCE BUNDLE

This bundle contains 4 high-integrity SOPs for the Finance department.


---
## SKILL: accounting
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Accounting & Bookkeeping

You are the Accounting Specialist at Galyarder Labs.
Messy books cost you money in taxes, missed deductions, and accountant fees. This skill helps you set up clean financial tracking from day one  30 minutes a week keeps you legal, informed, and out of trouble.

## Core Principles

- Bookkeeping is not optional. Messy books cost you money in taxes, missed deductions, and accountant fees.
- Separate business and personal finances completely. Day one. No exceptions.
- SaaS revenue recognition has rules. Stripe payments are not the same as "revenue" for accounting purposes.
- You don't need a full-time accountant until $50k+ ARR. But you do need a system from day one.
- 30 minutes a week keeps your books clean. 30 hours in April fixes what you ignored all year.

## Getting Started: Financial Foundation

### Day 1 Checklist

```
Before your first dollar of revenue:
- [ ] Open a separate business bank account (checking)
- [ ] Get a business credit card (or dedicated personal card for business only)
- [ ] Set up accounting software (see recommendations below)
- [ ] Create a simple chart of accounts
- [ ] Set up Stripe (or payment processor) to deposit to business account
- [ ] Save a folder for receipts (digital  Google Drive, Dropbox, or in your accounting tool)
- [ ] Note your fiscal year start date (usually Jan 1 for calendar year)
```

### Separate Your Finances

**Why it matters:**
- Legal protection (LLC/corp separation requires it)
- Tax deductions are easy to prove with clean records
- Makes tax prep 10x faster and cheaper
- Investors and lenders need clean books

**How:**
- Business bank account (Mercury, Relay, or any bank with no/low fees)
- Business credit card (Ramp, Brex, or a separate personal card dedicated to business)
- Never pay personal expenses from business accounts
- Never pay business expenses from personal accounts
- If you must (emergency), document it as an owner draw/contribution

---

## Accounting Software

### Recommendations by Stage

| Stage | Tool | Cost | Why |
|-------|------|------|-----|
| Pre-revenue | Spreadsheet | Free | Don't over-invest before revenue |
| $0-5k MRR | Wave | Free | Full accounting, free, good for solo |
| $0-10k MRR | QuickBooks Self-Employed | $15/mo | Simple, widely supported by accountants |
| $5k-50k MRR | QuickBooks Online | $30+/mo | Standard. Every accountant knows it |
| $5k-50k MRR | Xero | $15+/mo | Clean UI, good for SaaS |
| Any stage | Bench | $299+/mo | Done-for-you bookkeeping service |

**The short answer:** Start with Wave (free) or QuickBooks Online. Switch to QBO when you hire an accountant  it's what they all use.

### Stripe + Accounting Integration

Connect Stripe to your accounting software to auto-import transactions:
- QuickBooks: Use the Stripe integration or Synder
- Xero: Use the Stripe integration
- Wave: Manual import via CSV (or use a connector like Zapier)

---

## Chart of Accounts (Simplified for SaaS)

Your chart of accounts is the list of categories for your money. Keep it simple:

```
REVENUE
  Subscription Revenue      (MRR from customers)
  One-Time Revenue          (setup fees, lifetime deals)

COST OF GOODS SOLD (COGS)
  Hosting & Infrastructure  (Vercel, Supabase, AWS, etc.)
  Payment Processing Fees   (Stripe fees, ~2.9% + $0.30)
  Third-Party APIs          (SendGrid, Twilio, OpenAI, etc.)

OPERATING EXPENSES
  Software & Tools          (GitHub, Figma, analytics, etc.)
  Marketing & Advertising   (Google Ads, sponsorships, etc.)
  Contractors & Freelancers (developers, designers, writers)
  Legal & Professional      (lawyer, accountant, registered agent)
  Domain & DNS              (domain registrar, Cloudflare)
  Office & Equipment        (computer, monitor, desk  if home office)
  Education & Training      (courses, books, conferences)
  Insurance                 (if applicable)
  Miscellaneous             (catch-all  keep this small)

OTHER
  Owner Draw / Distribution (money you take out for yourself)
  Owner Contribution        (money you put in from personal funds)
```

---

## Weekly Bookkeeping Routine

Spend 30 minutes every week. It prevents the year-end panic.

```
Weekly (pick a day, be consistent):
- [ ] Categorize new transactions in accounting software
- [ ] Upload receipts for any expense over $75
- [ ] Reconcile bank account (does your software match your bank?)
- [ ] Note any unusual transactions to ask your accountant about

Monthly (first week of each month):
- [ ] Review Profit & Loss statement
- [ ] Check: Is revenue matching what Stripe shows?
- [ ] Check: Are expenses categorized correctly?
- [ ] Review cash balance  how many months of runway do you have?
- [ ] Set aside estimated tax payment (see Tax section)
```

---

## SaaS Revenue Recognition

### The Basic Rule

Revenue is recognized when you deliver the service, not when you receive payment.

```
Example:
- Customer pays $1,200 for annual plan on March 1
- You DON'T book $1,200 as March revenue
- You book $100/month for 12 months (March through February)

Why: You owe them 12 months of service. Until delivered, it's "deferred revenue" (a liability).
```

### When It Matters

- **Pre-$50k ARR:** Most bootstrapped founders use cash-basis accounting (revenue = when you get paid). This is simpler and fine for tax purposes.
- **Post-$50k ARR or seeking investment:** Switch to accrual-basis accounting with proper revenue recognition. Your accountant handles this.
- **Lifetime deals:** Recognize over the expected customer lifetime (usually 3-5 years).

---

## Taxes

### Estimated Tax Payments (US)

If you expect to owe $1,000+ in taxes, the IRS wants quarterly estimated payments:

```
Due dates:
- Q1: April 15
- Q2: June 15
- Q3: September 15
- Q4: January 15 (of the following year)

How much to set aside:
- Rule of thumb: 25-30% of net profit (revenue - expenses)
- Transfer this to a separate savings account each month
- Pay quarterly estimates from that account
```

### Common Tax Deductions for SaaS Founders

```
Likely deductible (confirm with your accountant):
- [ ] Hosting and infrastructure costs
- [ ] Software subscriptions used for business
- [ ] Payment processing fees (Stripe)
- [ ] Contractor payments
- [ ] Home office (dedicated space, % of rent/mortgage)
- [ ] Internet (business % of your bill)
- [ ] Computer and equipment
- [ ] Domain registration and renewal
- [ ] Professional services (legal, accounting)
- [ ] Business insurance
- [ ] Education directly related to your business
- [ ] Marketing and advertising expenses
- [ ] Travel for business purposes (conferences, customer meetings)
```

### When to Hire an Accountant

```
Do it yourself:    Pre-revenue to ~$2k MRR (use software, keep clean books)
Annual tax prep:   $2k-10k MRR (hire a CPA for year-end, do bookkeeping yourself)
Monthly accountant: $10k+ MRR (hire a bookkeeper or service like Bench)
```

**Finding a good accountant:**
- Look for CPAs who specialize in small businesses or startups
- Ask other founders for referrals
- Expect to pay $500-2,000 for annual tax prep (depending on complexity)
- A good accountant saves you more than they cost in missed deductions and avoided mistakes

---

## Financial Reports You Should Read

### Profit & Loss (P&L)

Shows revenue minus expenses = profit (or loss) for a period.

```
Review monthly. Ask:
- Is revenue growing month over month?
- Are expenses growing faster than revenue?
- What are my top 3 expense categories?
- What's my profit margin? (profit / revenue  100)
```

### Cash Flow

Shows money in and money out, regardless of when revenue is "earned."

```
Review monthly. Ask:
- How much cash do I have today?
- How many months of expenses can I cover? (runway)
- Am I cash-flow positive? (more coming in than going out)
```

### Balance Sheet

Shows what you own (assets), what you owe (liabilities), and your equity.

```
Review quarterly. Less important at early stage, but needed for:
- Applying for business loans or credit
- Talking to potential investors
- Understanding deferred revenue
```

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Mixing personal and business finances | Separate bank accounts from day one |
| Not tracking expenses | Categorize weekly. 30 minutes prevents 30 hours of cleanup |
| Ignoring estimated tax payments | Set aside 25-30% of profit monthly in a separate account |
| No receipts for expenses | Save digital copies of everything over $75 |
| Doing books once a year | Weekly categorization, monthly review |
| DIY taxes past $10k MRR | Hire a CPA. They pay for themselves in avoided mistakes |
| Confusing Stripe revenue with accounting revenue | Stripe payouts include refunds, fees, and timing differences |
| No emergency fund for the business | Keep 2-3 months of expenses in the business account |

---

## Success Looks Like

- Clean books that take 30 minutes/week to maintain
- Tax payments estimated and saved quarterly (no April surprises)
- Clear understanding of monthly profit/loss and cash runway
- Receipts saved and categorized for every business expense
- An accountant relationship in place before you desperately need one
- Business and personal finances completely separated

---

## Related Skills

- **finances**  Financial modeling, unit economics, and cash flow planning
- **payments**  Set up Stripe and connect to your accounting software
- **legal**  Business entity formation and legal compliance
- **pricing**  Set pricing that supports healthy unit economics

---
 2026 Galyarder Labs. Forge Anything.

---
## SKILL: finance-based-pricing-advisor
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

You are the Finance Based Pricing Advisor Specialist at Galyarder Labs.
## Purpose

Evaluate the **financial impact** of pricing changes (price increases, new tiers, add-ons, discounts) using ARPU/ARPA analysis, conversion impact, churn risk, NRR effects, and CAC payback implications. Use this to make data-driven go/no-go decisions on proposed pricing changes with supporting math and risk assessment.

**What this is:** Financial impact evaluation for pricing decisions you're already considering.

**What this is NOT:** Comprehensive pricing strategy design, value-based pricing frameworks, willingness-to-pay research, competitive positioning, psychological pricing, packaging architecture, or monetization model selection. For those topics, see the future `pricing-strategy-suite` skills.

This skill assumes you have a specific pricing change in mind and need to evaluate its financial viability.

## Key Concepts

### The Pricing Impact Framework

A systematic approach to evaluate pricing changes financially:

1. **Revenue Impact**  How does this change ARPU/ARPA?
   - Direct revenue lift from price increase
   - Revenue loss from reduced conversion or increased churn
   - Net revenue impact

2. **Conversion Impact**  How does this affect trial-to-paid or sales conversion?
   - Higher prices may reduce conversion rate
   - Better packaging may improve conversion
   - Test assumptions

3. **Churn Risk**  Will existing customers leave due to price change?
   - Grandfathering strategy (protect existing customers)
   - Churn risk by segment (SMB vs. enterprise)
   - Churn elasticity (how sensitive are customers to price?)

4. **Expansion Impact**  Does this create or block expansion opportunities?
   - New premium tier = upsell path
   - Usage-based pricing = expansion as customers grow
   - Add-ons = cross-sell opportunities

5. **CAC Payback Impact**  Does pricing change affect unit economics?
   - Higher ARPU = faster payback
   - Lower conversion = higher effective CAC
   - Net effect on LTV:CAC ratio

### Pricing Change Types

**Direct monetization changes:**
- Price increase (raise prices for all customers or new customers only)
- New premium tier (create upsell path)
- Paid add-on (monetize previously free feature)
- Usage-based pricing (charge for consumption)

**Discount strategies:**
- Annual prepay discount (improve cash flow)
- Volume discounts (larger deals)
- Promotional pricing (temporary price reduction)

**Packaging changes:**
- Feature bundling (combine features into tiers)
- Unbundling (separate features into add-ons)
- Pricing metric change (seats  usage, or vice versa)

### Anti-Patterns (What This Is NOT)

- **Not value-based pricing:** This evaluates a proposed change, not "what should we charge?"
- **Not WTP research:** This analyzes impact, not "what will customers pay?"
- **Not competitive positioning:** This is financial analysis, not market positioning
- **Not packaging architecture:** This evaluates one change, not redesigning all tiers

### When to Use This Framework

**Use this when:**
- You have a specific pricing change to evaluate (e.g., "Should we raise prices 20%?")
- You need to quantify revenue, churn, and conversion trade-offs
- You're deciding between pricing change options (test A vs. B)
- You need to present pricing change impact to leadership or board

**Don't use this when:**
- You're designing pricing strategy from scratch (use value-based pricing frameworks)
- You haven't validated willingness-to-pay (do customer research first)
- You don't have baseline metrics (ARPU, churn, conversion rates)
- Change is too small to matter (<5% price change, <10% of customers affected)

---

### Facilitation Source of Truth

Use [`workshop-facilitation`](../workshop-facilitation/SKILL.md) as the default interaction protocol for this skill.

It defines:
- session heads-up + entry mode (Guided, Context dump, Best guess)
- one-question turns with plain-language prompts
- progress labels (for example, Context Qx/8 and Scoring Qx/5)
- interruption handling and pause/resume behavior
- numbered recommendations at decision points
- quick-select numbered response options for regular questions (include `Other (specify)` when useful)

This file defines the domain-specific assessment content. If there is a conflict, follow this file's domain logic.

## Application

This interactive skill asks **up to 4 adaptive questions**, offering **3-5 enumerated options** at decision points.

---

### Step 0: Gather Context

**Agent asks:**

"Let's evaluate the financial impact of your pricing change. Please provide:

**Current pricing:**
- Current ARPU or ARPA
- Current pricing tiers (if applicable)
- Current monthly churn rate
- Current trial-to-paid conversion rate (if relevant)

**Proposed pricing change:**
- What change are you considering? (price increase, new tier, add-on, etc.)
- New pricing (if known)
- Affected customer segment (all, new only, specific tier)

**Business context:**
- Total customers (or MRR/ARR)
- CAC (to assess payback impact)
- NRR (to assess expansion context)

You can provide estimates if you don't have exact numbers."

---

### Step 1: Identify Pricing Change Type

**Agent asks:**

"What type of pricing change are you considering?

1. **Price increase**  Raise prices for new customers, existing customers, or both
2. **New premium tier**  Add higher-priced tier with additional features
3. **Paid add-on**  Monetize a new or existing feature separately
4. **Usage-based pricing**  Charge for consumption (seats, API calls, storage, etc.)
5. **Discount strategy**  Annual prepay discount, volume pricing, or promotional pricing
6. **Packaging change**  Rebundle features, change pricing metric, or tier restructure

Choose a number, or describe your specific pricing change."

**Based on selection, agent adapts questions:**

---

#### If Option 1 (Price Increase):

**Agent asks:**

"**Price increase details:**

- Current price: $___
- New price: $___
- Increase: ___%

**Who is affected?**
1. New customers only (grandfather existing)
2. All customers (existing + new)
3. Specific segment (e.g., SMB only, new plan only)

**When would this take effect?**
- Immediately
- Next billing cycle
- Gradual rollout (test first)"

---

#### If Option 2 (New Premium Tier):

**Agent asks:**

"**Premium tier details:**

- Current top tier price: $___
- New premium tier price: $___
- Key features in premium tier: [list]

**Expected adoption:**
- What % of current customers might upgrade? ___%
- What % of new customers might choose premium? ___%

**Cannibalization risk:**
- Will premium tier cannibalize current top tier?"

---

#### If Option 3 (Paid Add-On):

**Agent asks:**

"**Add-on details:**

- Add-on name: ___
- Price: $___ /month or /user
- Currently free or new feature?

**Expected adoption:**
- What % of customers would pay for this? ___%
- Is this feature currently used (if free)?
- Will making it paid hurt retention?"

---

#### If Option 4 (Usage-Based Pricing):

**Agent asks:**

"**Usage pricing details:**

- Usage metric: (seats, API calls, storage, transactions, etc.)
- Pricing: $___ per [unit]
- Free tier or minimum? (e.g., first 1,000 API calls free)

**Expected impact:**
- Average customer usage: ___ units/month
- Expected ARPU change: $current  $new

**Expansion potential:**
- As customers grow usage, will ARPU increase?"

---

#### If Option 5 (Discount Strategy):

**Agent asks:**

"**Discount details:**

- Discount type: (annual prepay, volume, promotional)
- Discount amount: ___% off
- Duration: (ongoing, limited time)

**Trade-off:**
- Lower price vs. improved cash flow (annual prepay)
- Lower price vs. larger deal size (volume)
- Lower price vs. urgency (promotional)"

---

#### If Option 6 (Packaging Change):

**Agent asks:**

"**Packaging change details:**

- What are you changing? (bundling, unbundling, pricing metric)
- Current packaging: [describe]
- New packaging: [describe]

**Expected impact:**
- ARPU change: $current  $new
- Conversion change: ___%  ___%
- Churn risk: (low, medium, high)"

---

### Step 2: Assess Expected Impact

**Agent asks:**

"Now let's quantify the impact. Based on your pricing change, estimate:

**Revenue impact:**
- Current ARPU: $___
- Expected new ARPU: $___
- ARPU lift: ___%

**Conversion impact:**
- Current conversion rate: ___%
- Expected new conversion rate: ___%
- Conversion change: [increase / decrease / no change]

**Churn risk:**
- Current monthly churn: ___%
- Expected churn after change: ___%
- Churn risk: [low / medium / high]

**Expansion impact:**
- Does this create expansion opportunities? (new tier to upgrade to, usage growth)
- Expected NRR change: ___%  ___%

You can provide estimates. We'll model scenarios (conservative, base, optimistic)."

---

### Step 3: Evaluate Current State

**Agent asks:**

"To assess whether this pricing change makes sense, I need your current baseline:

**Current metrics:**
- MRR or ARR: $___
- Number of customers: ___
- ARPU/ARPA: $___
- Monthly churn rate: ___%
- NRR: ___%
- CAC: $___
- LTV: $___

**Growth context:**
- Current growth rate: ___% MoM or YoY
- Target growth rate: ___%

**Competitive context:**
- Are you priced below, at, or above market?
- Competitive pressure: (low, medium, high)"

---

### Step 4: Deliver Recommendations

**Agent synthesizes:**
- Revenue impact (ARPU lift  customer base)
- Conversion impact (new customers affected)
- Churn impact (existing customers affected)
- Net revenue impact
- CAC payback impact
- Risk assessment

**Agent offers 3-4 recommendations:**

---

#### Recommendation Pattern 1: Implement Broadly

**When:**
- Net revenue impact clearly positive (>10% ARPU lift, <5% churn risk)
- Minimal conversion impact
- Strong value justification

**Recommendation:**

"**Implement this pricing change**  Strong financial case

**Revenue Impact:**
- Current MRR: $___
- ARPU lift: ___% ($current  $new)
- Expected MRR increase: +$___/month (+___%)

**Churn Risk: Low**
- Expected churn increase: ___%  ___% (+___% points)
- Churn-driven MRR loss: -$___/month
- **Net MRR impact: +$___/month** 

**Conversion Impact:**
- Current conversion: ___%
- Expected conversion: ___% (___% change)
- Impact on new customer acquisition: [minimal / manageable]

**CAC Payback Impact:**
- Current payback: ___ months
- New payback: ___ months (faster due to higher ARPU)

**Why this works:**
[Specific reasoning based on numbers]

**How to implement:**
1. **Grandfather existing customers** (if raising prices)
   - Protect current base from churn
   - New pricing for new customers only
2. **Communicate value**
   - Emphasize features, outcomes, ROI
   - Justify price with value delivered
3. **Monitor metrics (first 30-60 days)**
   - Conversion rate (should stay within ___%)
   - Churn rate (should stay <___%)
   - Customer feedback

**Expected timeline:**
- Month 1: +$___ MRR from new customers
- Month 3: +$___ MRR (cumulative)
- Month 6: +$___ MRR
- Year 1: +$___ ARR

**Success criteria:**
- Conversion rate stays >___%
- Churn rate stays <___%
- NRR improves to >___%"

---

#### Recommendation Pattern 2: Test First (A/B Test)

**When:**
- Uncertain impact (wide range between conservative and optimistic)
- Moderate churn or conversion risk
- Large customer base (can test with subset)

**Recommendation:**

"**Test with a segment before broad rollout**  Impact is uncertain

**Why test:**
- ARPU lift estimate: ___% (wide confidence interval)
- Churn risk: Medium (___%  ___%)
- Conversion impact: Uncertain (___%  ___% estimated)

**Test design:**

**Cohort A (Control):**
- Current pricing: $___
- Size: ___% of new customers (or ___ customers)

**Cohort B (Test):**
- New pricing: $___
- Size: ___% of new customers (or ___ customers)

**Duration:** 60-90 days (need statistical significance)

**Metrics to track:**
- Conversion rate (A vs. B)
- ARPU (A vs. B)
- 30-day retention (A vs. B)
- 90-day churn (A vs. B)
- NRR (A vs. B)

**Decision criteria:**

**Roll out broadly if:**
- Conversion rate (B) >___% of control (A)
- Churn rate (B) <___% higher than control
- Net revenue (B) >___% higher than control

**Don't roll out if:**
- Conversion drops >___%
- Churn increases >___%
- Net revenue impact negative

**Expected timeline:**
- Week 1-2: Launch test
- Week 8-12: Enough data for statistical significance
- Month 3: Decision to roll out or kill

**Risk:** Medium. Test mitigates risk before broad rollout."

---

#### Recommendation Pattern 3: Modify Approach

**When:**
- Original proposal has significant risk
- Better alternative exists
- Need to adjust pricing change to improve outcomes

**Recommendation:**

"**Modify your approach**  Original proposal has risks

**Original Proposal:**
- [Price increase / New tier / Add-on / etc.]
- Expected ARPU lift: ___%
- Churn risk: High (___%  ___%)
- Net revenue impact: Uncertain or negative

**Problem:**
[Specific issue: e.g., "20% price increase will likely cause 10% churn, wiping out revenue gains"]

**Alternative Approach:**

**Option 1: Smaller price increase**
- Instead of ___% increase, try ___%
- Lower churn risk (___% vs. ___%)
- Still positive net revenue: +$___/month

**Option 2: Grandfather existing, raise for new only**
- Protect current base (zero churn risk)
- Higher prices for new customers only
- Gradual ARPU improvement over time

**Option 3: Value-based pricing (charge more for high-value segments)**
- Keep SMB pricing flat
- Raise enterprise pricing ___%
- Lower churn risk (enterprise is stickier)

**Recommended:**
[Specific option with reasoning]

**Why this is better:**
- Lower churn risk
- Comparable revenue upside
- Easier to communicate

**How to implement:**
[Specific steps for alternative approach]"

---

#### Recommendation Pattern 4: Don't Change Pricing

**When:**
- Net revenue impact negative or marginal
- High churn risk without offsetting gains
- Competitive or strategic reasons to hold pricing

**Recommendation:**

"**Don't change pricing**  Risks outweigh benefits

**Why:**
- Expected revenue lift: +$___/month (___%)
- Expected churn impact: -$___/month (___%)
- **Net revenue impact: -$___/month**  or marginal

**Problem:**
[Specific issue: e.g., "Churn-driven revenue loss exceeds price increase gains"]

**What would need to change:**

**For price increase to work:**
- Churn rate must stay below ___% (currently ___%)
- OR conversion rate must stay above ___% (currently ___%)
- OR you need to reduce CAC to offset lower conversion

**Alternative strategies:**

**Instead of raising prices:**
1. **Improve retention**  Reduce churn from ___% to ___% (same revenue impact as price increase, lower risk)
2. **Expand within base**  Increase NRR from ___% to ___% via upsells
3. **Reduce CAC**  More efficient acquisition (better than pricing)

**When to revisit pricing:**
- After improving retention (churn <___%)
- After validating willingness-to-pay (WTP research)
- After competitive landscape changes

**Decision:** Hold pricing for now, focus on [retention / expansion / acquisition efficiency]."

---

### Step 5: Sensitivity Analysis (Optional)

**Agent offers:**

"Want to see what-if scenarios?

1. **Optimistic case**  Higher ARPU lift, lower churn
2. **Pessimistic case**  Lower ARPU lift, higher churn
3. **Breakeven analysis**  What churn rate makes this neutral?

Or ask any follow-up questions."

**Agent can provide:**
- Scenario modeling (optimistic/pessimistic/breakeven)
- Sensitivity tables (if churn is X%, revenue impact is Y)
- Comparison to alternative pricing strategies

---

## Examples

See `examples/` folder for sample conversation flows. Mini examples below:

### Example 1: Price Increase (Good Case)

**Scenario:** 20% price increase for new customers only

**Current state:**
- ARPU: $100/month
- Customers: 1,000
- MRR: $100K
- Churn: 3%/month
- New customers/month: 50

**Proposed change:**
- New customer pricing: $120/month (+20%)
- Existing customers: Grandfathered at $100

**Impact:**
- New customer ARPU: $120 (+20%)
- Churn risk: Low (existing protected)
- Conversion impact: Minimal (<5% drop estimated)

**Recommendation:** Implement. Net revenue impact +$12K/year with low risk.

---

### Example 2: Price Increase (Risky)

**Scenario:** 30% price increase for all customers

**Current state:**
- ARPU: $50/month
- Customers: 5,000
- MRR: $250K
- Churn: 5%/month (already high)

**Proposed change:**
- All customers: $65/month (+30%)

**Impact:**
- ARPU lift: +30% = +$75K MRR
- Churn risk: High (5%  8% estimated)
- Churn-driven loss: 3%  5,000  $65 = -$9.75K MRR/month

**Net impact:** +$75K - $9.75K = +$65K MRR (but accelerating churn problem)

**Recommendation:** Don't change. Fix retention first (reduce 5% churn), then raise prices.

---

### Example 3: New Premium Tier

**Scenario:** Add $500/month premium tier

**Current state:**
- Top tier: $200/month (500 customers)
- ARPA: $200

**Proposed change:**
- New tier: $500/month with advanced features
- Expected adoption: 10% of current top tier (50 customers)

**Impact:**
- Upsell revenue: 50  ($500 - $200) = +$15K MRR
- Cannibalization risk: Low (features justify premium)
- NRR impact: Increases from 105% to 110%

**Recommendation:** Implement. Creates expansion path, minimal cannibalization risk.

---

## Common Pitfalls

### Pitfall 1: Ignoring Churn Impact
**Symptom:** "We'll raise prices 30% and make $X more!" (no churn modeling)

**Consequence:** Churn wipes out revenue gains. Net impact negative.

**Fix:** Model churn scenarios (conservative, base, optimistic). Factor churn-driven revenue loss into net impact.

---

### Pitfall 2: Not Grandfathering Existing Customers
**Symptom:** "We're raising prices for everyone effective immediately"

**Consequence:** Massive churn spike from existing customers who feel betrayed.

**Fix:** Grandfather existing customers. Raise prices for new customers only.

---

### Pitfall 3: Testing Without Statistical Power
**Symptom:** "We tested on 10 customers and it worked!"

**Consequence:** 10 customers isn't statistically significant. Results are noise.

**Fix:** Test with large enough sample (100+ customers per cohort) for 60-90 days.

---

### Pitfall 4: Pricing Changes Without Value Justification
**Symptom:** "We're raising prices because we need more revenue"

**Consequence:** Customers see price increase without corresponding value increase. Churn.

**Fix:** Tie price increases to value improvements (new features, better support, outcomes delivered).

---

### Pitfall 5: Ignoring CAC Payback Impact
**Symptom:** "Higher ARPU is always better!"

**Consequence:** If conversion drops 30%, effective CAC increases dramatically. Payback period explodes.

**Fix:** Calculate CAC payback impact. Higher ARPU with lower conversion might make payback worse, not better.

---

### Pitfall 6: Annual Discounts That Hurt Margin
**Symptom:** "30% discount for annual prepay!" (improves cash but destroys LTV)

**Consequence:** Customers lock in low prices for a year. Revenue per customer decreases.

**Fix:** Limit annual discounts to 10-15%. Balance cash flow improvement with LTV protection.

---

### Pitfall 7: Copycat Pricing (Competitor-Based)
**Symptom:** "Competitor raised prices, so should we"

**Consequence:** Your customers, value prop, and cost structure are different. What works for them may not work for you.

**Fix:** Use competitors as data points, not decisions. Make pricing decisions based on your unit economics.

---

### Pitfall 8: Premature Optimization
**Symptom:** "Let's A/B test 47 different price points!"

**Consequence:** Analysis paralysis. Spending months on 5% pricing optimizations while missing 50% growth opportunities elsewhere.

**Fix:** Big pricing changes (tiers, packaging, add-ons) matter more than micro-optimizations. Start there.

---

### Pitfall 9: Forgetting Expansion Revenue
**Symptom:** "We're maximizing ARPU at acquisition"

**Consequence:** High upfront pricing prevents landing customers. Miss expansion opportunities.

**Fix:** Consider "land and expand" strategy. Lower entry price, higher expansion revenue via upsells.

---

### Pitfall 10: No Pricing Change Communication Plan
**Symptom:** "We're raising prices next month" (no customer communication)

**Consequence:** Surprised customers churn. Poor reviews. Reputation damage.

**Fix:** Communicate pricing changes 30-60 days in advance. Emphasize value, not just price.

---

## References

### Related Skills
- `saas-revenue-growth-metrics`  ARPU, ARPA, churn, NRR metrics used in pricing analysis
- `saas-economics-efficiency-metrics`  CAC payback impact of pricing changes
- `finance-metrics-quickref`  Quick lookup for pricing-related formulas
- `feature-investment-advisor`  Evaluates whether to build features that enable pricing changes
- `business-health-diagnostic`  Broader business context for pricing decisions

### External Frameworks (Comprehensive Pricing Strategy)
These are OUTSIDE the scope of this skill but relevant for broader pricing work:

- **Value-Based Pricing**  Price based on value delivered, not cost
- **Van Westendorp Price Sensitivity**  WTP research methodology
- **Conjoint Analysis**  Feature-to-price trade-off research
- **Good-Better-Best Packaging**  Tier architecture design
- **Price Anchoring & Decoy Pricing**  Psychological pricing tactics
- **Patrick Campbell (ProfitWell):** Pricing research and Standards

### Future Skills (Comprehensive Pricing)
For topics NOT covered here, see future `pricing-strategy-suite`:
- `value-based-pricing-framework`  How to price based on value
- `willingness-to-pay-research`  WTP research methods
- `packaging-architecture-advisor`  Tier and bundle design
- `pricing-psychology-guide`  Anchoring, decoys, framing
- `monetization-model-advisor`  Seat-based vs. usage vs. outcome pricing

### Provenance
- Adapted from `research/finance/Finance_For_PMs.Putting_It_Together_Synthesis.md` (Decision Framework #3)
- Pricing scenarios from `research/finance/Finance for Product Managers.md`

---
 2026 Galyarder Labs. Forge Anything.

---
## SKILL: financial-analyst
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Financial Analyst Skill

You are the Financial Analyst Specialist at Galyarder Labs.
##  Forge Anything Operating Procedures (MANDATORY)
When operating this skill for your human partner:
1. **Token Economy (RTK):** Use `rtk gain` results to calculate the ROI of using the Forge Anything vs. raw agent calls.
2. **Execution System (Linear):** Track budget targets and actual spend as Issues or Milestones in Linear.
3. **Strategic Memory (Obsidian):** Submit burn rate, ROI analysis, and runway projections to the `finops-manager` for inclusion in the **Finance Report** at `[VAULT_ROOT]//Department-Reports/Finance/`.

## Overview

Production-ready financial analysis toolkit providing ratio analysis, DCF valuation, budget variance analysis, and rolling forecast construction. Designed for financial modeling, forecasting & budgeting, management reporting, business performance analysis, and investment analysis.

## 5-Phase Workflow

### Phase 1: Scoping
- Define analysis objectives and stakeholder requirements
- Identify data sources and time periods
- Establish materiality thresholds and accuracy targets
- Select appropriate analytical frameworks

### Phase 2: Data Analysis & Modeling
- Collect and validate financial data (income statement, balance sheet, cash flow)
- **Validate input data completeness** before running ratio calculations (check for missing fields, nulls, or implausible values)
- Calculate financial ratios across 5 categories (profitability, liquidity, leverage, efficiency, valuation)
- Build DCF models with WACC and terminal value calculations; **cross-check DCF outputs against sanity bounds** (e.g., implied multiples vs. comparables)
- Construct budget variance analyses with favorable/unfavorable classification
- Develop driver-based forecasts with scenario modeling

### Phase 3: Insight Generation
- Interpret ratio trends and Standard against industry standards
- Identify material variances and root causes
- Assess valuation ranges through sensitivity analysis
- Evaluate forecast scenarios (base/bull/bear) for decision support

### Phase 4: Reporting
- Generate executive summaries with key findings
- Produce detailed variance reports by department and category
- Deliver DCF valuation reports with sensitivity tables
- Present rolling forecasts with trend analysis

### Phase 5: Follow-up
- Track forecast accuracy (target: +/-5% revenue, +/-3% expenses)
- Monitor report delivery timeliness (target: 100% on time)
- Update models with actuals as they become available
- Refine assumptions based on variance analysis

## Tools

### 1. Ratio Calculator (`scripts/ratio_calculator.py`)

Calculate and interpret financial ratios from financial statement data.

**Ratio Categories:**
- **Profitability:** ROE, ROA, Gross Margin, Operating Margin, Net Margin
- **Liquidity:** Current Ratio, Quick Ratio, Cash Ratio
- **Leverage:** Debt-to-Equity, Interest Coverage, DSCR
- **Efficiency:** Asset Turnover, Inventory Turnover, Receivables Turnover, DSO
- **Valuation:** P/E, P/B, P/S, EV/EBITDA, PEG Ratio

```bash
python scripts/ratio_calculator.py sample_financial_data.json
python scripts/ratio_calculator.py sample_financial_data.json --format json
python scripts/ratio_calculator.py sample_financial_data.json --category profitability
```

### 2. DCF Valuation (`scripts/dcf_valuation.py`)

Discounted Cash Flow enterprise and equity valuation with sensitivity analysis.

**Features:**
- WACC calculation via CAPM
- Revenue and free cash flow projections (5-year default)
- Terminal value via perpetuity growth and exit multiple methods
- Enterprise value and equity value derivation
- Two-way sensitivity analysis (discount rate vs growth rate)

```bash
python scripts/dcf_valuation.py valuation_data.json
python scripts/dcf_valuation.py valuation_data.json --format json
python scripts/dcf_valuation.py valuation_data.json --projection-years 7
```

### 3. Budget Variance Analyzer (`scripts/budget_variance_analyzer.py`)

Analyze actual vs budget vs prior year performance with materiality filtering.

**Features:**
- Dollar and percentage variance calculation
- Materiality threshold filtering (default: 10% or $50K)
- Favorable/unfavorable classification with revenue/expense logic
- Department and category breakdown
- Executive summary generation

```bash
python scripts/budget_variance_analyzer.py budget_data.json
python scripts/budget_variance_analyzer.py budget_data.json --format json
python scripts/budget_variance_analyzer.py budget_data.json --threshold-pct 5 --threshold-amt 25000
```

### 4. Forecast Builder (`scripts/forecast_builder.py`)

Driver-based revenue forecasting with rolling cash flow projection and scenario modeling.

**Features:**
- Driver-based revenue forecast model
- 13-week rolling cash flow projection
- Scenario modeling (base/bull/bear cases)
- Trend analysis using simple linear regression (standard library)

```bash
python scripts/forecast_builder.py forecast_data.json
python scripts/forecast_builder.py forecast_data.json --format json
python scripts/forecast_builder.py forecast_data.json --scenarios base,bull,bear
```

## Knowledge Bases

| Reference | Purpose |
|-----------|---------|
| `references/financial-ratios-guide.md` | Ratio formulas, interpretation, industry Standards |
| `references/valuation-methodology.md` | DCF methodology, WACC, terminal value, comps |
| `references/forecasting-best-practices.md` | Driver-based forecasting, rolling forecasts, accuracy |
| `references/industry-adaptations.md` | Sector-specific metrics and considerations (SaaS, Retail, Manufacturing, Financial Services, Healthcare) |

## Templates

| Template | Purpose |
|----------|---------|
| `assets/variance_report_template.md` | Budget variance report template |
| `assets/dcf_analysis_template.md` | DCF valuation analysis template |
| `assets/forecast_report_template.md` | Revenue forecast report template |

## Key Metrics & Targets

| Metric | Target |
|--------|--------|
| Forecast accuracy (revenue) | +/-5% |
| Forecast accuracy (expenses) | +/-3% |
| Report delivery | 100% on time |
| Model documentation | Complete for all assumptions |
| Variance explanation | 100% of material variances |

## Input Data Format

All scripts accept JSON input files. See `assets/sample_financial_data.json` for the complete input schema covering all four tools.

## Dependencies

**None** - All scripts use Python standard library only (`math`, `statistics`, `json`, `argparse`, `datetime`). No numpy, pandas, or scipy required.

---
 2026 Galyarder Labs. Forge Anything.

---
## SKILL: saas-finops-optimization
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# SaaS FinOps & AI Cost Optimization

You are the Saas Finops Optimization Specialist at Galyarder Labs.
This skill provides expert-level strategies for maintaining profitability in modern AI-native SaaS applications. It focuses on the specific unit economics of serverless infrastructure and LLM usage.

## 1. AI TOKEN ECONOMY (CRITICAL)

AI tokens are often the #1 expense for modern startups. Optimize or die.

### 1.1 Prompt Efficiency
- **Cache Hits**: Leverage Anthropic/OpenAI prompt caching for large system prompts.
- **Token Pruning**: Audit logs for redundant context. "Context padding" is a silent profit killer.
- **Model Tiering**: Use cheaper models (GPT-4o-mini, Haiku) for routing/classification; reserve expensive models (Pro/Opus) for final synthesis.

### 1.2 Rate Limiting & Quotas
- Implement **Per-User Quotas** in your backend. Do not allow a single user to burn your entire monthly API budget.
- Use **Usage-Based Internal Billing** to track which features cost the most.

## 2. SERVERLESS STACK OPTIMIZATION

### 2.1 Vercel / Edge Functions
- **Cold Start Minimization**: Keep edge functions small. Avoid importing heavy libraries in the global scope.
- **Edge Runtime**: Prefer Edge Runtime over Node.js for lower latency and lower execution cost.
- **Image Optimization**: Monitor Vercel Image Optimization limits. Use external CDNs or AVIF format to reduce bandwidth.

### 2.2 Database (Neon / Supabase)
- **Idle Timeout**: Set Neon "Autosuspend" to the minimum (e.g., 5 mins) for development/staging environments.
- **Query Optimization**: Use `EXPLAIN ANALYZE` to find slow, high-CPU queries that drive up serverless compute units.
- **Connection Pooling**: Use `PgBouncer` or Supabase Supavisor to prevent exhausting connection limits.

## 3. REVENUE & UNIT ECONOMICS

### 3.1 Stripe/Paddle Efficiency
- **Fee Analysis**: Factor in 2.9% + 30c per transaction. For low ARPU products, the fixed 30c can kill margins.
- **Tax Automation**: Use tools like Stripe Tax to avoid expensive manual compliance audits.

### 3.2 Burn Rate Monitoring
- **Actual vs. Forecast**: Do not trust "Expected Cost" charts. Audit **Actual Spend** every 7 days.
- **Infrastructure-as-Code (IaC)**: Use Terraform/Pulumi to ensure no "forgotten" resources are left running.

## 4. FINOPS AUDIT WORKFLOW

1. **Scan Manifests**: Check `package.json` and `.env` for all third-party integrations.
2. **Usage Audit**: Ask for usage stats from dashboards (OpenAI, Vercel, DB).
3. **Waste Detection**: Identify unused environments or over-provisioned database instances.
4. **Action Plan**: Provide a prioritized list of "Quick Wins" (high savings, low effort).

---
 2026 Galyarder Labs. Forge Anything. SaaS FinOps.

---
 2026 Galyarder Labs. Forge Anything.
