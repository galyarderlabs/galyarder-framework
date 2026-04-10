# Design Spec: Galyarder Framework x Obsidian Integration

## 1. Objective
Integrate Obsidian as the primary visual and knowledge-base layer for the 1-Man Army workflow, complementing Linear's execution-focused task management.

## 2. Architecture
The integration uses a project-isolated structure within a centralized vault.

### 2.1 Directory Structure
- **Vault Location**: `~/Documents/Galyarder-Vault/`
- **Project Root**: `GAF - <Project Name>/`
  - `00 - Dashboard.base`: Visual HUD for project status and links.
  - `01 - Architecture.canvas`: Visual map of logic, flows, and components.
  - `02 - Knowledge Base/`: Markdown-based technical specs and design documents.
  - `03 - Activity Log.md`: Automated append-only journal of code changes and decisions.

## 3. Workflow Hooks
### 3.1 Brainstorming & Planning
- Output from `/brainstorm` is saved to `02 - Knowledge Base/`.
- Major architectural nodes are added to `01 - Architecture.canvas`.

### 3.2 Engineering
- Post-execution of high-impact changes (commits, feature completion), the framework appends a log entry to `03 - Activity Log.md`.
- Format: `### YYYY-MM-DD - <Linear-ID>: <Title>\n- Change summary\n- Impact`.

## 4. Tooling
- `obsidian-cli`: For reading/writing/appending notes.
- `json-canvas`: For generating and updating visual maps.
- `obsidian-bases`: For interactive dashboard management.

## 5. Success Criteria
- [ ] Vault initialized at `~/Documents/Galyarder-Vault`.
- [ ] Project folder created for `galyarder-framework`.
- [ ] Automated logging functionality verified.
