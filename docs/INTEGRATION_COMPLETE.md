# Integration Checklist: Galyarder Triad Complete

This checklist defines the "Apex State" for a project. A project is only considered **Integration Complete** when it is fully wired into the Galyarder Triad: **Agent (Presence)**, **Framework (Intelligence)**, and **HQ (Governance)**.

---

## Phase 1: Presence Layer (Galyarder Agent)
*Ensuring the Entity can speak and act within the project environment.*

- [ ] **Runtime Connectivity**: `g-agent status` returns `operational` and all configured channels (WhatsApp/Telegram) are live.
- [ ] **Memory Initialization**: `MEMORY.md` and `PROJECTS.md` are initialized in the Agent's workspace.
- [ ] **Channel Auth**: WhatsApp/Telegram pairings are verified and restricted via `allowFrom` policy.
- [ ] **Proactive Pulse**: Proactive jobs (e.g., daily_brief) are enabled for the project directory.

---

## Phase 2: Intelligence Layer (Galyarder Framework)
*Injecting high-integrity logic and protocols into the local environment.*

- [ ] **Digital HQ Initialization**: `galyarder scaffold` has been executed in the project root.
- [ ] **Protocol Injection**: Every agent/skill file contains the mandatory **Humans 3.0** header (Karpathy, TDD Oracle, Modes).
- [ ] **Local CLI Link**: `galyarder deploy` is available in the system PATH and points to the correct source repo.
- [ ] **Asset Transformation**: 200+ assets have been successfully converted for the specific host (e.g., `.mdc` for Cursor or native skill bundles for CLI agents).
- [ ] **Smoke Test Verified**: `galyarder smoke` returns a full Green state for the project.

---

## Phase 3: Governance Layer (Galyarder HQ)
*Connecting the project to the central command plane.*

- [ ] **Project Discovery**: Galyarder HQ dashboard has successfully indexed the project directory.
- [ ] **Linear Synchronization**: Dashboard correctly visualizes the project's Linear tickets and milestone progress.
- [ ] **Obsidian Loop**: Departmental reports in `docs/departments/` are readable and indexed by the HQ search engine.
- [ ] **Audit Trail**: Every mission execution result (TDD logs, security scans) is visible in the HQ activity feed.

---

## Phase 4: Engineering Integrity (Audit-Grade)
*Proving the quality of the implementation.*

- [ ] **Gating Ladder**: All code passes the `Unit -> Contract -> E2E` sequence.
- [ ] **Test Oracle Proof**: No "Green" tests exist that haven't been empirically proven to fail via mutation/negative control.
- [ ] **Context Versioning**: Every task fetch via `context7` includes explicit library version metadata.
- [ ] **Zero Waste**: No orphaned code, non-ASCII slop, or speculative abstractions are present.

---

## Certification Status

| Metric | Status |
| :--- | :--- |
| **Triad Alignment** | [Pending/Verified] |
| **Protocol Adherence** | [Institutional Grade] |
| **Sovereignty Level** | [Total/Self-Hosted] |

**Authorized by:** `galyarder-ceo`  
**Verified by:** `galyarder-specialist`

---
