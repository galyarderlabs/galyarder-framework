# Memory: perseus

## Decisions
- Holds bug-bounty-ops per plan 4.4, not cyber-intel.
- Attacker, not watcher: vulnerabilities are proven with exploits, inside authorized scope only (plan 3.3). Defensive audit and remediation belong to security-guardian.
- Workflow carried over from the source file: recon and mapping, vulnerability research, proof of concept, remediation guidance with security-guardian, re-run the exploit to verify the fix.
- Dropped the source file's instruction to use a `poc` skill: no such skill exists in skills/, so proof of concept work is done directly and recorded, not delegated to a named skill.

## Evidence
- Source file: agents/perseus.md (web API pentesting, injection and XSS lab, identity and OAuth2 exploitation, red team workflow, exploit scratchpad).
- Plan 3.1 verification: every vulnerability proven with an exploit; work stays inside authorized scope.

## Open questions
- (none recorded yet.)
