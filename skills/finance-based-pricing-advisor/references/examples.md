# Pricing Examples

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
