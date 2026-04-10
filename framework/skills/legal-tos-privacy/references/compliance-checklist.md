# Jurisdiction-Specific Compliance Requirements

Reference for ensuring legal documents meet requirements across major jurisdictions.

## GDPR (EU/EEA/UK)

Applies if: Processing personal data of EU/EEA/UK residents, regardless of company location.

### Privacy Policy Requirements

- [ ] **Identity & Contact** - Name/address of controller, DPO contact if applicable
- [ ] **Legal Basis** - State legal basis for each processing purpose:
  - Consent (freely given, specific, informed, unambiguous)
  - Contract performance
  - Legal obligation
  - Vital interests
  - Public interest
  - Legitimate interests (must specify what they are)
- [ ] **Data Categories** - List all categories of personal data collected
- [ ] **Recipients** - Categories of recipients, including international transfers
- [ ] **Retention Periods** - Specific periods or criteria for determining them
- [ ] **Data Subject Rights** - Must inform of rights to:
  - Access (Art. 15)
  - Rectification (Art. 16)
  - Erasure/"Right to be forgotten" (Art. 17)
  - Restriction of processing (Art. 18)
  - Data portability (Art. 20)
  - Object to processing (Art. 21)
  - Not be subject to automated decision-making (Art. 22)
  - Withdraw consent at any time
  - Lodge complaint with supervisory authority
- [ ] **International Transfers** - Safeguards for transfers outside EU/EEA (SCCs, adequacy decisions)
- [ ] **Automated Decision-Making** - If used, logic involved and consequences
- [ ] **Source of Data** - If not collected directly from data subject

### ToS Requirements

- [ ] **Clear Consent Mechanism** - Clickwrap agreement with affirmative action
- [ ] **Plain Language** - Clear and understandable terms
- [ ] **Unfair Terms Prohibition** - Cannot include grossly unfair contract terms

### Cookie Requirements (ePrivacy)

- [ ] **Cookie Consent** - Prior consent before non-essential cookies
- [ ] **Cookie Information** - What cookies, purpose, duration, third parties
- [ ] **Granular Control** - Users must be able to accept/reject by category
- [ ] **No Cookie Walls** - Cannot force consent for service access (with exceptions)

---

## CCPA/CPRA (California)

Applies if: Business that (a) has gross revenue >$25M, OR (b) buys/sells data of 100k+ consumers, OR (c) derives 50%+ revenue from selling data.

### Privacy Policy Requirements

- [ ] **Categories Collected** - List categories of personal information collected in past 12 months
- [ ] **Sources** - Categories of sources for each category of PI
- [ ] **Business Purpose** - Purpose for collecting/using each category
- [ ] **Third-Party Sharing** - Categories of third parties with whom PI is shared
- [ ] **Sale/Sharing Disclosure** - State if you sell or share PI for targeted advertising
- [ ] **Retention Periods** - How long each category is retained
- [ ] **Consumer Rights Notice** - Inform of rights:
  - Know what PI is collected
  - Know if PI is sold/shared
  - Opt-out of sale/sharing
  - Request deletion
  - Correct inaccurate PI
  - Limit use of sensitive PI
  - Non-discrimination for exercising rights
- [ ] **"Do Not Sell My Personal Information"** - Link required if selling/sharing PI
- [ ] **"Limit Use of Sensitive Personal Information"** - Link if using sensitive PI
- [ ] **Authorized Agent** - Process for authorized agent requests
- [ ] **Contact Methods** - At least two methods to submit requests
- [ ] **Annual Update** - Policy must be reviewed/updated at least annually

### Sensitive Personal Information Categories

If collecting any, must allow limiting use:
- Social Security numbers
- Driver's license/passport numbers
- Financial account info with credentials
- Precise geolocation
- Racial/ethnic origin
- Religious/philosophical beliefs
- Union membership
- Genetic/biometric data
- Health information
- Sex life/sexual orientation

---

## LGPD (Brazil)

Applies if: Processing personal data in Brazil, or of individuals in Brazil, or data collected in Brazil.

### Privacy Policy Requirements

- [ ] **Controller Identity** - Name and contact of data controller
- [ ] **Legal Basis** - Must specify basis (10 possible under LGPD)
- [ ] **Processing Purpose** - Specific purposes for each processing activity
- [ ] **Data Categories** - Types of personal data processed
- [ ] **Retention Period** - Duration of processing
- [ ] **International Transfers** - Countries/organizations receiving data
- [ ] **Data Subject Rights** - Must inform of rights:
  - Confirmation of processing
  - Access to data
  - Correction of incomplete/inaccurate data
  - Anonymization, blocking, or deletion of unnecessary data
  - Data portability
  - Deletion of data processed with consent
  - Information about sharing with third parties
  - Information about denying consent and consequences
  - Revocation of consent
  - Opposition to processing if done illegally
  - Review of automated decisions
- [ ] **DPO Contact** - If appointed, must provide contact

---

## COPPA (United States - Children)

Applies if: Website/service directed at children under 13, OR has actual knowledge of collecting data from children under 13.

### Requirements

- [ ] **Age Screening** - Mechanism to determine if user is under 13
- [ ] **Parental Consent** - Verifiable parental consent before collecting PI from children
- [ ] **Direct Notice to Parents** - Before collecting data, describing:
  - What PI is collected
  - How it will be used
  - Disclosure practices
  - Parent's rights
- [ ] **Privacy Policy** - Must include:
  - All operators collecting PI through site
  - Contact information for each operator
  - Types of PI collected from children
  - How PI is used
  - Whether PI is disclosed to third parties
  - Parental rights (review, delete, refuse further collection)
- [ ] **Data Minimization** - Only collect what's necessary
- [ ] **Security** - Reasonable procedures to protect confidentiality
- [ ] **Retention Limits** - Only retain as long as necessary

### Safe Harbor

If complying with FTC-approved self-regulatory program, may qualify for safe harbor.

---

## CAN-SPAM (United States - Email)

Applies if: Sending commercial email messages.

### Requirements

- [ ] **No Deceptive Headers** - Accurate "From", "To", "Reply-To"
- [ ] **No Deceptive Subject Lines** - Must accurately reflect content
- [ ] **Identify as Ad** - Clear disclosure that message is advertisement
- [ ] **Physical Address** - Valid postal address included
- [ ] **Opt-Out Mechanism** - Clear way to opt out of future emails
- [ ] **Honor Opt-Outs** - Process requests within 10 business days
- [ ] **Monitor Third Parties** - Responsible for compliance even if hiring others

---

## CASL (Canada - Email)

Applies if: Sending commercial electronic messages to Canadian recipients.

### Requirements

- [ ] **Express Consent** - Required before sending commercial messages (some implied consent exceptions)
- [ ] **Sender Identification** - Name, mailing address, contact info
- [ ] **Unsubscribe Mechanism** - Must be included and honored within 10 business days
- [ ] **Record Keeping** - Proof of consent must be maintained

---

## PCI DSS (Payment Card Industry)

Applies if: Storing, processing, or transmitting cardholder data.

### Requirements

- [ ] **Secure Network** - Firewall, no vendor-supplied defaults
- [ ] **Protect Data** - Encryption of cardholder data in transit and at rest
- [ ] **Vulnerability Management** - Anti-virus, secure systems/applications
- [ ] **Access Control** - Restrict access on need-to-know basis
- [ ] **Monitoring** - Track and monitor all access
- [ ] **Security Policy** - Maintain information security policy

### Disclosure in Privacy Policy

- [ ] State compliance with PCI DSS (if applicable)
- [ ] Describe how payment data is protected
- [ ] Note that card data is processed by certified payment processor

---

## Additional Industry-Specific

### HIPAA (US Healthcare)

If handling Protected Health Information (PHI):
- [ ] Business Associate Agreement with covered entities
- [ ] Notice of Privacy Practices
- [ ] Minimum necessary standard
- [ ] Patient rights (access, amendment, accounting of disclosures)
- [ ] Administrative, physical, and technical safeguards

### SOX (Financial/Public Companies)

If public company or providing services to them:
- [ ] Data integrity controls
- [ ] Audit trails
- [ ] Access controls documentation

### FERPA (US Education)

If handling student education records:
- [ ] Written consent for disclosure
- [ ] Annual notification of rights
- [ ] Access and amendment rights

---

## Compliance Verification Matrix

Use this matrix to track compliance across jurisdictions:

| Requirement | GDPR | CCPA | LGPD | Notes |
|-------------|------|------|------|-------|
| Legal basis stated | ✓ Required | N/A | ✓ Required | |
| Right to access | ✓ | ✓ | ✓ | All three require |
| Right to deletion | ✓ | ✓ | ✓ | With exceptions |
| Data portability | ✓ | ✓ | ✓ | Format varies |
| Opt-out of sale | N/A | ✓ | N/A | CCPA-specific |
| Consent before cookies | ✓ | Cookie notice | ✓ | GDPR strictest |
| DPO required | Sometimes | No | Sometimes | Depends on processing |
| Breach notification | 72 hours | ASAP | Reasonable time | GDPR most specific |
| Fines | Up to 4% global revenue | Up to $7,500/violation | Up to 2% revenue | |

---

## Essential Protective Clauses

### Jurisdiction-Neutral Liability Cap

```
TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT WILL [COMPANY] 
BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE 
DAMAGES WHATSOEVER ARISING OUT OF OR IN CONNECTION WITH YOUR USE OF THE SERVICE.
```

### Consumer Rights Acknowledgment

```
Nothing in these Terms shall limit or exclude any rights you may have under 
applicable consumer protection laws that cannot be lawfully limited or excluded.
```

### Severability with Reformation

```
If any provision of these Terms is found to be unenforceable or invalid, that 
provision will be limited or eliminated to the minimum extent necessary so that 
these Terms will otherwise remain in full force and effect and enforceable.
```

### Jurisdiction-Specific Rights Preservation

```
If you are a resident of the European Economic Area, you have certain data 
protection rights under the GDPR. If you are a California resident, you have 
certain rights under the CCPA/CPRA. Nothing in this Privacy Policy is intended 
to limit any rights you have under applicable law.
```
