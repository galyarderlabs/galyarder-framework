# Open Source License Compliance Checklist

## Pre-Distribution Checklist

Complete this checklist before distributing software that contains open source components.

---

## 1. Inventory & Identification

### 1.1 Software Bill of Materials (SBOM)

- [ ] Create complete inventory of all open source components
- [ ] Document version numbers for each component
- [ ] Identify the license for each component
- [ ] Note any dual-licensed components and chosen license
- [ ] Include transitive dependencies (dependencies of dependencies)

### 1.2 License Classification

### 1. Technical Integrity: The Karpathy Principles
Combat AI slop through rigid adherence to the four principles of Andrej Karpathy:

### 2. Corporate Reporting: The Obsidian Loop
Durable memory is mandatory. Every task must result in a persistent artifact:
- **Write Report**: Upon completion, save a summary/artifact to the relevant department in `docs/departments/` (e.g., `Engineering/`, `Growth/`).
- **Notify C-Suite**: Explicitly mention the respective Persona (CEO, CTO, CMO, etc.) that the report is ready for review.
- **Traceability**: Link the report to the corresponding Linear ticket.
1. **Think Before Coding**: Don't guess. **If uncertain, STOP and ASK.** State assumptions explicitly. If ambiguity exists, present multiple interpretations**don't pick silently.** Push back if a simpler approach exists.
2. **Simplicity First**: Implement the minimum code that solves the problem. **No speculative abstractions.** If 200 lines could be 50, **rewrite it.** No "configurability" unless requested.
3. **Surgical Changes**: Touch **ONLY** what you must. Every changed line must trace to the request. Don't "improve" adjacent code or refactor things that aren't broken. Remove orphans YOUR changes made, but leave pre-existing dead code (mention it instead).
4. **Goal-Driven Execution**: Define success criteria via tests-first. **Loop until verified.**
   - Multi-step tasks MUST use this syntax:
     1. [Step]  verify: [check]
     2. [Step]  verify: [check]

---

## 2. Compatibility Analysis

### 2.1 Outbound License Check

- [ ] Determine your project's outbound license
- [ ] Verify all dependencies are compatible with outbound license
- [ ] Check for GPL/AGPL components if distributing proprietary software
- [ ] Verify Apache-2.0 and GPL-2.0 components aren't mixed

### 2.2 Conflict Resolution

- [ ] Document any license conflicts identified
- [ ] Plan for resolution (remove, replace, relicense, isolate)
- [ ] Obtain alternative licenses if needed

---

## 3. Attribution Requirements

### 3.1 COPYRIGHT and LICENSE Files

- [ ] Include LICENSE file in root directory
- [ ] Include original copyright notices
- [ ] Preserve all license headers in source files
- [ ] Create NOTICE file if required (Apache-2.0, etc.)

### 3.2 Third-Party Notices

- [ ] Compile all third-party license texts
- [ ] Include copyright notices for all dependencies
- [ ] Provide attribution in documentation/about screen
- [ ] Include NOTICE files from Apache-licensed dependencies

### 3.3 Modification Notices

- [ ] Document modifications made to open source components
- [ ] Add "modified by" notices where required
- [ ] Keep changelog of modifications for copyleft code

---

## 4. Source Code Obligations

### 4.1 Copyleft Compliance (GPL/LGPL/AGPL)

- [ ] Identify all copyleft-licensed components
- [ ] Prepare source code for distribution if required
- [ ] Ensure build instructions are included
- [ ] Make source available for minimum 3 years (GPL)
- [ ] Provide "Corresponding Source" for GPL-3.0

### 4.2 LGPL Specific

- [ ] Verify dynamic linking (not static) if using in proprietary software
- [ ] Allow users to replace LGPL library
- [ ] Provide object files or source to enable relinking

### 4.3 AGPL Specific

- [ ] Identify any AGPL components
- [ ] If modifying AGPL code for network service, provide source
- [ ] Include prominent offer to provide source code

### 4.4 MPL Specific

- [ ] Keep MPL-licensed files under MPL
- [ ] Provide source for modified MPL files
- [ ] Can combine with other licenses at file boundaries

---

## 5. Distribution Requirements

### 5.1 Binary Distribution

- [ ] Include license texts with binary distributions
- [ ] Include copyright notices
- [ ] Provide source code offer for copyleft components
- [ ] Include NOTICE files where required

### 5.2 Source Distribution

- [ ] Include complete source code
- [ ] Include build scripts and dependencies list
- [ ] Include all license and copyright files
- [ ] Preserve all existing license headers

### 5.3 SaaS/Network Services

- [ ] Identify any AGPL components
- [ ] Provide source code access to network users
- [ ] Include "About" or similar page with OSS notices

---

## 6. Documentation

### 6.1 Internal Documentation

- [ ] Maintain license compliance policy
- [ ] Document approval process for new dependencies
- [ ] Keep records of compliance decisions
- [ ] Train developers on license obligations

### 6.2 External Documentation

- [ ] Publish open source notices (website, documentation)
- [ ] Provide clear instructions for obtaining source code
- [ ] Include license information in product documentation

---

## 7. Ongoing Compliance

### 7.1 Monitoring

- [ ] Implement automated license scanning in CI/CD
- [ ] Review new dependencies before inclusion
- [ ] Monitor for license changes in dependencies
- [ ] Track security vulnerabilities (often involves license review)

### 7.2 Updates

- [ ] Update SBOM when dependencies change
- [ ] Review license changes in dependency updates
- [ ] Update notices and attributions as needed

---

## License-Specific Checklists

### MIT/BSD/ISC Checklist

- [ ] Include copyright notice in distributions
- [ ] Include license text
- [ ] That's it! (Most permissive)

### Apache-2.0 Checklist

- [ ] Include LICENSE file
- [ ] Include NOTICE file (if provided by upstream)
- [ ] State any modifications made
- [ ] Include copyright notices
- [ ] Preserve any trademark notices

### GPL-3.0 Checklist

- [ ] Include complete license text
- [ ] Preserve all copyright notices
- [ ] State modifications clearly
- [ ] Provide complete source code
- [ ] Include build instructions
- [ ] Provide installation information (anti-Tivoization)
- [ ] Make source available for 3 years

### LGPL-3.0 Checklist

- [ ] All GPL-3.0 requirements for the library itself
- [ ] Dynamically link (not static) for proprietary use
- [ ] Provide object files enabling relinking, OR
- [ ] Use shared library that user can replace
- [ ] Allow reverse engineering for debugging

### AGPL-3.0 Checklist

- [ ] All GPL-3.0 requirements
- [ ] Provide source to users interacting over network
- [ ] Prominent link to source code from application
- [ ] Include complete "Corresponding Source"

### MPL-2.0 Checklist

- [ ] Keep MPL files under MPL
- [ ] Make modified MPL source available
- [ ] Include license notices
- [ ] Can use different license for new files

---

## Red Flags to Watch For

### Stop and Investigate If:

- [ ] Component has no license file  All Rights Reserved!
- [ ] License is custom or modified  Legal review needed
- [ ] Multiple licenses with no clear choice
- [ ] "Non-commercial only" or similar restrictions
- [ ] AGPL in any backend service
- [ ] GPL code being statically linked
- [ ] Copyright notices being stripped
- [ ] Modifications not documented

---
 2026 Galyarder Labs. Galyarder Framework.
