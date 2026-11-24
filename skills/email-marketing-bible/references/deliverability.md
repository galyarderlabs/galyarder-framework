# Deliverability

### Authentication (all three required)
- **SPF:** DNS TXT record listing authorised sending IPs. 10 DNS lookup limit. End with `-all`.
- **DKIM:** 2048-bit RSA keys. Rotate annually. `d=` domain must align with From address.
- **DMARC:** Implement in stages: `p=none`  `p=quarantine`  `p=reject`.
- **BIMI:** Brand logo in inbox. Requires DMARC enforcement + VMC (~$1,500/year).
- **Order:** SPF  DKIM  DMARC (p=none)  advance DMARC  BIMI.

### Sender Reputation
- Domain reputation > IP reputation for Gmail (120-day window).
- Dedicated IP: only if sending 1M+/month. Below that, shared IPs are fine.

### Sending Identity
- Separate marketing from transactional: different subdomains. Worth it at 40K+/month.
- From name: personal names get +3.81% opens. Always set monitored reply-to.

### Deliverability Diagnosis (10-step framework)
1. Identify symptom  2. Check authentication  3. Check blocklists  4. Check reputation  5. Analyse bounce logs  6. Review sending patterns  7. Check content  8. Test and validate  9. Remediate root cause  10. Monitor recovery (2-4 weeks, Gmail up to 120 days).

### Domain/IP Warming
Days 1-3: 50-100  Days 4-7: 200-500  Week 2: 500-1K  Week 3: 1-5K  Week 4: 5-10K  Week 5+: Scale to full. Start with most engaged subscribers.

### Gmail Primary Tab (new in V1)
- Replies are the strongest signal. Ask for replies in welcome email.
- Personal sender name > brand name. Simpler templates help.
- Worth pursuing for newsletters/B2B. Ecommerce can thrive in Promotions.

### 2025-2026 Inbox Changes (new in V1)
- **Gmail Promotions:** Now ranked by relevance (Sep 2025), not recency. Low engagement = buried.
- **Gmail Gemini AI:** AI summarises emails; CTR dropped as users read summaries instead of clicking. Content must survive summarisation.
- **Apple Mail Categories (iOS 18.2):** Newsletters land in "Updates" (better than Gmail's "Promotions"). AI summaries replace preheaders.
- **Microsoft Outlook (May 2025):** SPF/DKIM/DMARC required for 5K+/day senders. Non-compliant = 550 rejection.
- **The 60% reality:** Only ~60% of "delivered" emails reach a visible inbox; ~36% filtered to spam post-SMTP.

### Deliverability by Email Type
- **Newsletters:** Consistent schedule, engagement segmentation, 120-day suppression, complaint rate <0.05%.
- **Flows:** Rate-limit to prevent volume spikes. Suppress over-contacted subscribers.
- **Transactional:** Separate subdomain. Monitor delivery speed (<30s). Never mix with marketing.

### Warming Tools
Mailreach, Warmbox, Lemwarm, Warmy, Instantly warmup. Continue warming alongside live campaigns.

> Full chapter: https://emailmarketingskill.com/07-deliverability/

---
