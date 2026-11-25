# Skill Registry Review vs Current Repo

Maintainer review, 24 Nov 2026, repo HEAD `2fa091d2`, plus the v20 addendum at the end of this file (25 Nov 2026, repo HEAD `ee652704`). This reviews Galih's Essential Skill Registry (`skill-registry.md`), now v20; the v13/v14/v15 reviews below are preserved as history. The v13 rows were reviewed at HEAD `00b0080c`; the ronde-14 rows at HEAD `a03af575`; the ronde-15 rows are reviewed in the addendum at the end of this file. It is a proposal record only: it does not add, delete, rename, or restructure anything. Curation decisions stay with Galih.

## How to read this

- **Covered**: the repo already has a skill for this slot. The repo skill is named.
- **Partial**: the repo covers part of the row. What is covered and what is missing are both named.
- **Missing**: no repo skill for this row. Candidate to adopt later. Proposal only.
- **Repo-only**: a repo skill with no registry row. Candidate to cut or keep-with-reason. Proposal only.
- Counts are by registry row (76 rows), not by individual skill. A suite row counts once, even when the suite holds dozens of skills.
- Value comparisons use the registry's own rule: best-in-class per slot value (install count, official publisher, or measured benchmark). Where I could not verify a registry claim, it is marked **unverified**.
- URL check, 24 Nov 2026: 70 of the registry's 72 unique URLs return HTTP 200. The 2 exceptions are listed under Flagged items. Install counts, star counts, and benchmarks were not re-checked; they are registry claims, not my verified findings.
- The registry's "NOL GAP" status is Galih's claim about the registry's own coverage (every taxonomy slot has a row). It is not a claim that the repo covers those rows. The repo does not: see the counts below.

## Summary counts

- Registry rows: **76** (A1-A13 company: 60, B life: 16).
- Fully covered by a repo skill: **3** (brainstorming, systematic-debugging, verification-before-completion).
- Partially covered: **4** (superpowers + addyosmani full suite, Haines marketing + seo-audit + ai-seo, Sushegaad GRC suite, skill factory).
- Missing from the repo: **69**.
- Repo individual skills: **89**. With at least partial registry coverage: **14**. Repo-only: **75**.
- Scaffold curated set: **38 skills**. Of those, **12** map to a registry row (full or partial). The other 26 are repo-only homegrown skills.
- Value comparisons where the registry pick is better than the repo's current skill for the same slot: **6**, plus **1** extra slot the repo does not cover at all (ai-seo). See Value comparisons.
- Ronde-14 addendum: **14** new rows (6 A14 Trading, 2 A4 Sales/Negotiation, 4 A13 Experimentation/BI, 2 A12 Office). All 14 are Missing from the repo. Totals for v14: **90** rows, covered **3**, partial **4**, missing **83**.
- Ronde-15 addendum: **8** new rows (1 A15 External Relations, 4 company rows, 3 life domains). 7 Missing, 1 Partial (fundraising). Totals for v15: **98** rows, covered **3**, partial **5**, missing **90**.

## Row-by-row mapping

### A1. Executive & Strategy

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| product-manager-skills (deanpeters, 77 skill) | Missing | - | Repo has a homegrown PM trio (write-a-prd, prd-to-plan, prd-to-issues), not the suite. See value comparison 1. |
| addyosmani/agent-skills (25 skill) | Missing | - | Repo has requesting-code-review + receiving-code-review (narrower). See value comparison 2. |

### A2. Product

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| product-manager-skills (deanpeters), PM lifecycle | Missing | - | Same source as the A1 row, listed twice in the registry (two slots, one suite). Repo trio covers the lifecycle narrowly. |
| figma (official) + Mobbin | Missing | - | No design-tool skill in the repo. The ui-ux-designer agent exists but has no figma skill. |
| emilkowalski/skills | Missing | - | No motion/design-engineering skill in the repo. |
| animate-skill (delphi-ai) | Missing | - | No animation skill in the repo. |

### A3. Engineering

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| brainstorming (obra, 441K) | Covered | brainstorming | Same skill family, adapted from superpowers. Equal value. |
| systematic-debugging (obra, 346K) | Covered | systematic-debugging | Same skill family. Equal value. |
| verification-before-completion (obra, 289K) | Covered | verification-before-completion | Same skill family. Equal value. |
| obra/superpowers 15 + addyosmani 25 (Full Suite) | Partial | brainstorming, systematic-debugging, verification-before-completion, writing-skills, test-driven-development, subagent-driven-development | 6 obra-derived skills are in the repo. The other 9 superpowers skills and all 25 addyosmani skills are not. |
| andrej-karpathy-skills (multica-ai) | Missing | - | No karpathy skill in the repo. |

### A4. Operations & Delivery

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| Crawlbase | Missing | - | No web-scraping skill in the repo. |
| adam-paterson/skills (sales) | Missing | - | Adjacent: marketing-demand-acquisition, lead-scoring. Not a sales suite. |

### A5. Customer Success

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| customer-success (claude-office-skills) | Missing | - | No customer-success skill in the repo. |
| churn-prevention (borghei) | Missing | - | No churn skill in the repo. |
| service-failure-recovery (Dadmin88) | Missing | - | No service-recovery skill in the repo. |
| handle-customer-complaints (mcpmarket) | Missing | - | No complaint-handling skill in the repo. |
| customerscore.io (6 skill) | Missing | - | No CS-ops skill in the repo. |

### A6. Growth, Creative & Media

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| hyperframes (HeyGen) + replicate | Missing | - | No video-generation skill in the repo. |
| motion-video-skill (Clad012) | Missing | - | No motion-video skill in the repo. |
| claude-remotion-skill (haidrrrry) | Missing | - | No remotion skill in the repo. |
| video-edit-skill (tenfoldmarc) | Missing | - | No video-edit skill in the repo. |
| awesome-claude-video-skills (zhuyansen) | Missing | - | Discovery index, not a skill. No equivalent in the repo. |
| imagegen (OpenAI) + canvas-design (Anthropic) | Missing | - | No image-generation skill in the repo. |
| marketing-skills (Haines) + seo-audit + ai-seo | Partial | seo-audit | Repo has seo-audit (same slot). The Haines suite and ai-seo (AI search) are missing. Adjacent homegrown: copywriting, content-strategy, marketing-psychology. |
| typefully + social-media-skills (Hills) | Missing | - | Adjacent homegrown: social-content. Not a publishing/production suite. |
| resend + courier-skills | Missing | - | No messaging-infra skill in the repo. |
| humanizer (blader) | Missing | - | No humanizer skill in the repo. Adjacent: writing-skills. |
| avoid-ai-writing (conorbronsdon) | Missing | - | No anti-slop audit skill in the repo. |
| anti-ai-slop-writing (jalaalrd) | Missing | - | No anti-slop constraint skill in the repo. |
| tone-of-voice (entpnomad) | Missing | - | No persona/voice-anchor skill in the repo. |
| brand-voice (stefanoskarakasis) | Missing | - | No brand-voice drift-audit skill in the repo. |
| writing-style-skill (lout33) | Missing | - | No personal-style rewrite skill in the repo. |

### A7. People & HR

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| talent-acquisition (borghei) | Missing | - | No HR skill in the repo. |
| hr-talent (travisjneuman) | Missing | - | No HR skill in the repo. |
| Pairwise recruiting-skills | Missing | - | No recruiting skill in the repo. |
| borghei/Claude-Skills (397 skill) | Missing | - | Cross-library. No equivalent in the repo. |

### A8. Finance, Payments & Accounting

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| stripe (official) | Missing | - | No payments skill in the repo. |
| binance + coinbase (official) | Missing | - | No crypto skill in the repo. |
| openaccountant/skills (44) | Missing | - | Adjacent homegrown: accounting, financial-analyst, saas-finops-optimization, finance-based-pricing-advisor. Not a 44-skill suite. See value comparison 4. |
| accounting-skills (ReInvestWealth) | Missing | - | No periodic-reporting skill in the repo. |
| startup-bookkeeper (vpodugu) | Missing | - | No bookkeeping skill in the repo. |
| invoice-automation + quickbooks-automation | Missing | - | No invoice-automation skill in the repo. |
| quickbooks reconciliation agent | Missing | - | No QBO API skill in the repo. |

### A9. Legal, GRC & Compliance

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| claude-legal-skill (evolsb, CUAD) | Missing | - | Adjacent homegrown: contract-review, legal-advisor, contract-and-proposal-writer. Not CUAD-grounded. See value comparison 5. |
| claude-for-legal (Anthropic) + ai-legal-claude | Missing | - | No legal suite in the repo. |
| Sushegaad GRC suite | Partial | gdpr-compliance, iso-42001-ai-governance, gdpr-ccpa-privacy-auditor, open-source-license | Repo has compliance skills in the slot. The benchmarked GRC suite itself is not in the repo. See value comparison 6. |

### A10. Security

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| owasp-top-ten (Trail of Bits) | Missing | - | Adjacent: cloud-security + 16 offensive/threat-intel skills. No OWASP Top Ten skill as such. |
| Cloudflare sandbox | Missing | - | No sandboxing skill in the repo. |

### A11. Infrastructure & Data

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| terraform (HashiCorp) + Cloudflare suite | Missing | - | No IaC skill in the repo. The Infrastructure department holds only `release` in the scaffold. |
| supabase + neon + clickhouse | Missing | - | No data-infra skill in the repo. |
| sentry + netlify | Missing | - | No monitoring/deploy skill in the repo. |

### A12. Knowledge & Documents

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| Anthropic document suite (docx, pdf, pptx, xlsx, doc-coauthoring) | Missing | - | Adjacent: pr-report, defuddle. Not the Anthropic suite. |
| notion skills | Missing | - | No notion skill in the repo. |
| last-30-days + serpapi-web-search | Missing | - | Adjacent: market-research. Not the same. |
| memory-engineering | Missing | - | No memory skill in the repo. Agents carry memory.md by design, but there is no memory skill. |
| skill-creator + writing-skills + find-skills | Partial | writing-skills | Repo has writing-skills (same skill family). skill-creator and find-skills are missing. |

### A13. Cross-cutting, PM/Agile & BI

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| project-management-skills suite (16) | Missing | - | Adjacent: writing-plans, executing-plans. Not the 16-skill suite. |
| todo-task-planning + project-manager (gendosu) | Missing | - | Adjacent: writing-plans, executing-plans. |
| business-intelligence + CSM + churn-analysis (alirezarezvani) | Missing | - | Adjacent: analytics-tracking, campaign-analytics. Not the BI library. |

### B. Life (WHOQOL 6 domain + PERMA), all 16 rows missing

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| fitness-nutrition (nousresearch) | Missing | - | No life skills in the repo. URL flagged, see Flagged items. |
| AWS HCLS suite (43) | Missing | - | No life skills in the repo. |
| habit-tracker (khalilbenaz) | Missing | - | No life skills in the repo. |
| recovery-day-planner (mohitagw15856) | Missing | - | No life skills in the repo. |
| meditation-wellness-skills (11) | Missing | - | No life skills in the repo. |
| journal-framework (aouellets) | Missing | - | No life skills in the repo. |
| claude-therapist (carrie-lypp) | Missing | - | No life skills in the repo. |
| personal-finance (afrexai) | Missing | - | No life skills in the repo. |
| cooking + meal-plan | Missing | - | No life skills in the repo. |
| travel-planner (TravelSkills) | Missing | - | No life skills in the repo. |
| LoveLab (Gottman) | Missing | - | No life skills in the repo. |
| partner-skill (NatalieCao323) | Missing | - | No life skills in the repo. |
| dating-coach-skill (nelonmelons) | Missing | - | No life skills in the repo. |
| education-agent-skills (165) + socratic-tutor | Missing | - | No life skills in the repo. |
| ResumeSkills (Paramchoudhary) | Missing | - | No life skills in the repo. |
| parenting-family-skills + parenting-child-development-skills | Missing | - | No life skills in the repo. |

## Value comparisons (registry pick vs repo skill, same slot)

Judged by the registry's own rule: install count, official publisher, or measured benchmark. "Unverified" means the underlying registry claim was not re-checked here.

1. **PM lifecycle (A1/A2): deanpeters 77-skill suite vs repo trio (write-a-prd, prd-to-plan, prd-to-issues).** Registry pick is better: one evidence-first suite covering discovery to launch, against three homegrown skills. Unverified: the 77-skill count and the evidence-first claim.
2. **Adversarial review (A1): addyosmani 25-skill suite vs repo requesting-code-review + receiving-code-review.** Registry pick is better: a full adversarial suite (code review, debugging, security audit, performance) against two narrow review skills. Unverified: the "most-installed champion" claim.
3. **Marketing (A6): Haines marketing-skills suite vs repo copywriting + content-strategy + marketing-psychology.** Registry pick is better: one complete package against three homegrown skills. Unverified: suite completeness.
4. **Accounting (A8): openaccountant 44-skill suite vs repo accounting + financial-analyst + saas-finops-optimization + finance-based-pricing-advisor.** Registry pick is better: 44 free open-source skills (P&L, budgeting, tax prep, debt payoff) against four homegrown skills. Unverified: the 44-skill count and Apr 2026 activity.
5. **Contract review (A9): evolsb claude-legal-skill (CUAD-grounded, 41 categories, 510 real contracts) vs repo contract-review + legal-advisor + contract-and-proposal-writer.** Registry pick is better: grounded in a research benchmark, against homegrown skills. Unverified: the CUAD grounding.
6. **GRC (A9): Sushegaad GRC suite (92% with skill vs 53% without, per registry) vs repo gdpr-compliance + iso-42001-ai-governance + gdpr-ccpa-privacy-auditor + open-source-license.** Registry pick is better on measured evidence. Unverified: the 92%/53% benchmark was not re-run here.
7. **Extra slot (A6): ai-seo (answer engines).** The registry covers a slot the repo misses entirely. Repo seo-audit covers classic search only.

**Equal value (same skill family on both sides):** brainstorming, systematic-debugging, verification-before-completion, writing-skills. The repo skills are the obra family the registry names, so there is nothing to compare.

## Repo-only skills (75): keep or cut proposals

Grouped by theme. "Keep" means the skill serves a slot the registry does not cover, or is Forge-specific infrastructure. "Candidate to cut" means the registry covers the slot better, or the skill is a narrow tactic. All proposals only; nothing is deleted here.

- **Core loop, homegrown (6): forge, using-forge-anything, writing-plans, executing-plans, company-creator, doc-maintenance.** Keep. Forge-specific infrastructure: the loop, the plugin bootstrap, the company package format. The registry has no equivalent because it catalogs third-party best-in-class skills, not the Forge system itself.
- **PM/product, homegrown (5): write-a-prd, prd-to-plan, prd-to-issues, ubiquitous-language, json-canvas.** Candidate to cut or narrow: the registry's deanpeters suite covers the PM lifecycle (comparison 1). Keep only if the trio does something the suite does not (Forge-specific PRD-to-plan-to-issues flow). json-canvas has no registry row; judge it on its own value.
- **Executive/founder (8): founder-context, pitch-deck, investor-research, board-update, data-room, accelerator-application, fundraising-email, founder-thought-leadership.** Keep-with-reason: founder-facing workflow the registry does not catalog (it has no founder-ops rows). Pitch-deck and investor-research overlap the registry's PM/strategy suites only loosely.
- **Engineering, homegrown (8): requesting-code-review, receiving-code-review, finishing-a-development-branch, release, release-changelog, create-agent-adapter, playwright-pro, vercel-react-best-practices.** Mixed. Keep release, release-changelog, create-agent-adapter (Forge release flow and adapter tooling, no registry row). Candidate to cut requesting/receiving-code-review if the addyosmani suite is adopted (comparison 2). playwright-pro and vercel-react-best-practices are tool-specific; judge on their own value.
- **Creative, homegrown (2): content-creator, social-content.** Candidate to cut or narrow: the registry's social-media-skills (Hills, 17 sub-skills) and typefully cover the slot with more breadth. Keep only the Forge-specific voice/format parts, if any.
- **Growth tactics (15): analytics-tracking, campaign-analytics, market-research, competitor-alternatives, marketing-ideas, marketing-demand-acquisition, ab-test-setup, lead-scoring, onboarding-cro, page-cro, paywall-upgrade-cro, programmatic-seo, referral-program, revenue-architect, schema-markup.** Mixed. Keep analytics-tracking and market-research (measurement and research primitives). The CRO tactics (onboarding-cro, page-cro, paywall-upgrade-cro) and narrow plays (referral-program, ab-test-setup) are candidates to cut or fold into the registry's marketing suite if adopted. schema-markup and programmatic-seo are single-purpose; judge on their own value.
- **Security offensive/threat-intel (16): eradicating-malware-from-infected-systems, executing-active-directory-attack-simulation, executing-phishing-simulation-campaign, executing-red-team-engagement-planning, executing-red-team-exercise, generating-threat-intelligence-reports, intercepting-mobile-traffic-with-burpsuite, investigating-phishing-email-incident, mapping-mitre-attack-techniques, monitoring-darkweb-sources, profiling-threat-actor-groups, recovering-deleted-files-with-photorec, recovering-from-ransomware-attack, reverse-engineering-malware-with-ghidra, testing-for-xss-vulnerabilities-with-burpsuite, tracking-threat-actor-infrastructure.** Keep-with-reason, out of scaffold: the registry's security rows cover AppSec audit (OWASP) and sandboxing only. These 16 are the specialized offensive and threat-intel depth the registry does not catalog. The scaffold already excludes them by design; they stay in the full repo only.
- **Security defensive, homegrown (1): cloud-security.** Keep: defensive baseline, no registry row for it directly (registry names OWASP audit and sandboxing, not cloud hardening).
- **Finance, homegrown (4): accounting, financial-analyst, finance-based-pricing-advisor, saas-finops-optimization.** Candidate to cut or narrow: the registry's openaccountant suite covers the accounting slot with more breadth (comparison 4). Keep finance-based-pricing-advisor and saas-finops-optimization only if they do something the suite does not (pricing and FinOps are named as separate slots in the registry's finance section only through the suite).
- **Legal, homegrown (4): contract-review, legal-tos-privacy, legal-advisor, contract-and-proposal-writer.** Candidate to cut or narrow: the registry's CUAD-grounded legal skill and the Anthropic legal suite cover the slot with evidence grounding (comparison 5). Keep legal-tos-privacy only if it does something the suites do not.
- **Knowledge (5): obsidian-markdown, obsidian-cli, obsidian-bases, defuddle, pr-report.** Keep: Obsidian and document tooling the registry does not catalog (the registry's knowledge rows are the Anthropic doc suite, notion, research, and memory). These are Forge's own knowledge workflow.
- **forge-specialist (1).** Keep: the fallback agent-skill for work that does not fit one department. No registry row, by design.

## Taxonomy mismatch (registry vs repo departments)

The registry derives departments from APQC PCF v7.4 (13 company categories) plus WHOQOL 6 domains + PERMA (life). The repo has 10 departments: Executive, Product, Engineering, Creative, Growth, Security, Infrastructure, Finance, Legal, Knowledge. The mapping is not 1:1, and this review does not propose restructuring the departments (the 10 departments are decided).

- **No repo department for:** A4 Operations & Delivery, A5 Customer Success, A7 People & HR, A13 Cross-cutting PM/BI, and all of B Life (16 rows). If those rows are adopted later, they need a home: either a new department (a Galih decision) or placement under an existing one (for example, Customer Success under Growth, PM/BI under Product or Executive). This review proposes no placement.
- **Split across two repo departments:** A6 Growth, Creative & Media spans repo Creative + Growth. The registry groups them; the repo splits them. Both are defensible; the split is the repo's decided shape.
- **Thin repo department:** A11 Infrastructure & Data maps to repo Infrastructure, but the repo's Infrastructure department holds only `release` in the scaffold. The registry's IaC, data, and monitoring rows would thicken it if adopted.
- **Clean maps:** A1 Executive, A2 Product, A3 Engineering, A8 Finance, A9 Legal/GRC (Legal, plus GRC under Security), A10 Security, A12 Knowledge & Documents (Knowledge).
- **Agents:** the registry derives agents from jobs (1 job = 1 agent only when verification and incentives differ). The repo has 41 agents. This review maps skills only; agent coverage is a separate review and is not attempted here.

## Flagged items

1. **Dead citation URL (404, confirmed twice, 24 Nov 2026):** `https://med.stanford.edu/content/dam/s-sm/s-spire/documents/PD.locke-and-latham-retrospective_Paper.pdf` (Locke & Latham goal-setting paper, cited in the A7 note). It is a research citation, not a skill URL, so no registry row is affected. The citation link needs a replacement source.
2. **Server-error URL (HTTP 500, checked twice, 24 Nov 2026; first check timed out):** `https://www.getclaudeskills.com/skills/fitness-nutrition-nousresearch` (fitness-nutrition skill, B Life). Not confirmed dead (server error, not 404). The row needs a manual re-check; the skill may work later or live at another path.
3. **Unverified registry claims (not re-checked here):** all install counts (441K, 346K, 289K, 245K, 73K, 5.0K), star counts (595, 226K+, 2.1K), the GRC 92%/53% benchmark, the CUAD grounding claim, and the "NOL GAP" status claim. URLs were checked; counts and benchmarks were not. Re-check them when a row is adopted.
4. **Duplicate source, two slots:** the registry lists deanpeters product-manager-skills twice (A1 Strategist, A2 PM Lifecycle). One source, two value rows by design. The mapping counts it once per row, as the registry does.
5. **Known gap inside the registry itself (A7 note):** performance goal-setting and psychological safety are still research (Locke & Latham, Edmondson). No marketplace skill was found for them. Recorded here, not fixed here.

---

## Ronde-14 addendum

Reviewed 24 Nov 2026, repo HEAD `a03af575`. The registry's ronde-14 adds 14 rows (the message says 13 new slots; I count 14 distinct skill rows in the message text: 6 A14 + 2 A4 + 4 A13 + 2 A12). All 14 are Missing from the repo. Totals for v14: 90 rows, covered 3, partial 4, missing 83.

### A14. Trading, Markets & On-chain (new department, all 6 Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| agiprolabs/claude-trading-skills (68 skill) | Missing | - | No trading/on-chain skill in the repo. Closest is the registry's own A8 binance/coinbase row (exchange market data/custody), which the repo does not have either. Repo finance skills (accounting, financial-analyst, finance-based-pricing-advisor, saas-finops-optimization) are accounting/pricing/FinOps, not trading. |
| tradermonty/claude-trading-skills (discipline gate) | Missing | - | No discipline-gate or trading-journal skill in the repo. |
| truenorth-lj/crypto-project-security-skill | Missing | - | No DeFi/smart-contract audit skill in the repo. Repo security skills are AppSec/OWASP and offensive/threat-intel, not DeFi risk. |
| ai-crypto-claude (zubair-trabzada, token research) | Missing | - | No token-research skill in the repo. |
| redlabs-sc cryptocurrency-trader-skill (TA) | Missing | - | No technical-analysis skill in the repo. |
| day-trader-skill (Jakeschincariol, Alpaca loop) | Missing | - | No broker-execution skill in the repo. The human-gate ("no order without yes") matches the repo's own approval-gate protocol in spirit, but there is no skill for it. |

### A4. Sales/Negotiation (both Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| Sales MBA (lancewc/sales-claude-skills) | Missing | - | Adjacent: marketing-demand-acquisition, lead-scoring (growth tactics). Not a B2B AE suite. The A4 row adam-paterson/skills (sales) is also missing, so the repo has no sales suite at all. |
| negotiation (mikesmayer/claude-business-skills) | Missing | - | No negotiation skill in the repo. |

### A13. Experimentation/BI (all 4 Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| data-scientist (borghei, A/B + hypothesis testing) | Missing | - | Adjacent: ab-test-setup (growth tactic, setup only, not A/B design + hypothesis testing), experimentation-engineer agent, experiment command. No data-scientist skill. No URL in the ronde-14 message, so the source is unverified here. |
| sql-queries (Anthropic, 5 dialects) | Missing | - | No SQL skill in the repo. No URL in the ronde-14 message, so the source is unverified here. |
| dbt (dbt Labs) | Missing | - | No dbt skill in the repo. No URL and no value description in the ronde-14 message. |
| data-analysis-skill (dongzhang84) | Missing | - | Adjacent: analytics-tracking, campaign-analytics, market-research. Not a multi-expert data-analysis skill. |

### A12. Office (both Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| meeting-notes (claude-office-skills) | Missing | - | Adjacent: doc-maintenance, doc-updater agent. Not meeting notes. No URL in the ronde-14 message, so the source is unverified here. |
| email (analystacademy/claude-skills) | Missing | - | Adjacent: email-marketing-bible, fundraising-email (marketing/fundraising email). Not voice-profile email writing from the user's own emails. |

### Taxonomy note: A14 has no repo department

The registry now has 14 company departments (A1-A14) plus 16 life domains. The repo still has 10 departments. A14 Trading, Markets & On-chain joins A4 Operations, A5 Customer Success, A7 People/HR, A13 Cross-cutting, and all of B Life as registry sections with no repo department. The repo's Finance department covers cost, budgeting, accounting, financial state, and runway, not trading. If A14 rows are adopted later, they need a home: either a new 11th department (a Galih decision) or placement under Finance. This review proposes no placement. The A14 correction matters more than the other gaps because trading/on-chain is Galih's core domain (Galyarder Labs is finance + AI, and his own allocation is 50% BTC): the repo currently has zero trading coverage, while the registry's A8 finance rows (Stripe, Binance/Coinbase, openaccountant) are payments, exchange data, and accounting, not trading.

### Flagged items (ronde-14)

1. **Count discrepancy:** the ronde-14 message says 13 new slots, but lists 14 distinct skill rows. Recorded as 14 here. The difference is counting method, not content.
2. **4 rows without a source URL in the ronde-14 message:** borghei data-scientist, sql-queries (Anthropic), dbt (dbt Labs), meeting-notes (claude-office-skills). Their sources are unverified until URLs are supplied. They should not be adopted on name alone.
3. **Unverified registry claims (ronde-14):** the agiprolabs 68-skill count, the "production-grade B2B AE" claim for Sales MBA, the "lolos 3 audit" claim for meeting-notes, and the v14 totals (±85 rows / 260+ skills). URLs were checked (10 of 10 return HTTP 200); counts and claims were not.

---

## Ronde-15 addendum

Reviewed 24 Nov 2026, repo HEAD `2fa091d2`. The registry's ronde-15 adds 8 rows (1 new department A15 External Relations, 4 company rows, 3 life domains). 7 are Missing, 1 is Partial (fundraising). Totals for v15: 98 rows, covered 3, partial 5, missing 90.

### A15. External Relations (new department, Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| pr-skills (Insightful-Pipe) + autopunk-media-skills (ur-grue, 394 skill) | Missing | - | No PR/crisis-comms skill in the repo. The repo has founder-thought-leadership and copywriting, which are adjacent (thought leadership and copy) but not PR: no releases, media kits, coverage reports, or crisis comms. This is an APQC category the research agent had marked since ronde-1 and never filled. |

### A1. Fundraising & investor relations (Partial)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| cc-skills-vc-fundraising (tjboudreaux) + pitch-deck-mastery (Stevekaplanai) | Partial | pitch-deck, investor-research | Repo has pitch-deck and investor-research skills (founder-facing workflow), but not the VC fundraising suite grounded in Sequoia/a16z/Benchmark/YC first principles or the 12-slide framework. The registry row is the suite; the repo covers the deck and research parts narrowly. |

### A10. Smart contract audit (Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| smart-contract-auditor-skill (farrellh1, Cyfrin checklist) + Smart-Contract-AI-Audit-Skill (giladHaimov, 293 vulnerabilities) | Missing | - | No smart-contract audit skill in the repo. Repo security skills are AppSec/OWASP and offensive/threat-intel, not smart-contract audit. This is Galih's core blockchain domain; the registry's v14 A8 row (binance/coinbase) only covers exchange market data/custody. |

### A6. Paid media (Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| claude-ads (AgriciDaniel, 12 platforms) | Missing | - | No paid-ads skill in the repo. Adjacent: seo-audit (organic search), campaign-analytics, marketing-demand-acquisition. None cover paid media buying across platforms. |

### A4. Automation (Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| n8n-skills (czlonkowski) + zapier-workflows (davila7) | Missing | - | No n8n or Zapier automation skill in the repo. No URL for zapier-workflows in the ronde-15 message, so that source is unverified here. |

### B. Life, new domains (all 3 Missing)

| Registry row | Status | Repo skill | Note |
|---|---|---|---|
| public-speaking-skill (guycoful) + presentation-writing-claude-skill (marcusnelson) | Missing | - | No public-speaking or presentation-writing skill in the repo. |
| podcast-transcripts (nish-sco) + claude-transcribe-youtube (kezsmeister) | Missing | - | No podcast/audio-ops skill in the repo. Galih produces a podcast (the Ayanokoji episode, 9 Nov 2026), so this is a real workflow gap, not a hypothetical one. |
| biohacking-advisor (Huberman/Attia) + sleep-optimizer (skillmedev, Grade A) + health-skill (googlarz) | Missing | - | No biohacking/sleep/longevity skill in the repo. The registry's B fitness-nutrition row is the only health coverage. No URL for biohacking-advisor in the ronde-15 message, so that source is unverified here. |

### Taxonomy note: A15 and the life split

The registry now has 15 company departments (A1-A15) plus 19 life domains. The repo still has 10 departments. A15 External Relations joins A4, A5, A7, A13, A14, and all of B Life as registry sections with no repo department. The placement of the 3 life rows (public speaking, podcast/audio ops, biohacking) is a maintainer reading of the message's totals (15 departments + 19 life domains); the message does not label which sectors are life. If Galih places them differently (for example, podcast under Creative as media production), the row counts do not change, only the section.

### Flagged items (ronde-15)

1. **Count discrepancy:** the ronde-15 message says ±99 rows; this addendum counts 8 new rows for a total of 98 (90 v14 + 8). The difference is 1 row inside the ± tolerance. Recorded as 98 here.
2. **2 rows without a source URL in the ronde-15 message:** zapier-workflows (davila7), biohacking-advisor. Their sources are unverified until URLs are supplied. They should not be adopted on name alone.
3. **Unverified registry claims (ronde-15):** the autopunk-media-skills 394-skill count and "quality-tested" claim, the "grounded from Sequoia/a16z/Benchmark/YC first principles" claim for the fundraising suite, the giladHaimov 293-vulnerability database claim, the sleep-optimizer Grade A claim, and the v15 totals (±99 rows / 300+ skills). URLs were checked (14 of 14 return HTTP 200); counts and claims were not.
4. **"Nol gap" retired:** the research agent's own correction stands: v13/v14's "NOL GAP" was claimed too fast, and ronde-15 found 8 more sectors. The permanent rule from the message is that "complete" is never claimed again without a closure sweep. This review records that; it does not re-verify the closure sweep itself.

---

## Ronde-16/17/18/19/20 addendum (v20)

Reviewed 25 Nov 2026, repo HEAD `ee652704`. The registry is now v20 (`skill-registry.md`): Galih's v20 file verbatim, replacing v15 as the standard. The v13/v14/v15 reviews above are preserved as history. This addendum reviews only what v20 changes vs v15. Rows carried over unchanged keep the status given above, except the status changes named below.

### Count, counted by hand

The file's rekap says 118 rows (114 post-audit + 4 restore). The maintainer counted the table rows directly: 121 rows. The file's own per-section table sums to 121 (A1 4, A2 3, A3 9, A4 4, A5 5, A6 19, A7 4, A8 6, A9 3, A10 4, A11 6, A12 11, A13 7, A14 8, A15 4, A16 4, B 20). So the rekap total (118) contradicts its own per-section table (121) by 3. The file also says 4 restores, but names 7 restored rows (TestMu, venice-image, vercel, sanity, internal-comms, theme-factory, mcp-builder). Both discrepancies are recorded here, not fixed here: the registry text is Galih's verbatim and is not edited in place.

### Summary counts (v20)

- Registry rows: 121 (A1-A16 company: 101, B life: 20).
- Fully covered by a repo skill: 0.
- Partially covered: 6.
- Missing from the repo: 111.
- Reference rows (registry rows that are not skills: a structure benchmark, a multi-harness library, a discovery index, a cross-library): 4. They need no repo skill.
- Repo individual skills: 89. With at least partial registry coverage: 13. Repo-only: 76.
- Scaffold curated set: 38 skills. Of those, 12 map to a registry row (unchanged from v15).

Why covered drops from 3 to 0: the three covered obra skills (brainstorming, systematic-debugging, verification-before-completion) no longer appear as separate rows in v20. They are folded into one row, the obra champion suite, which is Partial because the repo holds 6 of the suite's 15 skills. The repo did not lose coverage; the row unit changed. The same 13 repo skills still map to registry rows.

### What v20 changes vs v15

- New department A16. Agent Ops Layer, Gamedev and Scientific (4 rows: agent-browser, agent-desktop, gamedev, scientific research).
- A15 is now External Relations and Fundraising (4 rows). The fundraising suite and the pitch deck framework, which v15 kept as one row under A1, are now two rows here, and PR and media production are split into two rows.
- Public speaking moves from B Life to A1. Podcast/audio ops moves from B Life to A6.
- A14 Trading confirmed present (8 rows). The smart contract audit rows move from A10 (v15 addendum) into A14.
- Restores: TestMu QA (A3), venice-image (A6), vercel and sanity (A11), internal-comms, theme-factory, mcp-builder (A12). All were lost in the ronde-11 rebuild and are back.
- Ronde-19 audit cuts 9 redundancies/misplacements: addyosmani moves from A1 to A3; the obra rows merge into 1; delphi-ai, jakubkrehel, adam-paterson, humanizer, analystacademy email, and sleep-optimizer are demoted to alternatives under the row of their value; the QBO reconciliation row merges into the invoice row.
- New rows vs v15 (30): mattpocock, agency-agents, Orchestra AI-research, wshobson, team-orchestration, bug-hunter, prompt/RAG, TestMu, stick-scene, venice-image, community-ops, security-audit-skill, bug-bounty, devops-skills, vercel, sanity, internal-comms, theme-factory, mcp-builder, diagram-design, claude-obsidian, market research, media production (split), pitch-deck-mastery (split), language-learning, faith, agent-browser, agent-desktop, gamedev, scientific research.
- Rows folded or removed as rows (5): delphi-ai, humanizer, analystacademy email, adam-paterson, QBO reconciliation. The obra merge (4 rows to 1) and the sql/dbt merge (2 rows to 1) are restructures, not removals.

### New and moved rows, mapped

| Registry row (v20) | Status | Repo skill | Note |
|---|---|---|---|
| mattpocock/skills (A1, adversarial thinking) | Missing | - | Repo has requesting/receiving-code-review (code level, narrower). Idea/doc level adversarial has no repo skill. |
| agency-agents (A1, msitarzewski) | Reference | - | Structure benchmark, not a skill. No repo equivalent needed. |
| Orchestra AI-Research-SKILLs (A3) | Missing | - | No AI-research skill in the repo. Core Galyarder Labs domain. |
| wshobson/agents (A3) | Reference | - | Multi-harness library, not a skill. |
| claude-team-orchestration (A3) | Missing | - | No team-orchestration skill in the repo. Adjacent: subagent-driven-development (single-agent delegation, not team patterns). |
| project-bug-hunter-skill (A3) | Missing | - | Adjacent: systematic-debugging (method) and build-error-resolver agent. No evidence-first bug-hunt skill. |
| senior-prompt-engineer + rag-architect (A3) | Missing | - | No prompt-eval or RAG-design skill in the repo. The rag-architect URL in the file is the wrong path; the correct path is verified in Flagged items. |
| TestMu QA, 40+ skills (A3) | Missing | - | Adjacent: playwright-pro (tool-specific), test-driven-development (method). No publisher QA suite. |
| stick-scene (A6, product demo) | Missing | - | No product-demo skill in the repo. |
| venice-image (A6, private image) | Missing | - | No private image skill in the repo. No image skill at all. |
| community-ops (A6) | Missing | - | No community skill in the repo. Design held: the community-management URL is dead (see Flagged items). |
| security-audit-skill (A10, cloudflare official) | Missing | - | Adjacent: security-reviewer/security-guardian agents and the 16 offensive skills. No multi-phase audit skill as such. |
| bug-bounty-agent-skills (A10, murrtada, 93) | Missing | - | Adjacent: the 16 offensive/threat-intel skills (threat intel, not bounty workflow). |
| devops-skills (A11, anmolnagpal) | Missing | - | Adjacent: release skill (Forge release flow, not DevOps workflows). No IaC/CI/CD skill. |
| vercel, official (A11) | Missing | - | No frontend-deploy skill in the repo. |
| sanity, official (A11) | Missing | - | No CMS skill in the repo. |
| internal-comms (A12, Anthropic) | Missing | - | No internal-comms skill in the repo. Adjacent: doc-maintenance, pr-report. |
| theme-factory (A12, Anthropic) | Missing | - | No theming skill in the repo. |
| mcp-builder (A12, Anthropic) | Missing | - | Adjacent: mcp-builder agent (integration, not skill generation). No MCP-builder skill. |
| diagram-design (A12, cathrynlavery) | Missing | - | No diagram skill in the repo. |
| claude-obsidian (A12, AgriciDaniel) | Missing | - | Adjacent: obsidian-markdown, obsidian-cli, obsidian-bases (Obsidian tooling, not the second-brain method with wiki-ingest and autoresearch). |
| market research + competitive intel (A13) | Missing | - | Adjacent: market-research (repo skill, a research primitive). The registry row is C-level intel plus a 9-dimension teardown, broader than the repo skill. |
| media production (A15, autopunk, split) | Missing | - | No PR/media-production suite in the repo. |
| pitch-deck-mastery (A15, split) | Partial | pitch-deck | Repo has pitch-deck. The 12-slide framework and review checklist are missing. |
| agent-browser (A16, vercel-labs) | Missing | - | No browser-automation skill in the repo. |
| agent-desktop (A16, vercel-labs) | Missing | - | No computer-use skill in the repo. |
| gamedev (A16) | Missing | - | No gamedev skill in the repo. |
| scientific research (A16, K-Dense) | Missing | - | No scientific-research skill in the repo. |
| language-learning (B) | Missing | - | No language-learning skill in the repo. |
| faith (B, skill-islamic-salafi + ansari-skill) | Missing | - | No faith skill in the repo. |
| addyosmani/agent-skills (moved A1 to A3) | Missing | - | Status unchanged from v13. |
| obra champion suite (merged, A3) | Partial | brainstorming, systematic-debugging, verification-before-completion, writing-skills, test-driven-development, subagent-driven-development | Was 3 Covered + 1 Partial in v15. Now one Partial row: the repo holds 6 of the suite's 15 skills. |
| fundraising (moved A1 to A15) | Partial | pitch-deck, investor-research | Status unchanged from v15. |
| smart contract audit (moved A10 to A14, 2 rows) | Missing | - | Status unchanged from v15. |
| public speaking (moved B to A1) | Missing | - | Status unchanged from v15. |
| podcast/audio ops (moved B to A6) | Missing | - | Status unchanged from v15. |
| sql-queries + dbt (merged, A13) | Missing | - | Status unchanged from v14. Both now have URLs in v20. |
| QBO reconciliation (merged into invoice row, A8) | Missing | - | Status unchanged from v13. |

### Status changes vs v15

- Covered 3 to 0 (obra merge, see above). The repo did not lose coverage.
- Partial 5 to 6 (obra suite, marketing, GRC, skill factory, fundraising, pitch-deck). The pitch-deck row is the new sixth partial: it split out of the fundraising row.
- The 6 rows that had no URL in v14/v15 (borghei data-scientist, sql-queries, dbt, meeting-notes, zapier-workflows, biohacking-advisor) all have URLs in v20. All 6 were checked; all 6 return HTTP 200 (see URL check).

### URL check, 25 Nov 2026

42 URLs are new in v20 vs v15. 40 return HTTP 200 (37 on the first pass, 3 after a sequential re-check: they first returned 429, GitHub rate limiting on the parallel batch, then 200). 2 are dead:

1. **rag-architect (Jeffallan), wrong path in the file: HTTP 404.** The file links `github.com/Jeffallan/claude-skills/blob/main/skills/rag-architect/SKILL.md`. The skill exists at `github.com/Jeffallan/claude-skills/blob/main/plugin/skills/rag-architect/SKILL.md`, verified HTTP 200 on 25 Nov 2026. The registry text is verbatim, so the file keeps the wrong URL; the correct path is recorded here and in the curation plan.
2. **community-management (absolutelyskilled): unreachable.** The file links crossaitools.com, which redirects to claudemarketplaces.com and returns HTTP 403 there (checked 25 Nov 2026; the earlier check returned 410 on the same redirect). The design that uses this row is held until a replacement source exists.

One more dead URL was found in the same pass, also new in v20:

3. **n8n official skill (`n8n-io/n8n/blob/master/.claude/skills/n8n-conventions/SKILL.md`): HTTP 404.** The `.claude/skills` path does not exist in the n8n repo at all (verified via the GitHub API on 25 Nov 2026: `.claude/` holds only README.md, plugins, and settings.json). No replacement path was found. The row's other source, czlonkowski/n8n-skills, returns HTTP 200.

Re-checks from the v13 review:

- **fitness-nutrition (getclaudeskills.com): still HTTP 500** (third check, 25 Nov 2026). Not confirmed dead (server error, not 404). The row still needs a manual re-check.
- **Locke and Latham citation (med.stanford.edu PDF): still HTTP 404** (25 Nov 2026). Research citation, not a skill URL; no registry row is affected.

### Value comparisons, updated

The 6 comparisons from the v13 review stand (PM lifecycle, adversarial review, marketing, accounting, contract review, GRC), plus the extra slot ai-seo. One new comparison:

8. **QA (A3): TestMu 40+ skill suite vs repo playwright-pro.** Registry pick is broader: a publisher QA suite (test planning, automation, CI validation) against one tool-specific skill. Unverified: the 40+ skill count.

Extra slots the repo misses entirely (in addition to ai-seo): AI-research, team-orchestration, gamedev, scientific research, agent-browser and agent-desktop. All are new v20 rows with no repo skill at all.

### Taxonomy note: A16 splits, the rest still have no home

The registry now has 16 company departments (A1-A16) plus 20 life domains. The repo still has 10 departments. A16 has no single home: agent ops maps to Infrastructure, gamedev maps to Creative, scientific research maps to Knowledge. Whether A16 should be its own department is an open question for Galih (curation plan question 17). A4 Operations, A5 Customer Success, A7 People/HR, A13 Cross-cutting, A14 Trading, A15 External Relations, and all of B Life still have no repo department, as in v15. A1 now holds public speaking (Executive) and A6 now holds podcast/audio ops (Creative/Growth).

### "NOL GAP" note

The file's title and status line claim "NOL GAP + NOL REDUNDANSI". That is the research agent's claim, not a verified fact. The v15 permanent rule stands: never claim complete without a closure sweep. This review does not verify the claim, and the rekap's own arithmetic does not add up (118 vs 121, 4 restores vs 7 named), which is itself evidence a closure sweep is still owed before the claim is trusted.

### Flagged items (v20)

1. **Count discrepancy (see above):** rekap says 118 rows and 4 restores; the file's own per-section table sums to 121 rows and names 7 restored rows. Recorded, not fixed.
2. **Dead URLs (3):** rag-architect wrong path (404, correct path verified 200), community-management (403 via redirect, was 410), n8n-conventions (404, path does not exist in the repo).
3. **Still bad on re-check:** fitness-nutrition HTTP 500 (third check), Locke and Latham citation HTTP 404.
4. **Unverified registry claims (not re-checked here):** all install counts, star counts, the GRC 92%/53% benchmark, the CUAD grounding claim, suite counts (68, 44, 394, 293, 77, 25, 40+), and the "NOL GAP" status claim. URLs were checked; counts and benchmarks were not. Re-check them when a row is adopted.
5. **Known gap inside the registry itself (A7 note, carried from v13):** performance goal-setting and psychological safety are still research (Locke and Latham, Edmondson). No marketplace skill was found for them. Recorded here, not fixed here.
