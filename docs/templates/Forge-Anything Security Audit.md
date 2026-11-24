# Security Audit

## Purpose
Assess the state of the Security department in the whole system: how well security review, threat modeling, hardening, and compliance basics hold together, and where they are weak.

## Scope
- Security review of new code and new systems
- Threat modeling for the product
- Hardening of cloud setup and access
- Privacy and data handling basics
- License checks for open source use
- Incident response steps

The scaffold carries defensive and compliance basics only. Specialist offensive work is out of scope here.

## What is in place
- [ ] Lead agent for security is named and active
- [ ] Skill that reviews cloud setup for common gaps
- [ ] Skill that checks privacy and data handling basics
- [ ] Skill that checks open source license use
- [ ] Workflow that reviews new code for security issues before it ships
- [ ] Threat model for the product, kept current
- [ ] Incident response steps written down and known

## Gaps
- [ ] No regular review of cloud and access settings
- [ ] Privacy and license checks happen late or never
- [ ] Threat model is missing or stale
- [ ] Incident steps are unwritten or untested
- [ ] Security findings have no path to a fix

## Next steps
- Pick the highest priority gap and name its owner
- Add or fix the missing agent, skill, command, or workflow for that gap
- Run the new piece on a real review or incident drill and check the result against evidence
- Record the decision and the outcome in the decision log
- Repeat for the next gap
- Share the finished audit and the changes with the people who need them, so the work reaches distribution
