# Skill Registry Review vs Current Repo

Maintainer review, 24 Nov 2026, repo HEAD `2fa091d2`. This reviews Galih's Essential Skill Registry v15 (`skill-registry.md`): the v13 text verbatim plus the ronde-14 and ronde-15 addenda. The v13 rows were reviewed at HEAD `00b0080c`; the ronde-14 rows at HEAD `a03af575`; the ronde-15 rows are reviewed in the addendum at the end of this file. It is a proposal record only: it does not add, delete, rename, or restructure anything. Curation decisions stay with Galih.

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
