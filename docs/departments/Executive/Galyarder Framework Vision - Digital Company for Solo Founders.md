# Galyarder Framework Vision - Digital Enterprise for Solo Founders

## Vision
Galyarder Framework should behave like a digital enterprise that a solo founder can recruit, direct, and scale.

The founder is still the human owner and final decision-maker.
Galyarder Framework becomes the digital enterprise working underneath that founder.

In this model:
- agents are digital employees with clear roles and reporting lines
- skills are the operational workers, SOPs, playbooks, and specialist task units used by those employees
- `galyarder-specialist` acts as the CEO / chief orchestrator
- work is tracked in Linear
- strategic memory, decisions, and progress reports are written into Obsidian

The goal is not to look fancy.
The goal is to let one founder operate with the leverage of a real company structure.

## Deployment Options

### Option 1: Standalone (Conversational)
Framework runs through AI assistant (Claude Code, Cursor, Gemini).
- Founder chats with galyarder-specialist
- Agents execute through conversation
- Tasks optionally tracked in Linear
- Reports optionally written to Obsidian
- No database, pure conversational

### Option 2: With Dashboard (Platform)
Framework integrated with Dashboard web platform.
- Founder manages via web UI
- Agents execute via heartbeat loops
- Tasks tracked in Dashboard database
- Visual monitoring and cost tracking
- Multi-company support
- See `docs/INTEGRATION.md` for setup

Both options use the same agents and skills.
Dashboard adds visual management layer.

## Core Mental Model
### Founder
The founder is the owner, principal, and final approver.

### Galyarder Framework Specialist
`galyarder-specialist` is the digital CEO.
Responsibilities:
- understand the founder's top-level objective
- route work to the right departments
- enforce the operating model
- keep quality high across the digital enterprise
- synthesize progress back upward to the founder

### Specialist Agents
Specialist agents are department heads, managers, or senior individual contributors.
Examples:
- `product-manager` = Head of Product
- `super-architect` / `architect` = Architecture leadership
- `elite-developer` = senior engineering execution
- `growth-strategist` = Head of Growth
- `devops-engineer` = infrastructure / platform operations
- `legal-counsel` = legal and compliance lead
- `fundraising-operator` = founder office / capital operations
- `obsidian-architect` = chief of knowledge and documentation systems

### Skills
Skills are not the same thing as agents.

Skills are closer to:
- trained operators
- SOPs
- task-specific employees
- playbooks
- specialist execution modules

If agents are managers and functional leaders, skills are the workers and procedures they deploy to get work done.

Example:
- `fundraising-operator` is the department lead
- `pitch-deck`, `investor-research`, `fundraising-email`, `data-room`, `board-update` are the actual operational workers / playbooks under that lead

## Company Structure
### Executive Layer
Reports directly to the founder.

- `galyarder-specialist`
  - role: CEO / orchestration chief
  - owns task routing, quality control, and company-wide coordination

Potential future executive pattern:
- `product-manager` as CPO-style lead
- `super-architect` / `architect` as CTO-style leadership
- `growth-strategist` as CMO-style leadership
- `finops-manager` or future finance lead as CFO-style leadership
- `legal-counsel` as GC-style leadership
- `fundraising-operator` as founder office / capital markets operator

### Department Layer
The digital enterprise should be organized as departments.

#### 1. Founder Office / Capital
Purpose:
- fundraising
- investor communication
- board reporting
- startup narrative
- accelerator applications
- founder-led market positioning

Current leading agent:
- `fundraising-operator`

Current skill workers:
- `founder-context`
- `pitch-deck`
- `investor-research`
- `fundraising-email`
- `data-room`
- `board-update`
- `accelerator-application`
- `market-research`
- `lead-scoring`
- `founder-thought-leadership`

#### 2. Product
Purpose:
- shape what gets built
- decide what matters now
- translate ideas into scoped execution

Current leading agents:
- `product-manager`
- `planner`

Representative skills:
- `write-a-prd`
- `prd-to-plan`
- `prd-to-issues`
- `writing-plans`
- `brainstorming`

#### 3. Engineering
Purpose:
- system design
- implementation
- testing
- code review
- refactoring
- delivery quality

Current leading agents:
- `super-architect`
- `architect`
- `elite-developer`
- `qa-automation-engineer`
- `build-error-resolver`
- `code-reviewer`
- `refactor-cleaner`
- `vercel-react-expert`

Representative skills:
- `test-driven-development`
- `systematic-debugging`
- `verification-before-completion`
- `subagent-driven-development`
- `build-error-resolver`

#### 4. Security
Purpose:
- threat modeling
- appsec
- offensive and defensive review
- risk reduction

Current leading agents:
- `security-guardian`
- `security-reviewer`
- `cyber-intel`
- `perseus`

#### 5. Growth
Purpose:
- demand generation
- conversion
- retention
- SEO
- distribution
- analytics

Current leading agents:
- `growth-strategist`
- `growth-engineer`
- `conversion-engineer`
- `retention-specialist`
- `social-strategist`
- `analytics-architect`

Representative skills:
- `seo-audit`
- `schema-markup`
- `launch-strategy`
- `pricing-strategy`
- `onboarding-cro`
- `social-content`
- `analytics-tracking`

#### 6. Infrastructure / Operations
Purpose:
- CI/CD
- deployment
- cloud operations
- release management
- runtime reliability

Current leading agents:
- `devops-engineer`
- `release-manager`
- `experimentation-engineer`

#### 7. Legal / Finance
Purpose:
- compliance
- risk review
- pricing economics
- financial hygiene

Current leading agents:
- `legal-counsel`
- `finops-manager`

#### 8. Knowledge / Documentation
Purpose:
- preserve memory
- map architecture and decisions
- create durable project intelligence
- produce founder-readable progress artifacts

Current leading agent:
- `obsidian-architect`

Representative skills:
- `obsidian-cli`
- `obsidian-bases`
- `obsidian-markdown`
- `json-canvas`
- `defuddle`

## Reporting Structure
### Downward Flow
Founder -> `galyarder-specialist` -> department agent -> skill workers / task-specific execution

### Upward Flow
Skill execution -> department agent synthesis -> `galyarder-specialist` summary -> founder

This should be explicit and visible.

## Linear + Obsidian Operating Model
### Linear
Linear should function as the task system of record.

Everything operational should be traceable in Linear:
- objectives
- initiatives
- issues
- status transitions
- ownership
- next actions

In the digital enterprise metaphor, Linear is the work management system.

**Integration Options:**
1. **Standalone:** Manual Linear management
2. **With Dashboard:** Automatic sync between Dashboard tasks  Linear issues

### Obsidian
Obsidian should function as the strategic memory and reporting system.

Obsidian should capture:
- company context
- architecture decisions
- progress summaries
- investor / founder reporting
- knowledge base materials
- dashboards and visual maps

In the digital enterprise metaphor, Obsidian is the internal company memory plus founder reporting layer.

**Integration Options:**
1. **Standalone:** Manual report writing using templates
2. **With Dashboard:** Automatic report generation from Dashboard data

### Ideal Reporting Loop
1. Founder gives direction.
2. `galyarder-specialist` routes to the right department.
3. Department agent drives execution through its skill workers.
4. Tasks are tracked in Linear (or Dashboard).
5. Milestones, decisions, and summaries are written into Obsidian.
6. `galyarder-specialist` or the responsible manager writes a founder-readable report.

**With Dashboard Integration:**
- Tasks created in Dashboard automatically sync to Linear
- Execution progress tracked in Dashboard database
- Reports auto-generated to Obsidian from Dashboard data
- Founder monitors via web UI or Obsidian vault

## What Skills Really Are
Skills should be treated as:
- trainable labor units
- procedures
- specialists with narrow job descriptions
- execution modules that can be composed under an agent

This means a good digital employee structure looks like:
- agent = manager or functional owner
- skills = trained workers under that manager

This framing is important because it avoids turning the framework into a flat junk drawer of unrelated skills.

## Design Rule
Do not organize the framework as a random warehouse of skills.
Organize it as a company.

That means every major skill should eventually answer one of these:
- which department does it belong to?
- which agent manages it?
- what job does it perform?
- what output does it produce?
- what does it report upward?

## Current Situation
### What Already Exists
Galyarder Framework already has strong ingredients:
- a strict workflow constitution
- strong engineering identity
- orchestration via `galyarder-specialist`
- clear specialist agents across engineering, growth, security, legal, and product
- new founder / fundraising stack already added
- Obsidian direction already present as a knowledge workflow layer

### What Was Just Added
Founder-facing department support has already started.

New skills already added into the repo:
- `founder-context`
- `pitch-deck`
- `investor-research`
- `fundraising-email`
- `data-room`
- `board-update`
- `accelerator-application`
- `market-research`
- `lead-scoring`
- `founder-thought-leadership`

New agent already added:
- `fundraising-operator`

Routing updates already started:
- `galyarder-specialist` now references founder and capital work as an optional expansion path
- `using-galyarder-framework` now separates foundation from expansion
- Gemini routing now explicitly scopes founder workflows to founder-facing tasks only

### What Is Still Missing
The framework is still not fully operating like a company yet.

Gaps:
- many agents still do not have explicit skill-stack mapping
- departments are implied, not fully documented
- reporting loops to Obsidian are not yet formalized per department
- Linear structure for the digital enterprise is not yet standardized
- external best-in-class skills from large libraries have not yet been systematically imported or Standarded
- some docs still describe the framework like a skill library rather than a digital enterprise

## External Standard Insight
The cloned `Galyarder Framework` repository shows what a very broad skills marketplace looks like.

Observed strengths from current state:
- strong domain packaging
- many skills per domain
- broad tool support including Gemini, Codex, OpenClaw, Cursor, and others
- clear marketplace/domain install surfaces for Claude/Copilot
- strong depth in engineering, marketing, product, finance, C-level advisory, and operational tooling

What to learn from it:
- broad skill coverage matters
- domain packaging matters
- install surfaces matter where host marketplaces support them
- curated agents/personas plus domain packs are powerful

What not to copy blindly:
- raw breadth without stronger company structure
- giant flat accumulation without reporting lines
- packaging decisions that do not map to Galyarder Framework's internal logic

The right move is:
- copy what is strong
- adapt what fits the company model
- reject what adds volume without strengthening a digital employee

## Strategic Direction From Here
### Near-Term Objective
Turn Galyarder Framework from a framework with many specialists into a digital enterprise with:
- a clear org chart
- explicit department leads
- mapped skill employees beneath those leads
- founder-readable reporting into Obsidian
- task execution captured in Linear

### Immediate Next Steps
1. Document every major agent as a department head, manager, or specialist IC.
2. Create agent-to-skill maps for every key department.
3. Define how each department reports into Obsidian.
4. Define how each department tracks work in Linear.
5. Audit external repositories by department and import best-in-class skills selectively.
6. Rewrite top-level docs so the framework is described as a digital enterprise, not a random library.

## Department Audit Backlog
Priority audit order:
1. Engineering
2. Growth
3. Founder / Capital
4. Legal / Finance
5. Security
6. Product
7. Knowledge / Obsidian

For each department, ask:
- who is the department lead?
- what skills already exist?
- what skills are weak?
- what external skills are better?
- what should be imported, adapted, or replaced?
- what founder-facing reports should this department produce?

## Founder Report Principle
Every department should eventually be able to produce founder-readable reports.

These reports should be written into Obsidian and should answer:
- what changed?
- what was done?
- what matters now?
- what risks exist?
- what decisions are needed from the founder?

This is how a solo founder actually experiences leverage.
Not by staring at skill lists.
But by receiving coordinated output from a functioning digital enterprise.

## Final Principle
Galyarder Framework should feel like hiring a company, not installing a plugin.

That means:
- agents act like accountable digital employees
- skills act like trained workers and job-specific playbooks
- Linear tracks the work
- Obsidian preserves memory and reports upward
- `galyarder-specialist` operates as the CEO of the digital enterprise
- the founder remains the human principal over the whole system
