---
name: saas-finops-optimization
description: Optimize cloud and AI costs for modern SaaS stacks (Vercel, Supabase, Neon, Stripe, and AI APIs). Covers token efficiency, serverless database scaling, edge function optimization, and burn rate monitoring. Use when planning infrastructure, investigating high bills, or auditing API usage.
---

# SaaS FinOps & AI Cost Optimization

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
© 2026 Galyarder Labs. Galyarder Framework. SaaS FinOps.
