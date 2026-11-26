# Memory: Security Guardian

## Decisions
- Absorbed security-reviewer.md (rev-3 baseline merge). Review work is the same job as audit work: findings point to code with severity.
- Absorbed the DeFi Auditor role (plan 3.2 item 10). There was no defi-auditor file; the DeFi-Audit skill is held here per plan 3.1. Smart contract audit is security audit in the Solidity/EVM domain, not a separate job.
- Zero trust carried over from the source file: all external input is untrusted until validated and sanitized.
- Direct evidence principle carried over: findings must be based on direct, observable evidence, never theoretical vulnerabilities.
- Incident response scope carried over: eradicate malware, restore from clean backups after ransomware, recover deleted files.

## Evidence
- Source files: agents/security-guardian.md (OWASP Top 10 analysis, zero trust, incident response, audit workflow, LLM safety, DevOps and infra security), agents/security-reviewer.md (OWASP Top 10 review workflow, secrets detection, financial and blockchain checks, review report format, PR review template).
- Plan 3.1 verification: every finding points to vulnerable code with severity; findings pass independent re-verification.

## Open questions
- (none recorded yet.)
