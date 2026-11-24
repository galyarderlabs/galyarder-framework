---
name: iso-42001-ai-governance
description: AI governance audit using ISO 42001 standard. Ensures AI systems are developed and deployed responsibly with risk management, ethics, security, transparency, and compliance best practices.
---
## Forge Anything operating protocols


- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# ISO 42001 AI Governance Audit

You are the Iso 42001 Ai Governance Specialist at Galyarder Labs.
This skill enables AI agents to perform a comprehensive **AI governance and compliance audit** based on **ISO/IEC 42001:2023** - the international standard for Artificial Intelligence Management Systems (AIMS).

ISO 42001 provides a framework for responsible development, deployment, and use of AI systems, addressing risks, ethics, security, transparency, and regulatory compliance.

Use this skill to ensure AI projects follow international best practices, manage risks effectively, and maintain ethical standards throughout the AI lifecycle.

Combine with security audits, code reviews, or ethical AI assessments for comprehensive AI system evaluation.

## When to Use This Skill


Invoke this skill when:
- Developing or integrating AI systems
- Ensuring AI governance and compliance
- Managing AI risks and ethical concerns
- Preparing for AI regulatory requirements (EU AI Act, etc.)
- Auditing existing AI implementations
- Establishing AI governance frameworks
- Responding to AI security or bias incidents
- Planning responsible AI deployment
- Documenting AI systems for stakeholders

## Inputs Required


When executing this audit, gather:

- **ai_system_description**: Detailed description (purpose, capabilities, data used, users affected, deployment context) [REQUIRED]
- **use_case**: Specific application (e.g., hiring tool, medical diagnosis, content moderation) [REQUIRED]
- **risk_category**: High-risk, limited-risk, or minimal-risk per EU AI Act classification [OPTIONAL but recommended]
- **existing_documentation**: Technical docs, data sheets, model cards, risk assessments [OPTIONAL]
- **stakeholders**: Who develops, deploys, uses, and is affected by the AI [OPTIONAL]
- **regulatory_context**: Applicable laws (GDPR, EU AI Act, industry regulations) [OPTIONAL]

## ISO 42001 Framework Overview


ISO 42001 is structured around **10 key clauses** plus supporting annexes:

### Core Clauses

1. **Scope** - Define AIMS boundaries
2. **Normative References** - Related standards
3. **Terms and Definitions** - AI terminology
4. **Context of Organization** - Internal/external factors
5. **Leadership** - Management commitment and roles
6. **Planning** - Objectives and risk management
7. **Support** - Resources, competence, communication
8. **Operation** - AI system lifecycle management
9. **Performance Evaluation** - Monitoring and measurement
10. **Improvement** - Continual enhancement

### Key ISO 42001 Principles

#### 1. Risk-Based Approach
- Identify, assess, and mitigate AI-specific risks
- Consider technical, ethical, legal, and social risks
- Proportionate controls based on risk level

#### 2. Ethical AI
- Fairness and non-discrimination
- Transparency and explainability
- Human oversight and control
- Privacy and data protection
- Accountability

#### 3. Lifecycle Management
- Design  Development  Deployment  Monitoring  Decommissioning
- Continuous evaluation and improvement
- Documentation throughout

#### 4. Stakeholder Engagement
- Involve affected parties
- Clear communication about AI use
- Mechanisms for feedback and redress

---

## Audit Procedure


Follow these steps systematically:

### Step 1: Context and Scope Analysis (15 minutes)

**Understand the AI System:**

1. **Define AIMS Scope** (Clause 4)
   - What AI systems are included?
   - Organizational boundaries
   - Interfaces with other systems
   - Exclusions (if any)

2. **Identify Stakeholders:**
   - **Developers**: Who builds the AI?
   - **Deployers**: Who operates it?
   - **Users**: Who interacts with it?
   - **Affected Parties**: Who is impacted by decisions?
   - **Regulators**: What oversight exists?

3. **Assess Context:**
   - Industry and domain
   - Regulatory environment (EU AI Act, GDPR, sector-specific)
   - Cultural and social considerations
   - Technical maturity and capabilities

4. **Risk Classification** (EU AI Act alignment):
   - **Unacceptable Risk**: Prohibited uses (e.g., social scoring, real-time biometric surveillance)
   - **High Risk**: Significant impact (e.g., employment, credit scoring, healthcare, law enforcement)
   - **Limited Risk**: Transparency obligations (e.g., chatbots, deepfakes)
   - **Minimal Risk**: Low impact (e.g., spam filters, recommender systems)

---

### Step 2: Leadership and Governance Evaluation (20 minutes)

#### Clause 5: Leadership

**5.1 Leadership and Commitment**

**Evaluate:**
- [ ] Top management demonstrates commitment to AIMS
- [ ] AI governance policy established
- [ ] Resources allocated for responsible AI
- [ ] AI risks integrated into strategic planning

**Questions:**
- Is there executive-level accountability for AI?
- Who owns AI governance?
- Are AI principles documented and communicated?

**Findings:**
-  Good: [Examples of strong leadership]
-  Gaps: [Missing elements]

---

**5.2 AI Policy**

**Evaluate:**
- [ ] Documented AI policy exists
- [ ] Covers ethical principles
- [ ] Addresses risk management
- [ ] Defines roles and responsibilities
- [ ] Communicated to stakeholders
- [ ] Regularly reviewed and updated

**Required Policy Elements:**
1. **Purpose and Scope**: What AI systems are covered
2. **Ethical Principles**: Fairness, transparency, accountability
3. **Risk Management**: How risks are identified and mitigated
4. **Human Oversight**: Mechanisms for human control
5. **Data Governance**: Data quality, privacy, security
6. **Compliance**: Legal and regulatory obligations
7. **Incident Response**: How AI failures are handled
8. **Continuous Improvement**: Review and update processes

**Assessment:**
- Policy Score: [0-10]
- Completeness: [Comprehensive/Partial/Missing]
- Implementation: [Enforced/Documented only/Not followed]

---

**5.3 Organizational Roles and Responsibilities**

**Evaluate:**
- [ ] AI governance roles defined (e.g., AI Ethics Officer, Data Protection Officer)
- [ ] Clear accountability for AI decisions
- [ ] Cross-functional AI governance team
- [ ] Competencies and training requirements specified

**Key Roles to Define:**
- **AI Product Owner**: Responsible for AI system outcomes
- **AI Ethics Committee**: Oversees ethical compliance
- **Data Governance Lead**: Ensures data quality and privacy
- **Security Lead**: Manages AI security risks
- **Legal/Compliance Officer**: Ensures regulatory compliance
- **Human Oversight Designate**: Maintains meaningful human control

**Gap Analysis:**
- Defined: [Roles present]
- Missing: [Roles needed]
- Unclear: [Ambiguous responsibilities]

---

### Step 3: Planning and Risk Management (30 minutes)

#### Clause 6: Planning

**6.1 Actions to Address Risks and Opportunities**

**ISO 42001 Risk Categories:**

1. **Technical Risks**
   - Model accuracy and reliability
   - Robustness to adversarial attacks
   - Data quality and bias
   - System failures and errors
   - Integration issues
   - Scalability and performance

2. **Ethical Risks**
   - Discrimination and bias
   - Lack of fairness
   - Privacy violations
   - Lack of transparency
   - Autonomy and human dignity impacts

3. **Legal and Compliance Risks**
   - Regulatory non-compliance (GDPR, EU AI Act)
   - Intellectual property issues
   - Liability for AI decisions
   - Contractual obligations

4. **Operational Risks**
   - Dependency on AI vendors
   - Skills and competency gaps
   - Change management failures
   - Inadequate monitoring

5. **Reputational Risks**
   - Public trust erosion
   - Media scrutiny
   - Stakeholder backlash
   - Brand damage from AI failures

**Risk Assessment Process:**

For each identified risk:

```markdown
## Risk: [Name]

See `references/risk-template.md` for the risk register template.

---

## Complete ISO 42001 Audit Report


```markdown
# ISO 42001 AI Governance Audit Report

**AI System**: [Name]
**Organization**: [Name]
**Date**: [Date]
**Auditor**: [AI Agent]
**Standard**: ISO/IEC 42001:2023

---

## Executive Summary


### Compliance Status

**Overall Conformance**: [Conformant / Partially Conformant / Non-Conformant]

**Conformance by Clause:**

| Clause | Title | Status | Score | Critical Gaps |
|--------|-------|--------|-------|---------------|
| 4 | Context |  /  /  | [X]/10 | [List] |
| 5 | Leadership |  /  /  | [X]/10 | [List] |
| 6 | Planning |  /  /  | [X]/10 | [List] |
| 7 | Support |  /  /  | [X]/10 | [List] |
| 8 | Operation |  /  /  | [X]/10 | [List] |
| 9 | Evaluation |  /  /  | [X]/10 | [List] |
| 10 | Improvement |  /  /  | [X]/10 | [List] |

**Overall Score**: [X]/100

### Risk Classification

**AI System Risk Level**: High / Limited / Minimal / Unacceptable

**Justification**: [Based on EU AI Act criteria and impact assessment]

### Top 5 Critical Findings

1. **[Finding]** - Clause [X] - Severity: Critical
   - Risk: [Description]
   - Impact: [Consequences]
   - Recommendation: [Immediate action]

2. **[Finding]** - Clause [X] - Severity: High
   [Continue...]

### Positive Highlights

-  [Strength 1]
-  [Strength 2]
-  [Strength 3]

---

## Detailed Findings


[Full analysis by clause with evidence, gaps, and recommendations]

---

## Risk Assessment Summary


### Critical Risks Identified

**Risk 1: [Name]**
- **Category**: Ethical / Technical / Legal / Operational
- **Likelihood**: High
- **Impact**: Critical
- **Risk Level**: CRITICAL
- **Current Controls**: [Insufficient]
- **Required Actions**: [List]
- **Owner**: [Responsible party]
- **Deadline**: [Date]

[Continue for all critical and high risks...]

---

## Compliance Roadmap


### Phase 1: Critical Compliance (0-3 months)

**Objective**: Address critical gaps and establish baseline compliance

**Actions:**
1. [Action 1] - Owner: [Name] - Due: [Date]
2. [Action 2] - Owner: [Name] - Due: [Date]
3. [Action 3] - Owner: [Name] - Due: [Date]

**Success Criteria**: [Measurable outcomes]

**Investment**: [Time, resources, budget]

---

### Phase 2: Enhanced Governance (3-6 months)

**Objective**: Strengthen AI governance and risk management

**Actions:**
[List...]

---

### Phase 3: Maturity and Optimization (6-12 months)

**Objective**: Achieve full conformance and continual improvement

**Actions:**
[List...]

---

## Documentation Requirements


### Missing Documentation

- [ ] AI Policy Document
- [ ] Risk Assessment Register
- [ ] Model Cards for all AI systems
- [ ] Data Governance Procedures
- [ ] Incident Response Plan
- [ ] Training Records
- [ ] Audit Reports

**Priority**: Create within [timeframe]

---

## Recommendations by Stakeholder


### For Leadership

1. Establish AI Ethics Committee
2. Allocate budget for responsible AI
3. Mandate ISO 42001 compliance

### For AI Teams

1. Implement fairness testing in CI/CD
2. Create model cards for all systems
3. Conduct bias audits quarterly

### For Legal/Compliance

1. Monitor regulatory developments (EU AI Act)
2. Update privacy policies for AI use
3. Establish DPIA process for high-risk AI

### For Operations

1. Deploy monitoring infrastructure
2. Implement human oversight mechanisms
3. Create incident response runbooks

---

## Next Steps


1. **Immediate (Week 1)**
   - [ ] Present findings to leadership
   - [ ] Prioritize critical actions
   - [ ] Assign ownership

2. **Short-term (Month 1)**
   - [ ] Address critical risks
   - [ ] Start documentation efforts
   - [ ] Initiate training program

3. **Medium-term (Months 2-6)**
   - [ ] Implement AIMS processes
   - [ ] Conduct follow-up audit
   - [ ] Achieve partial conformance

4. **Long-term (Months 6-12)**
   - [ ] Full ISO 42001 conformance
   - [ ] Consider third-party certification
   - [ ] Continual improvement program

---

## Appendices


### A. ISO 42001 Checklist
[Detailed requirement-by-requirement checklist]

### B. Risk Register
[Complete risk inventory with assessments]

### C. Glossary
[AI and ISO terminology]

### D. References
- ISO/IEC 42001:2023
- EU AI Act
- NIST AI Risk Management Framework
- [Industry-specific standards]

---

**Report Version**: 1.0
**Confidentiality**: [Internal / Confidential / Public]
```

---

## ISO 42001 Compliance Checklist


Use this quick reference for self-assessment:

### Clause 4: Context 

- [ ] AIMS scope defined
- [ ] Stakeholders identified
- [ ] External issues (regulatory, social) assessed
- [ ] Internal capabilities evaluated

### Clause 5: Leadership 

- [ ] Management commitment documented
- [ ] AI policy established
- [ ] Roles and responsibilities assigned
- [ ] AI ethics committee or similar

### Clause 6: Planning 

- [ ] AI objectives set
- [ ] Risk assessment conducted
- [ ] Risk treatment plans documented
- [ ] Opportunities for improvement identified

### Clause 7: Support 

- [ ] Resources allocated (compute, budget, people)
- [ ] Competence requirements defined
- [ ] Training provided
- [ ] Awareness program active
- [ ] Documentation maintained

### Clause 8: Operation 

- [ ] AI lifecycle processes defined
- [ ] Data governance implemented
- [ ] Model development standards
- [ ] Validation and testing procedures
- [ ] Deployment controls
- [ ] Monitoring systems active
- [ ] Change management process

### Clause 9: Evaluation 

- [ ] Performance monitoring
- [ ] Internal audits scheduled
- [ ] Management reviews conducted
- [ ] KPIs tracked

### Clause 10: Improvement 

- [ ] Nonconformity process
- [ ] Corrective actions
- [ ] Continual improvement culture

---

## Best Practices


1. **Start with Risk Assessment**: Prioritize based on AI risk level
2. **Document Everything**: ISO 42001 requires extensive documentation
3. **Engage Stakeholders Early**: Include affected parties in governance
4. **Use Existing Frameworks**: Leverage NIST AI RMF, EU AI Act requirements
5. **Automate Monitoring**: Build MLOps with governance built-in
6. **Train Your Team**: ISO 42001 requires competent personnel
7. **Regular Audits**: Don't wait for problemsproactive reviews
8. **Learn from Incidents**: Every issue is improvement opportunity
9. **Balance Innovation and Safety**: Responsible AI doesn't mean no AI
10. **Seek Certification**: Third-party ISO 42001 certification adds credibility

---

## Regulatory Alignment


ISO 42001 aligns with major AI regulations:

**EU AI Act:**
- Risk classification framework
- High-risk AI obligations
- Transparency requirements
- Conformity assessment

**GDPR:**
- Data protection by design
- Privacy impact assessments
- Data subject rights
- Lawful processing

**NIST AI RMF:**
- Govern, Map, Measure, Manage functions
- Risk-based approach
- Trustworthy AI characteristics

**Sector-Specific:**
- Healthcare: FDA AI/ML guidance, MDR
- Finance: Model Risk Management (SR 11-7)
- Employment: EEOC AI guidance

---

## Common Pitfalls


1. **"We'll add governance later"** - Build it in from the start
2. **Treating ISO 42001 as one-time exercise** - It's continual
3. **Documentation without implementation** - Must be operational
4. **Ignoring low-risk AI** - Even minimal-risk needs baseline governance
5. **No stakeholder engagement** - Affected parties must be involved
6. **Insufficient resources** - Responsible AI requires investment
7. **Lack of monitoring** - Deploy-and-forget is non-compliant
8. **No incident response plan** - When AI fails, you need a plan
9. **Training as checkbox** - Teams must truly understand responsible AI
10. **Copying templates without customization** - Tailor to your context

---

## Version


1.0 - Initial release based on ISO/IEC 42001:2023

---

**Remember**: ISO 42001 is about building trustworthy AI systems through systematic risk management and governance. It's not a barrier to innovationit's a framework for responsible innovation that protects both organizations and the people affected by AI.

---
 2026 Galyarder Labs. Forge Anything.
