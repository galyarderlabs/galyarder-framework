# Galyarder Framework - Organization Chart

## Executive Layer

### Founder (Human)
- **Role:** Owner, Principal, Final Decision Maker
- **Reports to:** None
- **Direct Reports:** galyarder-specialist

### galyarder-specialist (Digital CEO)
- **Role:** Chief Orchestrator, Workflow Manager
- **Reports to:** Founder
- **Responsibilities:**
  - Route work to departments
  - Enforce operating model
  - Synthesize progress reports
  - Quality control across company
- **Direct Reports:** All department heads

---

## Department Structure

### 1. Founder Office / Capital
**Department Head:** `fundraising-operator`

**Purpose:** Fundraising, investor relations, board reporting, accelerator strategy

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

---

### 2. Product
**Department Heads:** `product-manager`, `planner`

**Purpose:** Product direction, prioritization, roadmap, scope discipline

**Team Members (Skills):**
- `write-a-prd` - PRD creation
- `prd-to-plan` - PRD to implementation plan
- `prd-to-issues` - PRD to Linear tickets
- `brainstorming` - Socratic design refinement
- `writing-plans` - Implementation planning
- `ubiquitous-language` - Domain language definition

**Reports to Founder:**
- What is being built
- Why it matters
- Tradeoffs and scope risk
- Priority decisions

---

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

**Reports to Founder:**
- Delivery status
- Technical risk
- Quality metrics
- Blockers

---

### 4. Security
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

**Reports to Founder:**
- Security posture
- Urgent risks
- Remediation priorities

---

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
- `copywriting` - High-signal copy
- `onboarding-cro` - Onboarding optimization
- `paywall-upgrade-cro` - Paywall optimization
- `page-cro` - Landing page CRO
- `signup-flow-cro` - Signup optimization
- `social-content` - Social media content
- `referral-program` - Viral loops
- `marketing-psychology` - Behavioral psychology
- `analytics-tracking` - Event tracking
- `ab-test-setup` - A/B testing

**Reports to Founder:**
- Demand quality
- Funnel performance
- Market response
- Leverage opportunities

---

### 6. Infrastructure / Operations
**Department Heads:** `devops-engineer`, `release-manager`

**Purpose:** Deployment, release management, runtime operations, experimentation

**Senior Ops:**
- `devops-engineer` - CI/CD, Docker, infrastructure
- `release-manager` - Versioning, changelogs, launches
- `experimentation-engineer` - A/B test infrastructure

**Reports to Founder:**
- Release readiness
- Infrastructure risk
- Operational reliability

---

### 7. Legal / Finance
**Department Heads:** `legal-counsel`, `finops-manager`

**Purpose:** Legal protection, compliance, pricing economics, cost optimization

**Senior Advisors:**
- `legal-counsel` - TOS/Privacy, compliance
- `finops-manager` - Cloud cost, pricing strategy

**Team Members (Skills):**
- `legal-tos-privacy` - Terms and privacy policies
- `gdpr-compliance` - GDPR audit
- `iso-42001-ai-governance` - AI governance
- `open-source-license` - License review
- `contract-review` - Contract analysis
- `saas-finops-optimization` - Cloud cost optimization
- `finance-based-pricing-advisor` - Pricing strategy

**Reports to Founder:**
- Legal risk
- Financial risk
- Compliance gaps

---

### 8. Knowledge / Documentation
**Department Head:** `obsidian-architect`

**Purpose:** Memory preservation, decision history, visual maps, founder reports

**Team Members (Skills):**
- `obsidian-cli` - Obsidian automation
- `obsidian-bases` - Base template system
- `obsidian-markdown` - Markdown conventions
- `json-canvas` - Visual mapping
- `defuddle` - Content extraction

**Reports to Founder:**
- Current state snapshot
- What changed
- Decisions made
- What must be remembered

---

## Reporting Hierarchy

### Downward Flow
```
Founder
  ↓
galyarder-specialist (CEO)
  ↓
Department Heads (Agents)
  ↓
Skill Workers (Execution)
```

### Upward Flow
```
Skill Execution Results
  ↓
Department Agent Synthesis
  ↓
galyarder-specialist Summary
  ↓
Founder Report
```

---

## Integration Points

### Linear (Task System)
- All work tracked as issues
- Agent assignments
- Status transitions
- Next actions

### Obsidian (Strategic Memory)
- Architecture decisions
- Progress summaries
- Founder reports
- Knowledge base
- Visual maps

### AI Assistants (Execution Runtime)
- Claude Code
- Cursor
- Gemini
- Codex
- Any MCP-compatible assistant

---

## Operating Principles

1. **Clear Ownership:** Every task has one agent owner
2. **Department Accountability:** Each department produces founder-readable reports
3. **Upward Synthesis:** Information flows up through hierarchy
4. **Downward Delegation:** Work flows down through departments
5. **Memory Preservation:** All decisions captured in Obsidian
6. **Task Tracking:** All work visible in Linear
