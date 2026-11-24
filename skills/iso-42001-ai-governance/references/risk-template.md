# Risk Register Template

**Category**: Technical / Ethical / Legal / Operational / Reputational
**Likelihood**: Low / Medium / High
**Impact**: Low / Medium / High / Critical
**Risk Level**: [Likelihood  Impact]

**Description**: [What could go wrong]
**Affected Stakeholders**: [Who is impacted]
**Existing Controls**: [Current mitigations]
**Residual Risk**: [Risk after controls]

**Treatment Plan**:
- [ ] Accept (if low risk)
- [ ] Mitigate (reduce likelihood/impact)
- [ ] Transfer (insurance, contracts)
- [ ] Avoid (don't deploy feature)

**Mitigation Actions**:
1. [Specific action 1]
2. [Specific action 2]
3. [Specific action 3]

**Owner**: [Who is responsible]
**Timeline**: [When to implement]
**Review Date**: [When to reassess]
```

**Example Risks:**

**Risk 1: Algorithmic Bias in Hiring AI**
- Category: Ethical, Legal
- Likelihood: High (historical bias in training data)
- Impact: Critical (discrimination, legal liability)
- Risk Level: **CRITICAL**
- Mitigation:
  - Bias testing on protected attributes
  - Diverse training data
  - Regular fairness audits
  - Human review of decisions
  - Transparent criteria documentation

**Risk 2: Data Poisoning Attack**
- Category: Technical, Security
- Likelihood: Medium (if public data sources)
- Impact: High (model corruption)
- Risk Level: **HIGH**
- Mitigation:
  - Data validation and sanitization
  - Anomaly detection
  - Provenance tracking
  - Regular model retraining
  - Adversarial testing

---

**6.2 AI Objectives and Planning to Achieve Them**

**Evaluate:**
- [ ] Measurable AI objectives defined
- [ ] Aligned with organizational goals
- [ ] Consider stakeholder needs
- [ ] Include ethical and safety criteria
- [ ] Resources and timelines allocated
- [ ] Performance indicators established

**SMART AI Objectives Example:**
- "Achieve 95% accuracy while maintaining <5% false positive rate across all demographic groups by Q4"
- "Reduce bias disparity in loan approvals to <2% between groups by 2026"
- "Maintain 100% compliance with GDPR data subject rights"

---

### Step 4: Support and Resources (20 minutes)

#### Clause 7: Support

**7.1 Resources**

**Evaluate:**
- [ ] Adequate computational resources (GPUs, cloud infrastructure)
- [ ] Sufficient budget for responsible AI practices
- [ ] Access to diverse, quality training data
- [ ] Tools for AI monitoring and testing
- [ ] Expertise and personnel available

**Resource Assessment:**
- Compute: [Adequate/Limited/Insufficient]
- Budget: [Well-funded/Constrained/Underfunded]
- Data: [High-quality/Adequate/Poor]
- Tools: [State-of-art/Basic/Lacking]
- People: [Expert team/Learning/Understaffed]

---

**7.2 Competence**

**Evaluate:**
- [ ] AI/ML expertise available
- [ ] Understanding of ethical AI principles
- [ ] Knowledge of relevant regulations
- [ ] Data science and engineering skills
- [ ] Domain expertise for use case
- [ ] Ongoing training and development

**Competency Gaps:**
- Technical: [Gaps identified]
- Ethical: [Training needed]
- Legal: [Compliance knowledge]
- Domain: [Subject matter expertise]

**Training Plan:**
- Who needs training: [Roles]
- Topics: [Areas to cover]
- Format: [Workshops, courses, certifications]
- Timeline: [When to complete]

---

**7.3 Awareness**

**Evaluate:**
- [ ] Staff aware of AI policy
- [ ] Understanding of responsible AI principles
- [ ] Know how to report AI concerns
- [ ] Aware of their role in AI governance

**Communication Channels:**
- Internal documentation
- Training sessions
- Regular updates
- Incident reporting mechanisms

---

**7.4 Communication**

**Evaluate:**
- [ ] Stakeholder communication plan exists
- [ ] Transparency about AI use
- [ ] Clear explanation of AI decisions (where required)
- [ ] Feedback mechanisms for affected parties
- [ ] Public disclosure appropriate to risk level

**Communication Requirements by Risk Level:**

**High-Risk AI:**
- Public disclosure of AI use
- Detailed explanation of how system works
- Rights and remedies for affected individuals
- Contact for questions and complaints

**Limited-Risk AI:**
- Notification of AI interaction (e.g., chatbot disclosure)
- Basic information about system purpose

**Minimal-Risk AI:**
- Standard privacy notices
- Optional transparency information

---

**7.5 Documented Information**

**Evaluate:**
- [ ] AI system documentation maintained
- [ ] Model cards or datasheets created
- [ ] Risk assessments documented
- [ ] Audit trails for decisions
- [ ] Version control for models and data
- [ ] Retention policies defined

**Required Documentation (ISO 42001):**

1. **AI Policy and Procedures**
2. **Risk Assessments and Treatment Plans**
3. **AI System Descriptions** (Model Cards)
   - Purpose and intended use
   - Training data sources and characteristics
   - Model architecture and hyperparameters
   - Performance metrics
   - Known limitations and biases
   - Monitoring and maintenance procedures

4. **Data Governance Documentation**
   - Data inventories
   - Data quality assessments
   - Privacy impact assessments (PIAs)
   - Data lineage and provenance

5. **Testing and Validation Records**
   - Accuracy, fairness, robustness tests
   - Adversarial testing results
   - Edge case analysis
   - Ongoing monitoring logs

6. **Incident Reports and Resolutions**
7. **Training Records** (personnel competence)
8. **Audit and Review Reports**

**Documentation Maturity:**
- Level 5: Comprehensive, up-to-date, accessible
- Level 4: Good coverage, some gaps
- Level 3: Basic docs, outdated areas
- Level 2: Minimal, incomplete
- Level 1: Little to no documentation

---

### Step 5: Operation - AI Lifecycle Management (40 minutes)

#### Clause 8: Operation

**8.1 Operational Planning and Control**

ISO 42001 requires managing AI through its entire lifecycle:

**AI Lifecycle Stages:**

```
Design  Development  Validation  Deployment  Monitoring  Maintenance  Decommissioning
```

---

**STAGE 1: Design and Requirements**

**Evaluate:**
- [ ] Clear problem definition and success criteria
- [ ] Stakeholder needs assessed
- [ ] Ethical considerations identified early
- [ ] Regulatory requirements mapped
- [ ] Feasibility and impact analysis conducted
- [ ] Alternatives to AI considered

**Questions:**
- Is AI the right solution, or could simpler approaches work?
- What could go wrong?
- Who is affected and how?
- What data is needed and available?
- What are the ethical red lines?

**Red Flags:**
- Using AI for high-stakes decisions without justification
- No clear success metrics
- Ignoring stakeholder concerns
- Insufficient data or biased data sources

---

**STAGE 2: Data Management**

**Evaluate:**
- [ ] Data quality assessed (accuracy, completeness, timeliness)
- [ ] Bias and representativeness analyzed
- [ ] Data sources documented and verified
- [ ] Privacy and consent requirements met
- [ ] Data security and access controls
- [ ] Data minimization principles applied

**Data Quality Dimensions:**
1. **Accuracy**: Correct and error-free
2. **Completeness**: No missing values in critical fields
3. **Consistency**: Uniform across sources
4. **Timeliness**: Up-to-date and relevant
5. **Representativeness**: Reflects target population
6. **Fairness**: Balanced across demographic groups

**Bias Detection:**
- [ ] Underrepresentation of groups
- [ ] Historical bias in labels
- [ ] Proxy discrimination (e.g., zip code for race)
- [ ] Sampling bias
- [ ] Measurement bias

**Privacy Compliance (GDPR/ISO 42001):**
- [ ] Lawful basis for processing (consent, legitimate interest, etc.)
- [ ] Data subject rights supported (access, deletion, portability)
- [ ] Privacy by design principles
- [ ] Data Protection Impact Assessment (DPIA) if high-risk
- [ ] Data Processing Agreements (DPAs) with vendors

---

**STAGE 3: Model Development**

**Evaluate:**
- [ ] Appropriate algorithm selection
- [ ] Explainability requirements considered
- [ ] Fairness constraints incorporated
- [ ] Robustness testing planned
- [ ] Version control for code and models
- [ ] Reproducibility ensured

**Model Development Best Practices:**

1. **Baseline Establishment**
   - Simple model first (logistic regression, decision tree)
   - Standard against human performance
   - Justify complexity increase

2. **Fairness Considerations**
   - Define fairness metrics (demographic parity, equalized odds, etc.)
   - Test across protected attributes
   - Trade-offs between accuracy and fairness documented

3. **Explainability**
   - Use interpretable models when possible
   - Apply XAI techniques (SHAP, LIME) for black-box models
   - Document feature importance
   - Provide example-based explanations

4. **Adversarial Robustness**
   - Test against adversarial examples
   - Implement input validation
   - Monitor for distribution shift

5. **Reproducibility**
   - Random seeds set
   - Hyperparameters logged
   - Environment documented (dependencies, versions)
   - Training data snapshots preserved

---

**STAGE 4: Validation and Testing**

**Evaluate:**
- [ ] Comprehensive test suite executed
- [ ] Performance across subgroups validated
- [ ] Fairness metrics measured
- [ ] Robustness testing (adversarial, edge cases)
- [ ] Safety and security testing
- [ ] User acceptance testing (UAT)
- [ ] Independent validation (if high-risk)

**Testing Checklist:**

**Performance Testing:**
- [ ] Accuracy on test set
- [ ] Precision, recall, F1-score
- [ ] Performance by demographic group
- [ ] Performance on edge cases
- [ ] Calibration (confidence vs. accuracy)

**Fairness Testing:**
- [ ] Demographic parity (equal acceptance rates)
- [ ] Equalized odds (equal false positive/negative rates)
- [ ] Predictive parity (equal precision)
- [ ] Individual fairness (similar individuals treated similarly)

**Robustness Testing:**
- [ ] Adversarial examples resistance
- [ ] Input perturbation sensitivity
- [ ] Out-of-distribution detection
- [ ] Stress testing (high load, edge cases)

**Safety Testing:**
- [ ] Failure mode analysis
- [ ] Fallback mechanisms tested
- [ ] Human override tested
- [ ] Emergency stop procedures

**Security Testing:**
- [ ] Model extraction attacks
- [ ] Data poisoning resistance
- [ ] Backdoor detection
- [ ] Privacy leakage testing (membership inference)

**Validation Outcome:**
- Pass: [Meets all criteria]
- Conditional: [Meets most, some improvements needed]
- Fail: [Major gaps, do not deploy]

---

**STAGE 5: Deployment**

**Evaluate:**
- [ ] Phased rollout plan (pilot  limited  full)
- [ ] Monitoring infrastructure in place
- [ ] Human oversight mechanisms established
- [ ] Incident response plan ready
- [ ] User training and communication completed
- [ ] Rollback plan prepared

**Deployment Best Practices:**

1. **Pilot Testing**
   - Small user group
   - Controlled environment
   - Close monitoring
   - Rapid feedback loops

2. **Gradual Rollout**
   - Canary deployment (1%  10%  50%  100%)
   - A/B testing against baseline
   - Monitor for unexpected impacts

3. **Human-in-the-Loop**
   - Human review of high-stakes decisions
   - Override capabilities
   - Escalation procedures
   - Audit sampling

4. **Communication**
   - Notify affected users
   - Provide transparency (AI disclosure)
   - Explain rights and remedies
   - Offer feedback channels

**Deployment Checklist:**
- [ ] Infrastructure ready (compute, storage, APIs)
- [ ] Monitoring dashboards configured
- [ ] Alerting thresholds set
- [ ] Incident response team trained
- [ ] Legal and compliance approval obtained
- [ ] Stakeholder communication sent
- [ ] Documentation updated

---

**STAGE 6: Monitoring and Maintenance**

**Evaluate:**
- [ ] Continuous performance monitoring
- [ ] Drift detection (data and model)
- [ ] Fairness monitoring over time
- [ ] User feedback collection
- [ ] Incident tracking and resolution
- [ ] Regular model retraining
- [ ] Audit trails maintained

**Monitoring Framework:**

**1. Performance Monitoring**
- Accuracy, precision, recall (daily/weekly)
- Latency and throughput
- Error rates and types
- Service availability (uptime)

**2. Fairness Monitoring**
- Outcome disparities across groups (weekly/monthly)
- False positive/negative rates by demographics
- User satisfaction by group
- Complaint rates

**3. Data Drift Detection**
- Input distribution changes
- Feature importance shifts
- Anomaly detection
- Trigger for retraining

**4. Model Drift Detection**
- Prediction distribution changes
- Confidence score patterns
- A/B test against updated models

**5. Safety Monitoring**
- Near-miss incidents
- Human override frequency
- Fallback activations
- Edge case occurrences

**Alert Triggers:**
- Accuracy drops > 5%
- Fairness disparity exceeds threshold
- Data drift detected
- Error rate spike
- Security anomalies
- User complaints increase

**Maintenance Schedule:**
- **Daily**: Dashboard review, alert triage
- **Weekly**: Performance deep-dive, fairness check
- **Monthly**: Model health assessment, incident review
- **Quarterly**: Comprehensive audit, retraining evaluation
- **Annually**: Full ISO 42001 compliance review

---

**STAGE 7: Decommissioning**

**Evaluate:**
- [ ] Decommissioning criteria defined
- [ ] Data retention/deletion policies
- [ ] User migration plan (if replacement system)
- [ ] Impact assessment of discontinuation
- [ ] Archival and documentation
- [ ] Lessons learned captured

**Decommissioning Triggers:**
- End of useful life
- Better alternative available
- Regulatory prohibition
- Unacceptable risk identified
- Business need eliminated

**Decommissioning Process:**
1. Stakeholder notification (advance warning)
2. Gradual phase-out
3. Data handling (delete, anonymize, or archive)
4. Model archival (for audits)
5. Post-mortem analysis
6. Knowledge transfer

---

### Step 6: Performance Evaluation (20 minutes)

#### Clause 9: Performance Evaluation

**9.1 Monitoring, Measurement, Analysis, and Evaluation**

**Key Performance Indicators (KPIs):**

**Technical KPIs:**
- Model accuracy/performance metrics
- System uptime and reliability
- Response time and latency
- Resource utilization

**Ethical KPIs:**
- Fairness metrics (disparity ratios)
- Transparency compliance (disclosure rates)
- Human oversight utilization (review rates)
- User trust and satisfaction scores

**Governance KPIs:**
- Incident response time
- Audit compliance rate
- Training completion rates
- Documentation currency (% up-to-date)

**Business KPIs:**
- User adoption rate
- ROI and cost savings
- Productivity improvements
- Risk mitigation effectiveness

**Dashboard Requirements:**
- Real-time performance metrics
- Fairness indicators
- Alert status
- Incident log
- Trend analysis

---

**9.2 Internal Audit**

**Evaluate:**
- [ ] Internal audit program established
- [ ] Audit schedule defined (at least annually)
- [ ] Independent auditors (not system developers)
- [ ] Audit findings documented
- [ ] Corrective actions tracked

**Audit Scope:**
- Compliance with ISO 42001 requirements
- Effectiveness of risk controls
- Documentation completeness
- Adherence to AI policy
- Incident management effectiveness

**Audit Frequency:**
- **High-Risk AI**: Quarterly
- **Limited-Risk AI**: Bi-annually
- **Minimal-Risk AI**: Annually

---

**9.3 Management Review**

**Evaluate:**
- [ ] Periodic management reviews conducted
- [ ] Review covers AIMS performance
- [ ] Decisions documented
- [ ] Resources allocated for improvements
- [ ] Stakeholder feedback considered

**Review Agenda:**
1. Audit findings and status
2. Performance against objectives
3. Risks and opportunities
4. Incident summary and lessons learned
5. Regulatory changes
6. Resource needs
7. Improvement initiatives

**Review Frequency:** At least annually, or after significant incidents

---

### Step 7: Improvement (15 minutes)

#### Clause 10: Improvement

**10.1 Nonconformity and Corrective Action**

**Evaluate:**
- [ ] Process for identifying nonconformities
- [ ] Root cause analysis conducted
- [ ] Corrective actions implemented
- [ ] Effectiveness verified
- [ ] AIMS updated to prevent recurrence

**Example Nonconformities:**
- Fairness threshold breached
- Undocumented model change
- Training data bias discovered
- Incident response delayed
- Audit finding not addressed

**Corrective Action Process:**
1. Identify nonconformity
2. Immediate containment (stop harm)
3. Root cause analysis (5 Whys, Fishbone)
4. Corrective action plan
5. Implementation
6. Verification of effectiveness
7. Documentation and communication

---

**10.2 Continual Improvement**

**Evaluate:**
- [ ] Process for ongoing improvement
- [ ] Lessons learned captured
- [ ] Best practices shared
- [ ] Innovation encouraged
- [ ] Standarding against industry

**Improvement Opportunities:**
- New techniques for bias mitigation
- Enhanced explainability methods
- Automation of monitoring
- Better stakeholder engagement
- Process efficiency gains

**Improvement Cycle:**
```
Plan  Do  Check  Act (PDCA)
```

Apply continuously to AI systems and governance processes.

---
