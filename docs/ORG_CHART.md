# Forge Anything - Organization Chart

## Executive Layer

### Founder (Human)
- **Role:** Owner, Principal, Final Decision Maker
- **Direct Reports:** forge-ceo

### forge-ceo (Chief Executive Officer)
- **Persona:** `forge-ceo`
- **Lead Agent:** `forge-specialist`
- **Protocol:** Verified execution and executive coordination
- **Responsibilities:**
  - Receive founder intent
  - Delegate to Department Heads (CTO, CMO, CFO/COO)
  - Provide high-signal executive summaries
- **Direct Reports:** forge-cto, forge-cmo, forge-cfo-coo

### forge-cto (Chief Technology Officer)
- **Persona:** `forge-cto`
- **Protocol:** Technical architecture, implementation quality, and verification
- **Department:** Engineering, Product, Security.
- **Responsibilities:** Technical integrity, architecture oversight, security posture.

### forge-cmo (Chief Marketing Officer)
- **Persona:** `forge-cmo`
- **Protocol:** Growth strategy, positioning, analytics, and distribution
- **Department:** Growth.
- **Responsibilities:** Distribution, revenue (cuan), market visibility.

### forge-cfo-coo (Chief Financial & Operating Officer)
- **Persona:** `forge-cfo-coo`
- **Protocol:** Operations, finance, compliance, and reliability
- **Department:** Finance, Legal, Knowledge.
- **Responsibilities:** Compliance, budget efficiency, operational reliability.


## Department Structure

### 1. Executive
**Department Head:** `fundraising-operator`

**Purpose:** Founder context, investor relations, board updates, and diligence readiness

**Team Members (Skills):**
- `founder-context` - Founder narrative and positioning
- `pitch-deck` - Pitch deck creation
- `investor-research` - Investor targeting and research
- `fundraising-email` - Investor outreach emails
- `data-room` - Due diligence preparation
- `board-update` - Board reporting
- `accelerator-application` - Accelerator applications
- `market-research` - Market analysis
- `lead-scoring` - Investor lead qualification
- `founder-thought-leadership` - Founder content strategy

**Reports to Founder:**
- Raise readiness status
- Investor pipeline health
- Capital risks
- Narrative gaps


### 2. Product
**Department Heads:** `product-manager`, `planner`

**Purpose:** Product direction, prioritization, roadmap, scope discipline

**Team Members (Skills):**
- `write-a-prd` - PRD creation
- `prd-to-plan` - PRD to implementation plan
- `prd-to-issues` - PRD to issue breakdown
- `brainstorming` - Socratic design refinement
- `writing-plans` - Implementation planning
- `ubiquitous-language` - Domain language definition

**Reports to Founder:**
- What is being built
- Why it matters
- Tradeoffs and scope risk
- Priority decisions


### 3. Engineering
**Department Heads:** `super-architect`, `architect`, `elite-developer`

**Purpose:** Architecture, implementation, testing, code quality, delivery

**Senior Engineers:**
- `super-architect` - System design, ADRs, vertical slices
- `architect` - Technical architecture
- `elite-developer` - Implementation, TDD, debugging
- `vercel-react-expert` - React/Next.js optimization
- `build-error-resolver` - Build/type error resolution
- `code-reviewer` - Code review
- `refactor-cleaner` - Dead code cleanup
- `qa-automation-engineer` - E2E testing
- `e2e-runner` - Playwright test execution
- `doc-updater` - Documentation maintenance
- `tdd-guide` - TDD enforcement

**Team Members (Skills):**
- `test-driven-development` - TDD methodology
- `systematic-debugging` - Root cause analysis
- `verification-before-completion` - Quality gates
- `subagent-driven-development` - Parallel execution
- `executing-plans` - Plan execution
- `requesting-code-review` - Review workflow
- `receiving-code-review` - Review response
- `finishing-a-development-branch` - Branch completion


### 4. Creative
**Department Heads:** `ui-ux-designer`, `interface-designer`

**Purpose:** Design, video, writing, images, branding, and content creation

**Senior Creative:**
- `ui-ux-designer` - UI/UX design
- `interface-designer` - Interface design

**Team Members (Skills):**
- `content-creator` - Content creation
- `social-content` - Social media content
- `writing-skills` - Writing craft

### 5. Growth
**Department Heads:** `growth-strategist`, `growth-engineer`

**Purpose:** Acquisition, conversion, retention, distribution, analytics

**Senior Growth:**
- `growth-strategist` - SEO, copywriting, strategy
- `growth-engineer` - Engineering-as-marketing
- `conversion-engineer` - CRO, onboarding optimization
- `retention-specialist` - LTV, engagement
- `social-strategist` - Social distribution
- `analytics-architect` - Tracking, KPIs

**Team Members (Skills):**
- `seo-audit` - SEO analysis
- `schema-markup` - Schema.org implementation
- `copywriting` - Clear conversion and product copy
- `onboarding-cro` - Onboarding optimization
- `paywall-upgrade-cro` - Paywall optimization
- `page-cro` - Landing page CRO
- `social-content` - Social media content
- `referral-program` - Viral loops
- `marketing-psychology` - Behavioral psychology
- `analytics-tracking` - Event tracking
- `ab-test-setup` - A/B testing


### 6. Security
**Department Heads:** `security-guardian`, `perseus`

**Purpose:** Security review, threat analysis, offensive/defensive posture

**Senior Security:**
- `security-guardian` - Security audits, OWASP
- `security-reviewer` - Vulnerability detection
- `perseus` - Offensive security, pentesting
- `cyber-intel` - Threat intelligence

**Team Members (Skills):**
- `executing-red-team-exercise` - Red team operations
- `testing-for-xss-vulnerabilities-with-burpsuite` - XSS testing
- `monitoring-darkweb-sources` - Dark web monitoring
- `tracking-threat-actor-infrastructure` - Threat tracking
- `executing-active-directory-attack-simulation` - AD security
- `investigating-phishing-email-incident` - Phishing analysis


### 7. Infrastructure / Operations
**Department Heads:** `devops-engineer`, `release-manager`

**Purpose:** Deployment, release management, runtime operations, experimentation

**Senior Ops:**
- `devops-engineer` - CI/CD, Docker, infrastructure
- `release-manager` - Versioning, changelogs, launches
- `experimentation-engineer` - A/B test infrastructure


### 8. Finance
**Department Head:** `finops-manager`

**Purpose:** Cost optimization, pricing economics

**Senior Advisors:**
- `finops-manager` - Cloud cost, pricing strategy

**Team Members (Skills):**
- `saas-finops-optimization` - Cloud cost optimization
- `finance-based-pricing-advisor` - Pricing strategy
- `accounting` - Accounting and financial records

### 9. Legal
**Department Head:** `legal-counsel`

**Purpose:** Legal protection, compliance

**Senior Advisors:**
- `legal-counsel` - TOS/Privacy, compliance

**Team Members (Skills):**
- `legal-tos-privacy` - Terms and privacy policies
- `gdpr-compliance` - GDPR audit
- `iso-42001-ai-governance` - AI governance
- `open-source-license` - License review
- `contract-review` - Contract analysis

### 10. Knowledge / Documentation
**Department Head:** `obsidian-architect`

**Purpose:** Memory preservation, decision history, visual maps, founder reports

**Team Members (Skills):**
- `obsidian-cli` - Obsidian automation
- `obsidian-bases` - Base template system
- `obsidian-markdown` - Markdown conventions
- `json-canvas` - Visual mapping
- `defuddle` - Content extraction


## Operating Principles

1. **Clear Ownership:** Every task has one agent owner.
2. **Grounding before execution:** use source files, docs, current state, and relevant tool checks before action.
3. **Upward synthesis:** information flows from skills and agents into reports, decisions, and operator summaries.
4. **Technical Integrity:**
   - **Think Before Coding**: STOP & ASK if uncertain.
   - **Simplicity First**: Minimum code, no speculative abstractions.
   - **Surgical Changes**: Touch only what you must.
   - **Goal-Driven**: Loop until verified via tests-first.
5. **Task tracking:** important work should be visible in a scoped issue, plan, report, or decision record.

Copyright 2026 Galyarder Labs. Forge Anything. Executive Office.
