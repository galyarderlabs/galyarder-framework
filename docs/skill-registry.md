> **Maintainer note (this block is not part of Galih's registry text).** This is Galih's research registry, Essential Skill Registry v20 (dated 24 Nov 2026 in the file, received from Galih 25 Nov 2026). It replaces v15 as the curation standard. The v13 text and the ronde-14/ronde-15 addenda are preserved in git history (commits ee125c9d, 2fa091d2, acef19f0). The text below is copied verbatim from Galih's v20 file; do not edit it in place. The file's own rekap says 118 rows, but the maintainer counted 121 table rows (its per-section table sums to 121; see the review). The "NOL GAP" claim in the file is the research agent's claim, not a verified fact. The review of this registry against the repo's current skills lives in [skill-registry-review.md](skill-registry-review.md).

# Forge Foundation: Essential Skill Registry v20 — LEAN, NOL GAP

Registry skill essential untuk Forge, diturunkan dari taksonomi riset dunia — bukan dari daftar yang dibikin-bikin.

**Rantai derivasi (bisa diaudit):**
1. **Departemen** ← APQC PCF v7.4 (13 kategori, standar cross-industry 1992) untuk sisi perusahaan; **WHOQOL 6 domain + PERMA** untuk sisi kehidupan.
2. **Agent per departemen** ← job berulang + verifikasi + insentif. 1 job = 1 agent hanya kalau verifikasi & insentifnya beda.
3. **Skill per agent** ← best-in-class per slot VALUE (bukan per nama): install count, publisher resmi, atau benchmark terukur. Suite fungsi serupa = satu baris.

**Aturan kurasi:** essential only, redundansi dinilai by value bukan by nama, tiap skill punya nama real + URL sumber + alasan.

---

# A. PERUSAHAAN

## A1. Executive & Strategy

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Strategist | product-manager-skills (deanpeters, 77 skill) — evidence-first strategy, positioning, roadmap | Suite strategi terbesar yang menuntut bukti per klaim | [deanpeters/product-manager-skills](https://github.com/deanpeters/product-manager-skills) |
| Adversarial Thinking (ide/dokumen) | mattpocock/skills — grill-me (interogasi ide/asumsi), grill-with-docs, engineering + productivity; "Skills for Real Engineers" | Pandangan adversarial cara engineer; pelengkap Osmani (code-level) di level ide/dokumen | [mattpocock/skills](https://github.com/mattpocock/skills) |
| Agent org lintas fungsi | msitarzewski/agency-agents — ±170 persona agent profesional per fungsi bisnis (engineering, design, marketing, sales, product, testing, security, support) + pack finance/health/gamedev; 158K★ | Kandidat pembanding struktur tim agen Forge — bukan pengganti departemen, tapi benchmark persona per fungsi | [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) |
| Public Speaking Coach | `public-speaking-skill` (guycoful) — prep talk, persuasion theory, storytelling, body language; + `presentation-writing` (marcusnelson: notes/data → slide-by-slide narrative) | Dua value beda: coaching panggung vs penulisan narasi deck; alternatif TED-based: [jpoindexter](https://github.com/jpoindexter/presentation-skills) | [guycoful](https://github.com/guycoful/public-speaking-skill) · [marcusnelson](https://github.com/marcusnelson/presentation-writing-claude-skill) |

## A2. Product

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| PM Lifecycle | product-manager-skills (deanpeters) — discovery → spec → launch | Satu siklus PM penuh, satu sumber | [deanpeters/product-manager-skills](https://github.com/deanpeters/product-manager-skills) |
| Design | `figma` (official) + Mobbin reference | Akses desain nyata + pattern library industri | [Figma via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Design Engineering & Motion | **emilkowalski/skills (official Emil Kowalski)** — `animate`, `review-animations`, `learn-taste`, `ask-emil`, `emil-design-eng`, `remove-animations`, `mobile-native` + ui-cheatsheet & performance-cheatsheet | Repo resmi; "based on years at Vercel & Linear"; aktif Nov 2026; `learn-taste` = fitur unik: koreksi desain tiap session jadi rules di DESIGN.md. Alternatif: [jakubkrehel/skills](https://github.com/jakubkrehel/skills) (better-motion, explain-interface) · [delphi-ai/animate-skill](https://github.com/delphi-ai/animate-skill) (quick-ref dari kursus "Animations on the Web") | [emilkowalski/skills](https://github.com/emilkowalski/skills) |

## A3. Engineering

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Engineering Champion Suite | **obra/superpowers 15 skill** — sortir ter-install: `brainstorming` (441K), `systematic-debugging` (346K), `verification-before-completion` (289K) + TDD, refactoring, review | Champion ter-install di tiap fase engineering; verification-before-completion = gate anti-klaim-kosong | [obra/superpowers](https://www.skills.sh/obra/superpowers) |
| Adversarial Code Review | **addyosmani/agent-skills 25 skill** — code review, debugging, security audit, performance | Lawan optimal buat output engineering | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) |
| AI/Agent Architecture & Research (ronde-16) | **Orchestra-Research/AI-Research-SKILLs** — open-source library: architecture, fine-tuning, mechanistic interpretability, post-training, RAG, agents, evals, inference, safety | Domain core Galyarder Labs: riset AI jadi departemen skill sendiri; paling komprehensif untuk AI engineering | [Orchestra-Research/AI-Research-SKILLs](https://github.com/orchestra-research/AI-research-SKILLs) |
| Multi-Harness Library | **wshobson/agents** — 202 agents, 184 skills, 105 commands dalam 94 plugin lintas harness (Claude Code, Codex, Cursor, OpenCode, Antigravity, Copilot, Pi); di-adaptasi per tool via generator + validation + evals | Pustaka agent/skill/command lintas-tool terbesar yang terstruktur; sandingan natural buat tim agent Forge | [wshobson/agents](https://github.com/wshobson/agents) |
| Teaming/Multi-Agent (ronde-17) | `claude-team-orchestration` (zircote-plugins) — agent teams: shared tasks, messaging, **7 pattern termasuk RLM (arXiv:2512.24601)** buat analisis file melebihi context limit; + orchestrator (mdharastani-pixel): routing ke model termurah yang sanggup + self-rating escalation | Dua value beda: pattern koordinasi vs routing biayajangka; domain core agentic lu | [zircote-plugins](https://github.com/zircote-plugins/claude-team-orchestration/blob/main/skills/team-management/SKILL.md) · [mdharastani-pixel](https://github.com/mdharastani-pixel/claude-code-multi-agent-orchestrator) |
| Bug Hunting (in-project) | `project-bug-hunter-skill` (wildanfadh) — hunt bug di project apa pun, **evidence-first: laporan terstruktur sebelum sentuh satu file pun** | Value beda dari code review: framing perburuan bug, bukan review diff | [wildanfadh](https://github.com/wildanfadh/project-bug-hunter-skill) |
| Prompt Eng & RAG | `senior-prompt-engineer` (borghei): deterministic prompt analysis + RAG retrieval/generation evaluation + `rag-architect` (Jeffallan: production RAG pipelines, 67-skill library) | Dua value beda: evaluasi vs desain pipeline | [borghei](https://github.com/borghei/Claude-Skills/blob/main/engineering/senior-prompt-engineer/SKILL.md) · [Jeffallan](https://github.com/Jeffallan/claude-skills/blob/main/skills/rag-architect/SKILL.md) |
| QA/Testing (restore ronde-20) | **TestMu official — 40+ skill QA** (test planning, automation, CI validation) via VoltAgent registry | Slot testing yang hilang pas rebuild ronde-11; publisher-grade; pelengkap verification-before-completion (mindset vs tooling) | [TestMu via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Coding Discipline (Karpathy) | `andrej-karpathy-skills` (multica-ai) — 4 prinsip: no overcomplication, surgical changes, surface assumptions, verifiable success criteria; SKILL.md + plugin | Derivatif langsung dari observasi Karpathy soal kegagalan LLM coding; viral 226K+★ | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) · [SKILL.md](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md) |

## A4. Operations & Delivery

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Web Data Ops | Crawlbase skill | Scraping/ops data web, publisher resmi | [Crawlbase via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Sales (B2B full cycle) | **lancewc/sales-claude-skills "Sales MBA"** — production-grade B2B AE, textbook + interactive | Suite sales paling substantif; redundan-dicut: adam-paterson (sales) & OneWave-AI (200+) jadi alternatif | [lancewc/sales-claude-skills](https://github.com/lancewc/sales-claude-skills) · alt: [adam-paterson](https://github.com/adam-paterson/skills) · [OneWave-AI](https://github.com/OneWave-AI/claude-skills) |
| Negotiation | `negotiation` (mikesmayer/claude-business-skills) — high-stakes, vendor pricing, dispute | Skill negosiasi paling terstruktur; alternatif Voss-style (mirroring/labeling/BATNA): [negotiation-wondelai](https://vibehackers.io/claude-code/skills/negotiation-wondelai) | [mikesmayer/claude-business-skills](https://github.com/mikesmayer/claude-business-skills/blob/main/negotiation/SKILL.md) |
| Workflow Automation | `n8n-skills` (czlonkowski) — n8n expression syntax, node lookup, flawless workflow building; + `zapier-workflows` (davila7) | Dua platform automasi terluas; skill resmi n8n repo ada di [n8n-io/n8n](https://github.com/n8n-io/n8n/blob/master/.claude/skills/n8n-conventions/SKILL.md) | [czlonkowski/n8n-skills](https://github.com/czlonkowski/n8n-skills) · [davila7](https://github.com/davila7/claude-code-templates/blob/main/cli-tool/components/skills/development/zapier-workflows/SKILL.md) |

## A5. Customer Success — REAL (ronde-11, terverifikasi 3 security-audit)

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| CS Manager (onboarding, health scoring, QBR, expansion) | `customer-success` (claude-office-skills) — 5-phase onboarding, health score (40% engagement/25% relationship), QBR template, expansion playbook | 5.0K install, 595★, lolos Gen Agent Trust Hub + Socket + Snyk | [skills.sh](https://www.skills.sh/claude-office-skills/skills/customer-success) |
| Churn/Retention | `churn-prevention` (borghei/business-growth) — playbook retensi terukur | Publisher library 397-skill; value beda dari CS-manager (preventif per-account vs lifecycle program) | [borghei/Claude-Skills](https://github.com/borghei/Claude-Skills/blob/main/business-growth/churn-prevention/SKILL.md) |
| Service Recovery | `service-failure-recovery` (Dadmin88/hermes-profile-packs) — detection, ownership, komunikasi customer, kompensasi/remediation, escalation, closure evidence | **Grade A security 100/100** (Skills Directory); skill service recovery paling terstruktur; implementasi SRP ([R](https://link.springer.com/article/10.1057/s41262-025-00380-5)) | [Skills Directory](https://www.skillsdirectory.com/skills/dadmin88-service-failure-recovery) |
| Complaint Resolution (ops) | `handle-customer-complaints` (mcpmarket) — pull Gmail + HubSpot + PayPal, resolusi end-to-end | Value beda: eksekusi lintas-tool vs protokol desain recovery | [mcpmarket](https://mcpmarket.com/tools/skills/handle-customer-complaints) |
| CS Ops berjalan | customerscore.io — 6 skill terjadwal (QBR builder, churn early warning, expansion plays, retention report, ticket themes) | Full prompt dipublish tanpa gate; sisi "queue-level" yang jadi beda nyata benchmark CX | [customerscore.io](https://www.customerscore.io/claude-skills-for-customer-success) |

## A6. Growth, Creative & Media

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Video Producer | `hyperframes` (HeyGen) · `replicate` (model video via API) | hyperframes: HTML→MP4, open-source, jalur paling agent-native; replicate: gateway multi-model | [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) · [Replicate via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Motion Video (motion-graphics pipeline) | `motion-video-skill` (Clad012) — satu `story.json` → kinetic type, media cards, ElevenLabs voice word-by-word sync, musik + SFX tersintesis | Pipeline motion-video end-to-end; motion + sound jadi satu value chain | [Clad012/motion-video-skill](https://github.com/Clad012/motion-video-skill) |
| Motion Graphics by code | `claude-remotion-skill` (haidrrrry) — Remotion: B-roll, captions, sound design, editable | Value beda: video sebagai kode React yang bisa di-edit ulang, bukan sekali render; versi official publisher: [Remotion via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) | [haidrrrry/claude-remotion-skill](https://github.com/haidrrrry/claude-remotion-skill) |
| Talking-head → Reel | `video-edit-skill` (tenfoldmarc) — raw clips → Instagram reel: best take per line, dead-air cut, background keying | Value beda: edit footage nyata, bukan generate | [tenfoldmarc/video-edit-skill](https://github.com/tenfoldmarc/video-edit-skill) · gratis alternatif multi-OS: [social-media-skills/video-editing-skill](https://github.com/social-media-skills/video-editing-skill) |
| Product Demo Scenes | `stick-scene` (nilbuild) — /stick-scene + prompt: agent pitch 2-3 ide, tulis scene stick-figure (satu `<canvas>` tanpa dependencies), **render frame-by-frame buat QA overlap/cut-off**, langsung embed ke page | Value beda dari video: demo produk hidup di landing page, bukan MP4; aktif Nov 2026 | [nilbuild/stick-scene](https://github.com/nilbuild/stick-scene) |
| Video Discovery | awesome-claude-video-skills (zhuyansen) — **180 repo video terkurasi, each security-graded** | Index discovery buat semua slot video di luar essential | [zhuyansen/awesome-claude-video-skills](https://github.com/zhuyansen/awesome-claude-video-skills) |
| Image Producer | `imagegen` (OpenAI official) · `canvas-design` (Anthropic, PNG/PDF) | Official publisher; venice-image/replicate satu value dgn imagegen, dicut | [openai/skills](https://www.skills.sh/openai/skills) · [anthropics](https://github.com/anthropics/skills/tree/main/skills) |
| Image Gen — private/uncensored (restore ronde-20) | `venice-image` (Venice.ai official, 18 skill) | Value beda dari imagegen OpenAI: gen privat/tanpa filter kreatif; hilang pas rebuild ronde-11 | [Venice.ai via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Marketer | `marketing-skills` (Haines) · `seo-audit` + `ai-seo` (answer engines) | Paket marketing paling lengkap + dua value beda: search klasik vs AI-search | [Corey Haines](https://agenticskills.io/skills) · [skills.sh/topic/marketing](https://www.skills.sh/topic/marketing) |
| Paid Media Ops | `claude-ads` (AgriciDaniel) — **12 platform ads** (Google, Meta, YouTube, LinkedIn, TikTok, dll.): source-grounded audits, deterministic findings, versioned JSON reports, capability-gated account changes | Coverage platform terluas + disiplin audit grounding; alternatif agency-grade: [gomarble](https://github.com/gomarble-ai/gomarble-ai-paid-media-claude-skills) | [AgriciDaniel/claude-ads](https://github.com/AgriciDaniel/claude-ads) |
| Podcast/Audio Ops | `podcast-transcripts` (nish-sco) — episode links → Markdown, free publisher transcripts first, Deepgram fallback; + `claude-transcribe-youtube` (kezsmeister, speaker diarization) | Value beda: ingest podcaster → teks terstruktur | [nish-sco](https://github.com/nish-sco/podcast-transcripts) · [kezsmeister](https://github.com/kezsmeister/claude-transcribe-youtube) |
| Social | `typefully` (official) · `social-media-skills` (Hills) | Publish 5 platform + produksi konten 17 sub-skill | [Typefully via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) · [Hills](https://agenticskills.io/skills) |
| Community Ops | `discord-bot` (claude-office-skills: build bot buat community management) + community-management (absolutelyskilled: strategy end-to-end, platform selection, moderation policy templates) | Value beda: build tooling vs strategy & policy operasional | [claude-office-skills](https://github.com/claude-office-skills/skills/blob/HEAD/discord-bot/SKILL.md) · [absolutelyskilled](https://crossaitools.com/skills/absolutelyskilled/absolutelyskilled/community-management) |
| Messaging Infra | `resend` (email transaksional) · `courier-skills` (multi-channel) | Dua value beda: single-channel vs orchestrasi email+SMS+push+chat | [Resend via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) · [Courier via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Anti-Slop Audit | `avoid-ai-writing` (conorbronsdon) — audit + rewrite pattern AI; catalog `references/patterns.md` di-enforce di CI; mode detect terpisah dari rewrite | Paling sistematis: pattern catalog auditable + CI gate | [conorbronsdon/avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing) |
| Anti-Slop Constraint | `anti-ai-slop-writing` (jalaalrd) — banned vocabulary, structural variety, punctuation discipline, accuracy rules, voice calibration | Value beda: system-level constraint aktif otomatis tiap menulis, bukan audit pasca; alt khusus marketing-copy: `humanizer` (blader) | [jalaalrd/anti-ai-slop-writing](https://github.com/jalaalrd/anti-ai-slop-writing) |
| Persona/Voice Anchor (anti-drift) | `tone-of-voice` (entpnomad) — belajar voice lewat 9 pertanyaan, persisten di memori, enforce di semua output | Slot "soul drift" yang dari ronde-1 dicap gap; cara kerja sama aplikasi ke email: [analystacademy](https://github.com/analystacademy/claude-skills) (voice profile dari 3–5 email asli) — di-audit ronde-19: value identik, jadi alternatif channel-specific | [entpnomad/tone-of-voice](https://github.com/entpnomad/tone-of-voice) |
| Drift Audit | `brand-voice` (stefanoskarakasis/Product-Marketing-Skills) — `/audit` scoring copy lintas channel deteksi drift pattern + voice test | Grade A; satu-satunya skill yang dirancang khusus deteksi drift | [Skills Directory](https://www.skillsdirectory.com/skills/stefanoskarakasis-brand-voice) |
| Personal Style Rewrite | `writing-style-skill` (lout33) — rewrite output AI ke gaya personal otomatis | Value beda dari enforcement (top-down): ini transform bottom-up | [lout33/writing-style-skill](https://github.com/lout33/writing-style-skill) |

## A7. People & HR — REAL (koreksi ronde-10: ada)

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Talent Acquisition | `talent-acquisition` (borghei/hr-operations) — interview scorecards, hiring funnels, JD design | Satu-satunya skill TA dengan metrik funnel; research dasar structured-interview validity (Schmidt & Hunter 1998) | [borghei/Claude-Skills](https://github.com/borghei/Claude-Skills/blob/main/hr-operations/talent-acquisition/SKILL.md) |
| HR Generalist | `hr-talent` (travisjneuman/.claude) | Paket People-ops berbasis benchmark | [agent-skills.md](https://agent-skills.md/skills/travisjneuman/.claude/hr-talent) |
| Recruiting Ops | Pairwise-Technologies/recruiting-skills | Operator-vetted: tiap skill lolos review operator nyata | [GitHub](https://github.com/Pairwise-Technologies/recruiting-skills) |
| Cross-library | borghei/Claude-Skills: **397 skill, 76 expert agents** lintas tim (engineering, PM, marketing, C-level, compliance, business ops, research) | Library lintas departemen terbesar yang terverifikasi | [borghei/Claude-Skills](https://github.com/borghei/Claude-Skills) |

**Catatan:** performance goal-setting & psychological safety masih riset (Locke & Latham [R](https://med.stanford.edu/content/dam/s-sm/s-spire/documents/PD.locke-and-latham-retrospective_Paper.pdf) · Edmondson [R](https://web.mit.edu/curhan/www/docs/Articles/15341_Readings/Group_Performance/Edmondson%20Psychological%20safety.pdf)) — belum ada skill marketplace yang bagus untuk itu.

## A8. Finance, Payments & Accounting

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Payments | `stripe` (official) | Standar industri pembayaran | [Stripe via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Crypto/Fintech | `binance` + `coinbase` (official) | Dua publisher exchange terbesar; value beda (market data vs custody/interchange) | [VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Accounting/Books (suite) | **openaccountant/skills — 44 skill open-source** (P&L, budgeting, tax prep, debt payoff; business/personal/shared) | Suite accounting terlengkap yang free & multi-agent; aktif Apr 2026 | [openaccountant/skills](https://github.com/openaccountant/skills) |
| Cash Ops & Reporting | `accounting-skills` (ReInvestWealth) — weekly cash brief, cash-flow forecast, year-end financials, client migration | Reporting periodik nyata per bisnis, bukan template kosong | [ReInvestWealth/accounting-skills](https://github.com/ReInvestWealth/accounting-skills) |
| Startup Books | `startup-bookkeeper` (vpodugu) — natural language: expenses, invoices, subscriptions, budgets; dashboard + P&L, no QuickBooks needed | Value beda: buat founder tanpa software accounting; SKILL.md 439 baris | [vpodugu/startup-bookkeeper](https://github.com/vpodugu/startup-bookkeeper) |
| Invoice Lifecycle & Reconciliation | `invoice-automation` + `quickbooks-automation` (claude-office-skills) — generate, send, reminder, reconcile payment lintas QuickBooks/Xero/Stripe/FreshBooks + bank rules | Otomasi full-cycle dengan script executable; publisher sama dgn customer-success (5K install, 3 audit lolos); alt API-nyata: [QBO invoice-reconciliation agent](https://skills.lc/agentskillexchange/skills/agentskillexchange-skills-skills-quickbooks-invoice-reconciliation-skill-md) | [invoice-automation](https://atskills.one/claude-office-skills/invoice-automation) · [quickbooks](https://github.com/claude-office-skills/skills/blob/main/quickbooks-automation/SKILL.md) |

## A9. Legal, GRC & Compliance — REAL (koreksi ronde-10, terverifikasi benchmark)

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Contract Analysis | `claude-legal-skill` (evolsb) — grounded dataset **CUAD: 41 kategori risiko, 510 kontrak nyata** | Satu-satunya contract-review skill yang di-ground ke benchmark riset hukum | [evolsb/claude-legal-skill](https://github.com/evolsb/claude-legal-skill) |
| Legal Ops | `claude-for-legal` (Anthropic official) + ai-legal-claude (zubair-trabzada, 14 skill/5 agent) | Publisher resmi + suite multi-agent | [anthropics/claude-for-legal](https://github.com/anthropics/claude-for-legal) · [zubair-trabzada](https://github.com/zubair-trabzada/ai-legal-claude) |
| GRC | Sushegaad/Claude-Skills-Governance-Risk-and-Compliance — iso27001, soc2, gdpr-compliance, hipaa-compliance, dll. | **Benchmark 92% dengan skill vs 53% tanpa skill** — bukti efek paling terukur di registry ini | [Sushegaad/GRC](https://github.com/Sushegaad/Claude-Skills-Governance-Risk-and-Compliance) |

## A10. Security

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| AppSec Audit | `owasp-top-ten` (Trail of Bits official quality) | Publisher security audit paling kredibel di registry publik | [Trail of Bits via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Secure Sandboxing | Cloudflare `sandbox` (containers-isolated code execution) | Isolasi eksekusi=blast-radius control | [Cloudflare via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Security Audit (multi-phase) | `security-audit-skill` (cloudflare OFFICIAL, 25.6K★, MIT) — meng-orkestrasi isolated agents: recon → coverage-led hunting → candidate validation → structured output → **independent re-verification, machine-readable findings** | Publisher resmi; cikal-bakal sistem bug-hunting internal Cloudflare sendiri | [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) |
| Bug Bounty/Red Team Ops | `bug-bounty-agent-skills` (murrtada) — **93 skill** authorized bug bounty + external red-team + offensive research, one SKILL.md per-skill; aktif Sep 2026 (YesWeHack report workflow, writeup ingestion) | Library offensive terbesar yang terverifikasi; alternatif tradecraft: [Claude-BugHunter](https://github.com/elementalsouls/Claude-BugHunter) (82 skill, **681 disclosed-report pattern**, 24 kelas vuln) | [murrtada/bug-bounty-agent-skills](https://github.com/murrtada/bug-bounty-agent-skills) |

Dasar riset: DBIR 2024 — 68% breach ada human element ([Verizon DBIR](https://www.verizon.com/business/resources/reports/dbir/)) → skill security harus meng-cover sisi human, bukan cuma tooling.

## A11. Infrastructure & Data

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| IaC | `terraform` (HashiCorp official, 11 skill) + Cloudflare suite (7 skill) | Publisher resmi; de-facto standar IaC | [HashiCorp via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) · [Cloudflare via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Data/BaaS | `supabase` + `neon` + `clickhouse` (official) | Tiga publisher data infra beda slot (BaaS, serverless PG, OLAP) | [VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| DevOps Workflows | `devops-skills` (anmolnagpal) — Terraform, Kubernetes, Docker, GitHub Actions, GitLab CI, AWS FinOps, OWASP; satu SKILL.md → generator emit rules per tool (Cursor mdc, Codex AGENTS.md) sinkron | Value beda: sinkron lintas-tool via generator, bukan copy manual | [anmolnagpal/devops-skills](https://github.com/anmolnagpal/devops-skills) |
| Frontend Deploy | `vercel` (official, 12 skill: deploy, preview, edge config) | Publisher resmi; hilang pas rebuild ronde-11 | [Vercel via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| CMS | `sanity` (official: content schema, GROQ query, sync) | Publisher CMS resmi; slot content infra yang hilang pas rebuild | [Sanity via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Ops Monitoring | `sentry` + `netlify` (official) | Error tracking + deploy infra | [VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |

## A12. Knowledge & Documents

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Docs | Anthropic document suite: `docx` · `pdf` · `pptx` · `xlsx` · `doc-coauthoring` | Standar de-facto dokumen office; tiap format value beda | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills) |
| Workspace | `notion` skills (search + structured research docs) | Workspace terluas dipakai | [Notion via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Research | `last-30-days` (73K) · `serpapi-web-search` (130+ mesin) | Sintesis grounded + data structured; dua value beda (ringkasan vs API) | [mvanhorn](https://agenticskills.io/skills) · [SerpApi via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Memory | `memory-engineering` | Satu-satunya skill arsitektur memori agent | [alirezarezvani](https://github.com/alirezarezvani/claude-skills) |
| Skill Factory | `skill-creator` (Anthropic) · `writing-skills` (245K) + `find-skills` (Vercel) | Bikin skill + distribusi + discovery — tiga value beda | [anthropics](https://github.com/anthropics/skills/tree/main/skills) · [obra](https://www.skills.sh/obra/superpowers) · [Vercel Labs](https://agenticskills.io/skills) |
| Meeting Notes | `meeting-notes` (claude-office-skills) + `summarize-meeting` (borghei: transcript → decision + action owner) | Ringkasan meeting konsisten strukturnya; publisher yg udah lolos 3 audit | [claude-office-skills](https://github.com/claude-office-skills/skills/blob/main/meeting-notes/SKILL.md) · [borghei](https://github.com/borghei/Claude-Skills/blob/main/project-management/execution/summarize-meeting/SKILL.md) |
| Internal Comms | `internal-comms` (Anthropic official) — update 3P (Progress/Plans/Problems), newsletter, FAQ, incident report | Publisher resmi; slot komunikasi internal perusahaan | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills) |
| Theming/Brand System | `theme-factory` (Anthropic official) — konsistensi tema visual lintas output | Satu-satunya skill theming terstandar | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills) |
| MCP Builder | `mcp-builder` (Anthropic official) — generate MCP server dari skill/tools | Slot infra agent-tooling; hilang pas rebuild ronde-11 | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills) |
| Diagram Design | `diagram-design` (cathrynlavery) — **52 tipe diagram editorial** (architecture, flowchart, sequence, state machine, ER, swimlane, timeline, git graph), self-contained HTML + SVG, "No Mermaid slop" | Diagram terkurasi paling berkualitas: 70.6K★; value beda dari doc suite (visual editorial vs dokumen) | [cathrynlavery/diagram-design](https://github.com/cathrynlavery/diagram-design) |
| Second Brain/PKM | `claude-obsidian` (AgriciDaniel) — **16.7K★**, self-organizing AI second brain Obsidian + Claude Code; pola Karpathy LLM-wiki; skill di dalamnya: wiki-ingest (provenance per klaim), autoresearch (research-first merge) | PKM paling mateng: plain Markdown yang lu own, bukan vendor lock | [AgriciDaniel/claude-obsidian](https://github.com/AgriciDaniel/claude-obsidian) |

## A13. Cross-cutting — PM/Agile & BI

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Delivery/Scrum | `project-management-skills` suite (16 skill: sprint planning, backlog, retro, scrum, risk) | Suite PM paling lengkap di registry publik | [SkillDB](https://skilldb.dev/skills/project-management-skills) |
| Task Planning | `todo-task-planning` + `project-manager` (gendosu/agent-skills) | Breakdown eksekusi harian; value beda dari suite scrum | [gendosu/agent-skills](https://github.com/gendosu/agent-skills) |
| BI | `business-intelligence` + `customer-success-manager` + `churn-analysis` (alirezarezvani: library 380+ skill, 30+ agents) | Analitik + scorer terprogram; library terlengkap sisi bisnis | [alirezarezvani](https://github.com/alirezarezvani/claude-skills/blob/main/business-growth/skills/customer-success-manager/SKILL.md) |
| Experimentation | `data-scientist` (borghei) — ML selection, feature engineering, **A/B test design & statistical hypothesis testing**, experiment tracking | Slot eksperimen ilmiah terukur; paling dekat ke CRO/quant method | [borghei data-scientist](https://github.com/borghei/Claude-Skills/blob/main/data-analytics/data-scientist/SKILL.md) |
| SQL Correctness | `sql-queries` (Anthropic official, 5 dialek + optimization hints) + `dbt` (dbt Labs official: semantic layer, ref/source) | Dua publisher resmi; value beda (dialect mastery vs modeling layer) | [Anthropic](https://github.com/anthropics/skills/tree/main/skills) · [dbt Labs via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Market & Competitive Research | `market-research` + `competitive-intel` (alirezarezvani: research-ops + C-level advisor, 410-skill library) + `competitor-analysis-claude` (0-shiv: 9 dimensi — teardown, positioning map, pricing intel, battlecards) | Value beda: intel C-level vs teardown multi-dimensi produk | [alirezarezvani](https://github.com/alirezarezvani/claude-skills/blob/main/research-ops/skills/market-research/SKILL.md) · [0-shiv](https://github.com/0-shiv/secondstep-claude-skills/blob/main/skills/competitor-analysis-claude/SKILL.md) |
| End-to-end Analysis | `data-analysis-skill` (dongzhang84) — multi-expert workflow, HTML report, chart style design system | Value beda: analisis → report jadi satu deliverable, bukan cuma query | [dongzhang84/data-analysis-skill](https://github.com/dongzhang84/data-analysis-skill) |

---

## A14. Trading, Markets & On-chain — REAL (koreksi ronde-14: domain core Galyarder Labs gak boleh cuma binance/coinbase official)

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Quant/DeFi Analyst | **agiprolabs/claude-trading-skills — 68 skill**: market data, on-chain research, backtesting, risk management, tax compliance, token-economics (supply dynamics, vesting) | Suite trading/quant terlengkap; crypto/DeFi-first, extensible ke equities | [agiprolabs/claude-trading-skills](https://github.com/agiprolabs/claude-trading-skills) |
| Execution Discipline Gate | `risk-based position sizing` + manual-execution checklist gate (tradermonty) — **nge-block entry planless, oversized, revenge-risk, regime-blocked**, dan journal hasilnya | Value unik: gate disiplin psikologi trading, bukan sinyal — protokol anti-revenge & anti-overleverage | [tradermonty/claude-trading-skills](https://github.com/tradermonty/claude-trading-skills) |
| DeFi Protocol Risk | `crypto-project-security-skill` (truenorth-lj): smart contracts, governance/admin keys, **oracle design**, operations, incident history | Satu-satunya skill audit risiko protocol DeFi per dimensi insiden nyata | [truenorth-lj](https://github.com/truenorth-lj/crypto-project-security-skill) |
| Token Research | `ai-crypto-claude` (zubair-trabzada) — token symbol → analisis multi-dimensi non-trading-bot (tapi ketulis jelas: bukan execution) | Analisis riset top-down dengan guardrail honest; value beda dari suite quant | [zubair-trabzada/ai-crypto-claude](https://github.com/zubair-trabzada/ai-crypto-claude) |
| TA dengan safeguards | `cryptocurrency-trader-skill` (redlabs-sc) — TA lengkap dengan **hallucination prevention** + explicit risk management | Value: TA yang nge-klaim batas pengetahuannya sendiri | [redlabs-sc](https://github.com/redlabs-sc/ai-trading-claude-skills/tree/main/cryptocurrency-trader-skill) |
| Day-Trading Ops | `day-trader-skill` (Jakeschincariol) — 11 skill, Alpaca paper default, **no order tanpa "yes" manusia** (allow-once gate) | Value beda: loop eksekusi broker riil dengan human-in-the-loop wajib | [Jakeschincariol/day-trader-skill](https://github.com/Jakeschincariol/day-trader-skill) |
| Smart Contract Auditing | `smart-contract-auditor-skill` (farrellh1): checklist-driven Solidity/EVM audit, checklist sourced from **Cyfrin/audit-checklist** | Metodologi audit paling auditable: sumber checklist profesional nyata | [farrellh1](https://github.com/farrellh1/smart-contract-auditor-skill) |
| Solidity Vulnerability DB | `Smart-Contract-AI-Audit-Skill` (giladHaimov) — DB 293 entri dari 4 sumber; audit existing code + check saat nulis | Value beda: knowledge base kerapatan bug, bukan workflow | | [Smart-Contract-AI-Audit-Skill](https://github.com/giladHaimov/Smart-Contract-AI-Audit-Skill) · alt multi-chain (EVM/Solana/Cosmos, OWASP SC Top 10): [Shahnilsharma](https://github.com/Shahnilsharma/smart-contracts-auditor-skill) |

---

## A15. External Relations & Fundraising — REAL (koreksi ronde-15: kategori APQC yang sejak ronde-1 ditandain tapi gak pernah diisi)

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| PR/Press Office | `pr-skills` (Insightful-Pipe) — press releases, press kits, media pitches, **coverage reports, crisis communications**, events, awards | Paket PR terlengkap; crisis comms = value yang jarang ada | [Insightful-Pipe/pr-skills](https://github.com/Insightful-Pipe/pr-skills) |
| Media Production (PR/Journalism) | `autopunk-media-skills` (ur-grue) — **394 skill quality-tested** untuk producer/jurnalis/podcaster/YouTuber, termasuk press-release-writer | Suite media terbesar dengan quality gate per skill | [ur-grue/autopunk-media-skills](https://github.com/ur-grue/autopunk-media-skills) |
| Fundraising/Investor Relations | `cc-skills-vc-fundraising` (tjboudreaux) — pitch analysis, fundraising strategy, IR; grounded first-principles **Sequoia/a16z/Benchmark/YC** | Satu-satunya yang nge-klaim metodologi dari playbook VC nyata; reviewer skill media juga fleksibel | [tjboudreaux/cc-skills-vc-fundraising](https://github.com/tjboudreaux/cc-skills-vc-fundraising) |
| Pitch Deck | `pitch-deck-mastery-skill` (Stevekaplanai) — 12-slide framework, 10 curated resources, deck review checklist; alternatif: pitch-deck-writer (xcrrr, story-first) | Framework deck investor terstruktur; value beda dari fundraising strategy | [Stevekaplanai](https://github.com/Stevekaplanai/pitch-deck-mastery-skill) · [xcrrr](https://github.com/xcrrr/claude-skills/blob/main/skills/business/pitch-deck-writer/SKILL.md) |

---

## A16. Agent Ops Layer, Gamedev & Scientific (ronde-18)

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Browser Automation | `agent-browser` (vercel-labs) — CLI: open pages, baca sebagai accessibility tree, act on element dari shell; skill packs: core, electron (VS Code, Slack, Discord, Figma), slack, dogfood | Jalan web atas nama agent; verifiable (tree ≠ screenshot halusinasi) | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |
| Computer Use | `agent-desktop` (vercel-labs) — CLI computer-use lintas macOS/Windows/Linux, baca app via accessibility, loop + verification + retry rules, skill per-OS | Value beda dari browser: kontrol desktop app nyata | [vercel-labs/agent-desktop](https://github.com/vercel-labs/agent-desktop) |
| Game Dev | `awesome-gamedev-agent-skills` (gamedev-skills) — **79 skill + router**: Godot, Unity, Unreal, Roblox, three.js, Phaser + 6 engine lain; dicek di engine nyata | Suite gamedev pertama yang diuji per toolchain asli | [gamedev-skills/awesome-gamedev-agent-skills](https://github.com/gamedev-skills/awesome-gamedev-agent-skills) |
| Scientific Research | **k-dense-ai/scientific-agent-skills — 177 skill tervalidasi + 100+ database ilmiah** (literature-review, study design, statistics, peer review); dipakai 250K+ ilmuwan | Slot riset ilmiah penuh; value beda dari research general (domain databases nyata) | [K-Dense-AI/scientific-agent-skills](https://github.com/k-dense-ai/scientific-agent-skills) · alternatif publisher resmi: [google-deepmind/science-skills](https://github.com/google-deepmind/science-skills) (AlphaGenome, AFDB, UniProt, 30+ DB) |

---

# B. KEHIDUPAN (WHOQOL 6 domain + PERMA)

| Domain | Skill essential | Value inti | URL |
|---|---|---|---|
| **Health — fitness & nutrisi** | `fitness-nutrition` (nousresearch / hermes-agent) | Satu skill lengkap: workout + nutrisi + tracking progres | [getclaudeskills](https://www.getclaudeskills.com/skills/fitness-nutrition-nousresearch) |
| **Biohacking Protocol** | `biohacking-advisor` (milosriki/client-vital-suite) — sleep, focus, longevity protocols (gaya Huberman/Attia) | Protocol biohacking terstruktur (domain core Galih); dedicated-depth alt tidur: [sleep-optimizer](https://www.skillsdirectory.com/skills/skillmedev-sleep-optimizer) (Grade A, fixed wake time ±30 menit, chronotype window) | [skills.lc](https://skills.lc/milosriki/client-vital-suite/milosriki-client-vital-suite-agent-skills-backup-20260131-biohacking-advisor-skill-md) |
| **Longevity Workspace** | `health-skill` (googlarz) — labs, meds, training, sleep, family history dalam satu workspace longitudinal | Value beda: memory kesehatan jangka panjang, bukan protocol per-sehari | [googlarz/health-skill](https://github.com/googlarz/health-skill) |
| **Health — medis/profesional** | **AWS HCLS suite — 43 skill resmi, 13 domain** (medical coding, risk adjustment, claims analytics, quality measures, genomics, imaging, drug discovery) | Standar industri kesehatan; publisher resmi AWS Labs | [awslabs/hcls-agent-skills](https://github.com/awslabs/hcls-agent-skills) · kurasi: [JuneYaooo](https://github.com/JuneYaooo/awesome-medical-ai-skills) |
| **Habit** | `habit-tracker` (khalilbenaz / NeverSight) | Habit building pakai behavioral science + streak tracking | [skills.lc](https://skills.lc/khalilbenaz/claude-skills-collection/khalilbenaz-claude-skills-collection-productivity-skills-habit-tracker-skill-md) |
| **Recovery/Rest** | `recovery-day-planner` (mohitagw15856/pm-claude-skills, library 1166 skill) | Perencanaan rest yang sadar fisik-vs-mental, anti guilt-trip | [GitHub](https://github.com/mohitagw15856/pm-claude-skills/blob/main/skills/recovery-day-planner/SKILL.md) |
| **Wellness/Meditasi** | `meditation-wellness-skills` (suite 11 skill: mindfulness, movement) | Suite wellbeing satu paket | [SkillDB](https://skilldb.dev/skills/meditation-wellness-skills) |
| **Mental/journaling** | `journal-framework` (aouellets / personal-operating-system) | Morning pages, gratitude, intention, evening reflection, weekly review | [skills.lc](https://skills.lc/aouellets/personal-operating-system/aouellets-personal-operating-system-skills-journal-framework-skill-md) |
| **Mental — listening/therapist mode** | `claude-therapist` (carrie-lypp) — dengar dulu, tanpa advice-cepat, tanpa "think positive" | Value beda dari journaling: partner refleksi, bukan template | [carrie-lypp/claude-therapist](https://github.com/carrie-lypp/claude-therapist) |
| **Personal Finance** | `personal-finance` (afrexai) — pohon budget: income → fixed (≤50%) → dst. | Budget framework terstruktur + expense tracking | [agent-skills.md](https://agent-skills.md/skills/aAAaqwq/claude-code-skills/afrexai-personal-finance) |
| **Cooking** | `cooking` (stephendolan) · `meal-plan` (caseyWebb groceries) | Advisor kuliner + perencanaan belanja/makan mingguan | [skills.lc](https://skills.lc/stephendolan/dotfiles/stephendolan-dotfiles-ai-skills-cooking-skill-md) · [skills.lc](https://skills.lc/caseyWebb/groceries-agent-data/caseywebb-groceries-agent-data-plugin-grocery-agent-skills-meal-plan-skill-md) |
| **Travel** | `travel-planner` (TravelSkills — routing linear/loop/hub-spoke/figure-8) | Perencanaan trip berbasis cara kerja travel pro nyata | [travelskills.io](https://travelskills.io/) |
| **Relationships/Couples (Gottman)** | **LoveLab** (thc1006/lovelab-skills) — analisis dialog pasangan: Gottman four horsemen + attachment theory + NVC + CBT, sitasi J Marriage & Family, jalan lokal, no telemetry | Skill Gottman pertama yang real & evidence-cited; gap dari ronde-1 s/d ronde-10, ketutup ronde-11 | [thc1006/lovelab-skills](https://github.com/thc1006/lovelab-skills) |
| **Relationship Maintenance** | `partner-skill` (NatalieCao323) — 5-layer persona builder, relationship-health RQ checklist, attachment + social exchange theory | Value beda: bukan analisis konflik tapi engine pemeliharaan hubungan jangka panjang | [NatalieCao323/partner-skill](https://github.com/NatalieCao323/partner-skill) |
| **Dating** | `dating-coach-skill` (nelonmelons) — evidence-graded, tiap saran diberi tingkat kepercayaan riset | Disiplin metodologis langka di skill life: membawa bias sampel riset Western ke permukaan | [nelonmelons/dating-coach-skill](https://github.com/nelonmelons/dating-coach-skill) |
| **Education/Learning** | **GarethManning/education-agent-skills — 165 skill, evidence-grounded** (pedagogy, learning science, curriculum design, assessment, classroom ops) · `socratic-tutor` (Jane Street, 2.1K★) | Suite pendidikan terbesar; tutor Socratic = value beda (bukan jawaban-jawaban) | [GitHub](https://github.com/GarethManning/education-agent-skills) · [janestreet/agent_skills](https://github.com/janestreet/agent_skills) |
| **Career** | `ResumeSkills` (Paramchoudhary — ATS optimization, resume builder, interview prep) | Paket karier dengan ROI terukur (ATS pass-rate, interview loop) | [GitHub](https://github.com/Paramchoudhary/ResumeSkills) |
| **Language Learning** | `language-learning-skills` (liknenS) — vocabulary spaced repetition, pronunciation, role-play speaking, study plans, exam prep; + `fluent` (m98, SM-2 worked examples) | Bahasa asing jadi system: review terjadwal + tutor role-play; value beda dari education (subject-specific vs metode belajar bahasa) | [liknenS](https://github.com/liknenS/language-learning-skills) · [m98/fluent](https://github.com/m98/fluent) |
| **Faith/Iman (Islam)** | `skill-islamic-salafi` (rhapsodixx) — evidence-first: Quran + Sunnah authentik → scholar bernama; fiqh Shafi'i default, reply EN/Bahasa Indonesia; + `ansari-skill` (ansari-project: Quran, Hadith, classical scholars) | Skill agama pertama yang evidence-first + dukung Bahasa Indonesia; answer dari sumber kanonik, bukan halusinasi | [rhapsodixx](https://github.com/rhapsodixx/skill-islamic-salafi) · [ansari-project](https://github.com/ansari-project/ansari-skill) |
| **Parenting/Family** | `parenting-family-skills` (10) · `parenting-child-development-skills` (10) | Sekuel perkembangan anak usia-specific + strategi komunikasi keluarga | [SkillDB](https://skilldb.dev/skills/parenting-family-skills) · [SkillDB](https://skilldb.dev/skills/parenting-child-development-skills) |

**Catatan B:** skill life mayoritas dari repo personal/komunitas — harus di-curate satu per satu pas dibawa ke produksi. Yang publisher-grade: AWS HCLS (medis resmi), education-agent-skills (165, evidence-grounded), customer-success (3 audit lolos). Research dasar: WHOQOL 6 domain + PERMA sebagai taksonomi; Gottman method = intervensi couples paling teruji ([meta-analysis PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC6037577/)).

**Status (ronde-19, post-audit): NOL GAP + NOL REDUNDANSI.** Slot yang pernah dicap kosong (CS, People, Legal/GRC, Relationships, soul-drift) udah ketutup. Audit ronde-19 memangkas 9 redundansi/salah-tempat: Osmani dipindah ke A3, obra di-merge jadi 1 baris, jakubkrehel/delphi/adam-paterson/humanizer/analystacademy-email/sleep-optimizer di-demotion jadi alternatif di baris value-nya masing-masing, QBO-reconciliation di-merge. Registry sekarang lean: tiap baris = 1 slot value unik.

---

## Rekap kurasi (post-audit ronde-19)

| Departemen | Baris value | Alasan utama pemilihan |
|---|---|---|
| A1 Executive & Strategy | 4 | deanpeters evidence-first + mattpocock grilling + agency-agents + public-speaking |
| A2 Product | 3 | deanpeters PM lifecycle + Figma/Mobbin + emilkowalski/skills (jakubkrehel & delphi jadi alt) |
| A3 Engineering | 9 | (+ TestMu 40+ QA, hasil research ronde awal yang hilang pas rebuild) obra suite + Osmani + Karpathy + Orchestra AI-research + wshobson + teaming + bug-hunter + prompt/RAG |
| A4 Operations & Delivery | 4 | Crawlbase + Sales MBA (adam-paterson & OneWave jadi alt) + negotiation + n8n/zapier |
| A5 Customer Success | 5 | customer-success (3 audit) + churn-prevention + service-failure-recovery Grade A + complaints + customerscore |
| A6 Growth, Creative & Media | 19 | (+ Venice.ai private gen, restore) hyperframes + motion-video/remotion/reel/podcast + paid ads 12-platform + drift (tone-of-voice, meliput email-voice) + anti-slop duo + community + messaging |
| A7 People & HR | 4 | borghei talent-acquisition + hr-talent + Pairwise + cross-library |
| A8 Finance, Payments & Accounting | 6 | Stripe/Binance/Coinbase official + openaccountant 44-suite + ReInvestWealth + startup-bookkeeper + invoice/quickbooks |
| A9 Legal & GRC | 3 | CUAD-grounded + Anthropic official + GRC 92% benchmark |
| A10 Security | 4 | OWASP/Trail of Bits + Cloudflare sandbox + cloudflare/security-audit-skill official + murrtada 93-skill bounty |
| A11 Infrastructure & Data | 6 | (+ Vercel official & Sanity CMS, restore) HashiCorp/Cloudflare/Supabase/Neon/ClickHouse/Sentry + devops-skills generator-sync |
| A12 Knowledge & Documents | 11 | (+ internal-comms, theme-factory, mcp-builder — semua Anthropic official, restore) Anthropic doc suite + research + memory + skill factory + meeting-notes + diagram-design 70.6K★ + claude-obsidian 16.7K★ |
| A13 Cross-cutting PM/BI | 7 | PM 16-suite + gendosu + alirezarezvani BI/CSM + borghei A/B + Anthropic sql + dbt + dongzhang84 + market/competitive research |
| A14 Trading & On-chain | 8 | agiprolabs 68-skill + tradermonty gate + truenorth + ai-crypto-claude + redlabs TA + day-trader + Cyfrin audit + vuln DB 293 |
| A15 External Relations & Fundraising | 4 | Insightful-Pipe PR + autopunk 394 + tjboudreaux VC + pitch-deck mastery |
| A16 Agent Ops, Gamedev & Scientific | 4 | vercel agent-browser + agent-desktop + gamedev 79-skill + K-Dense scientific 177-skill |
| B Kehidupan (21 domain) | 20 | fitness/biohacking(+sleep alt)/HCLS 43/habit/recovery/meditation/journal/therapist/personal-finance/cooking/travel/LoveLab/partner/dating/education/socratic/career/language/faith/parenting |
| **Total** | **118 baris value / 700+ skill** | 114 post-audit + 4 restore ronde-20 (slot research awal yang hilang pas file rebuild ronde-11) | Best-in-class per slot value, redundansi & salah-tempat sudah dipangkas ronde-19 |

*Legend: suite dihitung satu baris kalau fungsi intinya satu value chain. Angka install punya umur — cek ulang pas mau pakai. Versi: v20 (24 Nov 2026), 20 ronde: 18 riset + 1 audit redundansi + 1 restore (slot dari research awal yang hilang pas rebuild file ronde-11). v1-v19 documented in Forge knowledge.*