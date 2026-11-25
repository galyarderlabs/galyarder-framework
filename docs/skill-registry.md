> **Maintainer note (this block is not part of Galih's registry text).** This is Galih's research registry, Essential Skill Registry v15, dated 24 Nov 2026. It is the auditable source for skill curation in this repo: every skill row names a real skill, a source URL, and a value reason, derived from APQC PCF v7.4 for the company side and WHOQOL 6 domains + PERMA for the life side. The v13 text below is copied verbatim from Galih's research file; do not edit it in place. The ronde-14 and ronde-15 additions live in the addenda at the end of this file, summarized by the maintainer from the research agent's messages Galih sent on 24 Nov 2026; the addenda are maintainer text, not his verbatim file. To iterate on it, propose a change as a row: real skill name + source URL + value reason, per the curation rules in the file. The review of this registry against the repo's current skills lives in [skill-registry-review.md](skill-registry-review.md).

# Forge Foundation: Essential Skill Registry v13 — NOL GAP

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
| Adversarial Review | addyosmani/agent-skills (25 skill) — code review, debugging, security audit, performance adversarial | Lawan optimal buat klaim strategi; champion ter-install | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) |

## A2. Product

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| PM Lifecycle | product-manager-skills (deanpeters) — discovery → spec → launch | Satu siklus PM penuh, satu sumber | [deanpeters/product-manager-skills](https://github.com/deanpeters/product-manager-skills) |
| Design | `figma` (official) + Mobbin reference | Akses desain nyata + pattern library industri | [Figma via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Design Engineering & Motion | **emilkowalski/skills (official Emil Kowalski)** — `animate`, `review-animations`, `learn-taste`, `ask-emil`, `emil-design-eng`, `remove-animations`, `mobile-native` + ui-cheatsheet & performance-cheatsheet | Repo resmi; "based on years at Vercel & Linear"; aktif Nov 2026; `learn-taste` = fitur unik: koreksi desain tiap session jadi rules di DESIGN.md | [emilkowalski/skills](https://github.com/emilkowalski/skills) |
| Animation Course Ref | `animate-skill` (delphi-ai) — based on Emil Kowalski "Animations on the Web" course, 8 working examples (hover, toasts, modals) | Value beda: quick-reference implementasi dari kursusnya, bukan philosophy layer | [delphi-ai/animate-skill](https://github.com/delphi-ai/animate-skill) |

## A3. Engineering

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Brainstorm/Design | `brainstorming` (obra, 441K install) | Skill design-phase ter-install sedunia | [obra/superpowers](https://www.skills.sh/obra/superpowers) |
| Debugging | `systematic-debugging` (obra, 346K) | Reproducible root-cause, bukan tebak-tebakan | [obra/superpowers](https://www.skills.sh/obra/superpowers) |
| Verification | `verification-before-completion` (obra, 289K) | Nge-stop klaim "selesai" tanpa bukti | [obra/superpowers](https://www.skills.sh/obra/superpowers) |
| Full Suite | obra/superpowers 15 skill + addyosmani 25 skill | Dua library champion; fungsi lain (TDD, refactoring, review) di-cover oleh suite masing-masing | [obra/superpowers](https://www.skills.sh/obra/superpowers) · [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) |
| Coding Discipline (Karpathy) | `andrej-karpathy-skills` (multica-ai) — 4 prinsip: no overcomplication, surgical changes, surface assumptions, verifiable success criteria; SKILL.md + plugin | Derivatif langsung dari observasi Karpathy soal kegagalan LLM coding; viral 226K+★ | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) · [SKILL.md](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md) |

## A4. Operations & Delivery

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Web Data Ops | Crawlbase skill | Scraping/ops data web, publisher resmi | [Crawlbase via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Sales Ops | adam-paterson/skills (sales) | Suite sales terverifikasi | [adam-paterson/skills](https://github.com/adam-paterson/skills) |

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
| Motion Graphics by code | `claude-remotion-skill` (haidrrrry) — Remotion: B-roll, captions, sound design, editable | Value beda: video sebagai kode React yang bisa di-edit ulang, bukan sekali render | [haidrrrry/claude-remotion-skill](https://github.com/haidrrrry/claude-remotion-skill) |
| Talking-head → Reel | `video-edit-skill` (tenfoldmarc) — raw clips → Instagram reel: best take per line, dead-air cut, background keying | Value beda: edit footage nyata, bukan generate | [tenfoldmarc/video-edit-skill](https://github.com/tenfoldmarc/video-edit-skill) · gratis alternatif multi-OS: [social-media-skills/video-editing-skill](https://github.com/social-media-skills/video-editing-skill) |
| Video Discovery | awesome-claude-video-skills (zhuyansen) — **180 repo video terkurasi, each security-graded** | Index discovery buat semua slot video di luar essential | [zhuyansen/awesome-claude-video-skills](https://github.com/zhuyansen/awesome-claude-video-skills) |
| Image Producer | `imagegen` (OpenAI official) · `canvas-design` (Anthropic, PNG/PDF) | Official publisher; venice-image/replicate satu value dgn imagegen, dicut | [openai/skills](https://www.skills.sh/openai/skills) · [anthropics](https://github.com/anthropics/skills/tree/main/skills) |
| Marketer | `marketing-skills` (Haines) · `seo-audit` + `ai-seo` (answer engines) | Paket marketing paling lengkap + dua value beda: search klasik vs AI-search | [Corey Haines](https://agenticskills.io/skills) · [skills.sh/topic/marketing](https://www.skills.sh/topic/marketing) |
| Social | `typefully` (official) · `social-media-skills` (Hills) | Publish 5 platform + produksi konten 17 sub-skill | [Typefully via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) · [Hills](https://agenticskills.io/skills) |
| Messaging Infra | `resend` (email transaksional) · `courier-skills` (multi-channel) | Dua value beda: single-channel vs orchestrasi email+SMS+push+chat | [Resend via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) · [Courier via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Copy Quality (marketing) | `humanizer` | Anti-slop khusus marketing copy | [blader](https://agenticskills.io/skills) |
| Anti-Slop Audit | `avoid-ai-writing` (conorbronsdon) — audit + rewrite pattern AI; catalog `references/patterns.md` di-enforce di CI; mode detect terpisah dari rewrite | Paling sistematis: pattern catalog auditable + CI gate | [conorbronsdon/avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing) |
| Anti-Slop Constraint | `anti-ai-slop-writing` (jalaalrd) — banned vocabulary, structural variety, punctuation discipline, accuracy rules, voice calibration | Value beda: system-level constraint aktif otomatis tiap menulis, bukan audit pasca | [jalaalrd/anti-ai-slop-writing](https://github.com/jalaalrd/anti-ai-slop-writing) |
| Persona/Voice Anchor (anti-drift) | `tone-of-voice` (entpnomad) — belajar voice lewat 9 pertanyaan, persisten di memori, enforce di semua output | Ini slot "soul drift" yang dari ronde-1 dicap gap; sekarang ada | [entpnomad/tone-of-voice](https://github.com/entpnomad/tone-of-voice) |
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
| Invoice Lifecycle & Reconciliation | `invoice-automation` + `quickbooks-automation` (claude-office-skills) — generate, send, reminder, reconcile payment lintas QuickBooks/Xero/Stripe/FreshBooks + bank rules | Otomasi full-cycle dengan script executable; publisher sama dgn customer-success (5K install, 3 audit lolos) | [invoice-automation](https://atskills.one/claude-office-skills/invoice-automation) · [quickbooks](https://github.com/claude-office-skills/skills/blob/main/quickbooks-automation/SKILL.md) |
| API Reconciliation | `quickbooks-online-invoice-reconciliation-agent` — OAuth2 QBO API, match unpaid invoices vs bank, PDF report | Value beda: koneksi API nyata vs rules-based | [skills.lc](https://skills.lc/agentskillexchange/skills/agentskillexchange-skills-skills-quickbooks-invoice-reconciliation-skill-md) |

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

Dasar riset: DBIR 2024 — 68% breach ada human element ([Verizon DBIR](https://www.verizon.com/business/resources/reports/dbir/)) → skill security harus meng-cover sisi human, bukan cuma tooling.

## A11. Infrastructure & Data

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| IaC | `terraform` (HashiCorp official, 11 skill) + Cloudflare suite (7 skill) | Publisher resmi; de-facto standar IaC | [HashiCorp via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) · [Cloudflare via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Data/BaaS | `supabase` + `neon` + `clickhouse` (official) | Tiga publisher data infra beda slot (BaaS, serverless PG, OLAP) | [VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Ops Monitoring | `sentry` + `netlify` (official) | Error tracking + deploy infra | [VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |

## A12. Knowledge & Documents

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Docs | Anthropic document suite: `docx` · `pdf` · `pptx` · `xlsx` · `doc-coauthoring` | Standar de-facto dokumen office; tiap format value beda | [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills) |
| Workspace | `notion` skills (search + structured research docs) | Workspace terluas dipakai | [Notion via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Research | `last-30-days` (73K) · `serpapi-web-search` (130+ mesin) | Sintesis grounded + data structured; dua value beda (ringkasan vs API) | [mvanhorn](https://agenticskills.io/skills) · [SerpApi via VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) |
| Memory | `memory-engineering` | Satu-satunya skill arsitektur memori agent | [alirezarezvani](https://github.com/alirezarezvani/claude-skills) |
| Skill Factory | `skill-creator` (Anthropic) · `writing-skills` (245K) + `find-skills` (Vercel) | Bikin skill + distribusi + discovery — tiga value beda | [anthropics](https://github.com/anthropics/skills/tree/main/skills) · [obra](https://www.skills.sh/obra/superpowers) · [Vercel Labs](https://agenticskills.io/skills) |

## A13. Cross-cutting — PM/Agile & BI

| Agent | Skill essential | Kenapa | URL |
|---|---|---|---|
| Delivery/Scrum | `project-management-skills` suite (16 skill: sprint planning, backlog, retro, scrum, risk) | Suite PM paling lengkap di registry publik | [SkillDB](https://skilldb.dev/skills/project-management-skills) |
| Task Planning | `todo-task-planning` + `project-manager` (gendosu/agent-skills) | Breakdown eksekusi harian; value beda dari suite scrum | [gendosu/agent-skills](https://github.com/gendosu/agent-skills) |
| BI | `business-intelligence` + `customer-success-manager` + `churn-analysis` (alirezarezvani: library 380+ skill, 30+ agents) | Analitik + scorer terprogram; library terlengkap sisi bisnis | [alirezarezvani](https://github.com/alirezarezvani/claude-skills/blob/main/business-growth/skills/customer-success-manager/SKILL.md) |

---

# B. KEHIDUPAN (WHOQOL 6 domain + PERMA)

| Domain | Skill essential | Value inti | URL |
|---|---|---|---|
| **Health — fitness & nutrisi** | `fitness-nutrition` (nousresearch / hermes-agent) | Satu skill lengkap: workout + nutrisi + tracking progres | [getclaudeskills](https://www.getclaudeskills.com/skills/fitness-nutrition-nousresearch) |
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
| **Parenting/Family** | `parenting-family-skills` (10) · `parenting-child-development-skills` (10) | Sekuel perkembangan anak usia-specific + strategi komunikasi keluarga | [SkillDB](https://skilldb.dev/skills/parenting-family-skills) · [SkillDB](https://skilldb.dev/skills/parenting-child-development-skills) |

**Catatan B:** skill life mayoritas dari repo personal/komunitas — harus di-curate satu per satu pas dibawa ke produksi. Yang publisher-grade: AWS HCLS (medis resmi), education-agent-skills (165, evidence-grounded), customer-success (3 audit lolos). Research dasar: WHOQOL 6 domain + PERMA sebagai taksonomi; Gottman method = intervensi couples paling teruji ([meta-analysis PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC6037577/)).

**Status akhir (ronde-11): NOL GAP.** Semua slot yang sempat dicap "kosong" dari ronde-1 s/d ronde-10 udah ketutup dengan skill real + URL: Customer Success/churn/service recovery (A5), People/HR (A7), Legal/GRC (A9), Relationships/Gottman (B), persona anchor/soul drift (A6). Regen Forge sekarang full-supply dari taksonomi APQC + WHOQOL/PERMA sampai skill level, tanpa satu slot pun kosong.

---

## Rekap kurasi

| Departemen | Skill essential | Alasan utama pemilihan |
|---|---|---|
| Executive & Strategy | 2 suite (27 skill) | deanpeters evidence-first + Osmani adversarial |
| Product | 5 | deanpeters PM lifecycle + Figma/Mobbin official + **emilkowalski/skills (motion & design engineering)** |
| Engineering | 2 suite (40 skill) + karpathy-guidelines | obra 15 + Osmani 25 + Karpathy 4-prinsip discipline |
| Operations | 2 | Crawlbase + adam-paterson sales |
| Customer Success (RONDE-11) | 5 | customer-success 5K install + churn-prevention + service-failure-recovery Grade A |
| Growth, Creative & Media (ronde-13) | 15 | hyperframes + motion-video/remotion/reel pipeline + tone-of-voice & brand-voice (drift) + anti-slop trio |
| People | 4 | borghei talent-acquisition + hr-talent + Pairwise |
| Finance, Payments & Accounting (ronde-12) | 7 | Publisher resmi (Stripe, Coinbase, Binance) + openaccountant 44-suite + ReInvestWealth + startup-bookkeeper + invoice/quickbooks automation |
| Legal & GRC (RONDE-10) | 4 | CUAD-grounded + Anthropic official + GRC 92% benchmark |
| Security | 2 suite | OWASP + Trail of Bits + Cloudflare sandbox |
| Infrastructure & Data | 2 suite | HashiCorp/Cloudflare/Supabase/Neon/ClickHouse/Sentry official |
| Knowledge & Docs | 5 | Anthropic suite + research + memory-engineering + skill factory |
| Cross-cutting (PM/BI) (RONDE-10) | 3 | PM 16-suite + gendosu + alirezarezvani BI/CSM |
| Life (15 domain) | 16 | hermes fitness, AWS HCLS 43, LoveLab Gottman, education 165, dll. |
| **Total essential terkurasi** | **±75 baris value / 190+ skill best-in-class** | Best-in-class per slot value, nol redundansi fungsi |

*Legend: suite dihitung satu baris kalau fungsi intinya satu value chain. Angka install punya umur — cek ulang pas mau pakai. Versi: v13 (24 Nov 2026), setelah 13 ronde riset. v1-v12 documented in Forge knowledge.*
---

## Ronde-14 (v14) - addendum

Catatan maintainer: bagian ini BUKAN teks verbatim Galih. Ini rangkuman dari pesan riset ronde-14 yang Galih kirim 24 Nov 2026 (teks agent research-nya), ditambahkan sebagai addendum supaya teks v13 di atas tetap utuh byte-identical. Isi tiap baris (nama skill, URL, alasan value) diambil dari pesan itu. Penempatan baris Sales/Negotiation, Experimentation/BI, dan Office ke seksi A4/A13/A12 adalah pilihan maintainer berdasarkan struktur registry yang ada; pesan ronde-14 tidak menamai seksi untuk ketiganya.

**Yang berubah di v14:** kritiknya valid, trading/on-chain (domain inti Galyarder Labs) tidak pernah jadi departemen sendiri di v13. Ronde-14 membetulkan itu: **A14. Trading, Markets & On-chain** jadi departemen baru. Registry sekarang **v14: ±85 baris value / 260+ skill**, 14 departemen perusahaan + 16 domain life.

### A14. Trading, Markets & On-chain (departemen baru)

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Quant/DeFi suite | agiprolabs/claude-trading-skills, 68 skill | Market data, on-chain, backtesting, risk, tax, token-economics (vesting/supply) | [agiprolabs/claude-trading-skills](https://github.com/agiprolabs/claude-trading-skills) |
| Discipline gate | tradermonty/claude-trading-skills | Checklist gate yang nge-block entry planless/oversized/revenge-risk, journal hasil | [tradermonty/claude-trading-skills](https://github.com/tradermonty/claude-trading-skills) |
| DeFi risk audit | truenorth-lj/crypto-project-security-skill | Smart contract, governance keys, oracle design, incident history | [truenorth-lj/crypto-project-security-skill](https://github.com/truenorth-lj/crypto-project-security-skill) |
| Token research | ai-crypto-claude (zubair-trabzada) | Multi-dimensi, jujur soal batasnya, bukan trading bot | [zubair-trabzada/ai-crypto-claude](https://github.com/zubair-trabzada/ai-crypto-claude) |
| TA anti-halusinasi | redlabs-sc/ai-trading-claude-skills (cryptocurrency-trader-skill) | TA dengan hallucination prevention eksplisit | [redlabs-sc/ai-trading-claude-skills](https://github.com/redlabs-sc/ai-trading-claude-skills/tree/main/cryptocurrency-trader-skill) |
| Eksekusi human-gate | day-trader-skill (Jakeschincariol) | Broker loop Alpaca, gak ada order tanpa "yes" lu | [Jakeschincariol/day-trader-skill](https://github.com/Jakeschincariol/day-trader-skill) |

### Ronde-14: tambahan ke seksi yang sudah ada

**A4. Operations & Delivery, Sales/Negotiation:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Sales | Sales MBA (lancewc/sales-claude-skills) | Production-grade B2B AE | [lancewc/sales-claude-skills](https://github.com/lancewc/sales-claude-skills) |
| Negotiation | negotiation (mikesmayer/claude-business-skills) | High-stakes/vendor pricing | [mikesmayer/claude-business-skills](https://github.com/mikesmayer/claude-business-skills/blob/main/negotiation/SKILL.md) |

**A13. Cross-cutting, Experimentation/BI:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Experimentation | data-scientist (borghei) | A/B test design + hypothesis testing | Tidak ada URL di pesan ronde-14 |
| Data queries | sql-queries (Anthropic resmi) | 5 dialek | Tidak ada URL di pesan ronde-14 |
| Data transform | dbt (dbt Labs resmi) | Tidak ada deskripsi value di pesan ronde-14 | Tidak ada URL di pesan ronde-14 |
| Data analysis | data-analysis-skill (dongzhang84) | Multi-expert, output HTML report | [dongzhang84/data-analysis-skill](https://github.com/dongzhang84/data-analysis-skill) |

**A12. Knowledge & Documents, Office:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Meeting notes | meeting-notes (claude-office-skills) | Publisher yang sudah lolos 3 audit | Tidak ada URL di pesan ronde-14 |
| Email | email (analystacademy/claude-skills) | Voice profile dari 3-5 email asli lu, bukan template generik | [analystacademy/claude-skills](https://github.com/analystacademy/claude-skills) |

**Catatan hitungan:** pesan ronde-14 menyebut "13 slot value baru", tapi pesan itu sendiri memuat 14 baris skill yang berbeda (6 A14 + 2 Sales/Negotiation + 4 Experimentation/BI + 2 Office). Addendum ini mencatat 14 baris apa adanya. Selisih 1 itu soal cara menghitung, bukan soal isi.

**URL check, 24 Nov 2026:** 10 dari 10 URL yang tercantum di pesan ronde-14 mengembalikan HTTP 200. 4 item (borghei data-scientist, sql-queries, dbt, meeting-notes) tidak punya URL di pesan itu, jadi belum bisa dicek.

---

## Ronde-15 (v15) - addendum

Catatan maintainer: bagian ini BUKAN teks verbatim Galih. Ini rangkuman dari pesan riset ronde-15 yang Galih kirim 24 Nov 2026 (teks agent research-nya), ditambahkan sebagai addendum supaya teks v13 di atas dan addendum v14 tetap utuh. Isi tiap baris (nama skill, URL, alasan value) diambil dari pesan itu.

**Yang berubah di v15:** klaim "nol gap" di v13/v14 ternyata terlalu cepat. Ronde-15 nemuin 8 sektor yang bagus dan tidak pernah masuk, termasuk satu yang paling memalukan: **External Relations**, kategori APQC yang sudah ditandai sejak ronde-1 tapi tidak pernah diisi. Pesan ronde-15 juga mengamankan satu rule permanen: tidak pernah klaim "complete" lagi tanpa closure sweep; tiap kali ditanya "beneran ga ada lagi?", jawabannya harus dari riset, bukan dari kepercayaan diri. Registry sekarang **v15: ±99 baris value / 300+ skill, 15 departemen + 19 domain life**, semua dengan URL.

### A15. External Relations (departemen baru)

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| PR & crisis comms | pr-skills (Insightful-Pipe) + autopunk-media-skills (ur-grue, 394 skill quality-tested untuk media pros) | PR lengkap: releases, kits, coverage reports, crisis communications | [Insightful-Pipe/pr-skills](https://github.com/Insightful-Pipe/pr-skills) · [ur-grue/autopunk-media-skills](https://github.com/ur-grue/autopunk-media-skills) |

### Ronde-15: tambahan ke seksi yang sudah ada

Penempatan di bawah ini adalah pilihan maintainer. Pesan ronde-15 hanya menamai 8 sektornya dan total akhirnya (15 departemen + 19 domain life); dari total itu, 3 sektor dibaca sebagai domain life baru (biohacking/sleep/longevity, podcast/audio ops, public speaking), dan 5 sisanya sebagai baris perusahaan.

**A1. Executive & Strategy, Fundraising & investor relations:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Fundraising | cc-skills-vc-fundraising (tjboudreaux) + pitch-deck-mastery (Stevekaplanai) | Grounded dari first-principles Sequoia/a16z/Benchmark/YC; 12-slide framework | [tjboudreaux/cc-skills-vc-fundraising](https://github.com/tjboudreaux/cc-skills-vc-fundraising) · [Stevekaplanai/pitch-deck-mastery-skill](https://github.com/Stevekaplanai/pitch-deck-mastery-skill) |

**A10. Security, Smart contract audit:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Smart contract audit | smart-contract-auditor-skill (farrellh1, checklist Cyfrin) + Smart-Contract-AI-Audit-Skill (giladHaimov, DB 293 vulnerability, 4 sumber) | Domain core blockchain yang di v14 cuma kena "binance/coinbase official" | [farrellh1/smart-contract-auditor-skill](https://github.com/farrellh1/smart-contract-auditor-skill) · [giladHaimov/Smart-Contract-AI-Audit-Skill](https://github.com/giladHaimov/Smart-Contract-AI-Audit-Skill) |

**A6. Growth, Creative & Media, Paid media:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Paid media | claude-ads (AgriciDaniel) | 12 platform (Google/Meta/TikTok/LinkedIn/dll), source-grounded audit, capability-gated changes | [AgriciDaniel/claude-ads](https://github.com/AgriciDaniel/claude-ads) |

**A4. Operations & Delivery, Automation:**

| Slot | Skill essential | Value | URL |
|---|---|---|---|
| Automation | n8n-skills (czlonkowski) + zapier-workflows (davila7) | Skema skill resmi n8n juga ada di repo n8n-io | [czlonkowski/n8n-skills](https://github.com/czlonkowski/n8n-skills) · zapier-workflows: tidak ada URL di pesan ronde-15 |

**B. Kehidupan, domain baru:**

| Domain | Skill essential | Value inti | URL |
|---|---|---|---|
| **Public speaking & presentasi** | public-speaking-skill (guycoful) + presentation-writing-claude-skill (marcusnelson) | Coaching panggung (persuasion theory) vs penulisan narasi slide, dua value beda | [guycoful/public-speaking-skill](https://github.com/guycoful/public-speaking-skill) · [marcusnelson/presentation-writing-claude-skill](https://github.com/marcusnelson/presentation-writing-claude-skill) |
| **Podcast/audio ops** | podcast-transcripts (nish-sco) + claude-transcribe-youtube (kezsmeister) | Episode ke transcript terstruktur, speaker diarization | [nish-sco/podcast-transcripts](https://github.com/nish-sco/podcast-transcripts) · [kezsmeister/claude-transcribe-youtube](https://github.com/kezsmeister/claude-transcribe-youtube) |
| **Biohacking/sleep/longevity** | biohacking-advisor (protocols Huberman/Attia) + sleep-optimizer (skillmedev, Grade A) + health-skill (googlarz, workspace labs longitudinal) | Domain biohacking yang di v14 cuma kena "fitness-nutrition" doang | biohacking-advisor: tidak ada URL di pesan ronde-15 · [skillmedev-sleep-optimizer](https://www.skillsdirectory.com/skills/skillmedev-sleep-optimizer) · [googlarz/health-skill](https://github.com/googlarz/health-skill) |

**Catatan hitungan:** pesan ronde-15 menyebut "±99 baris value". Addendum ini mencatat 8 baris baru (1 A15 + 5 baris perusahaan + 3 domain life), jadi totalnya 98 baris (90 dari v14 + 8). Selisih 1 dari ±99 itu soal cara menghitung dan toleransi ±, bukan soal isi.

**URL check, 24 Nov 2026:** 14 dari 14 URL yang tercantum di pesan ronde-15 mengembalikan HTTP 200. 2 item (zapier-workflows davila7, biohacking-advisor) tidak punya URL di pesan itu, jadi belum bisa dicek.
