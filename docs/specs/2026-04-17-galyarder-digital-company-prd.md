# PRD: Galyarder Framework Digital Enterprise (Hierarchy & Reporting Chain)

**Status:** Draft / Blueprinting
**Issue:** GAL-36
**Author:** Galyarder Framework Specialist
**Date:** 2026-04-17

## 1. Executive Summary

Transform the Galyarder Framework from a flat collection of AI tools into a structured, hierarchical **Digital Enterprise**. This system enables a Solo Founder to operate through a C-Suite executive layer that delegates tasks to specialized agents, who then execute via skills and report back through a persistent knowledge base (Obsidian).

## 2. Problem Statement

1. **Fragmentation**: Agents and skills operate in isolation without a centralized reporting structure.
2. **Lack of Hierarchy**: The Founder must manually manage individual agents instead of delegating to a C-Suite layer.
3. **Transient Memory**: Results of agent tasks are often lost in the chat history rather than being recorded in a durable corporate repository.
4. **Context Leakage**: Operations frequently drift outside of project boundaries due to a lack of scoped "Digital Headquarters" infrastructure.

## 3. Goals & Success Criteria

### Goals:
- Establish a **Chain of Command**: Founder -> Persona (C-Suite) -> Agent -> Skill.
- Implement **Durable Reporting**: Every task MUST result in a written report in a department-specific folder.
- Automate **Company Scaffolding**: Standardize the folder structure for any new project using the framework.

### Success Criteria:
- C-Suite Personas (CEO, CTO, etc.) can correctly delegate tasks and summarize results from departmental reports.
- Agents automatically save outputs to the correct `docs/specs/` or `docs/reports/` paths.
- Linear operations are strictly scoped to the project identified by the C-Suite layer.

## 4. Proposed Architecture

### 4.1 Organizational Hierarchy
1. **Founder (Human)**: Sets vision, defines goals, approves major pivots.
2. **Executive Layer (Personas)**:
   - **CEO**: Master Orchestrator, Founder's proxy, owns overall company direction.
   - **CTO**: Engineering, Security, and Architecture head.
   - **CMO**: Growth, Marketing, and Sales lead.
   - **CFO/COO**: Finance, Operations, and Compliance head.
3. **Operational Layer (Agents)**: Specialized workers like `elite-developer`, `growth-strategist`, etc.
4. **Execution Layer (Skills)**: Tactical tools like `brainstorming`, `tdd-guide`, `refactor-cleaner`.

### 4.2 Infrastructure (The "Office")
The framework will scaffold a standard directory structure:
```text
docs/
 specs/ (Central repository for all design/plans)
 departments/
     Executive/ (Company context, Founder memos)
     Product/ (PRDs, Roadmaps)
     Engineering/ (Architecture, TDD logs, Security audits)
     Growth/ (Marketing plans, SEO reports, Sales copy)
     Legal-Finance/ (TOS, Compliance, Cost reports)
```

## 5. Functional Requirements

### 5.1 Reporting Protocol (Mandatory for ALL agents)
Every agent/skill must include a mandate:
- *"Upon task completion, write a concise report to the relevant department folder in `docs/departments/`."*
- *"Notify the respective C-Suite persona that the report is available."*

### 5.2 Company Scaffolder
A script (`scripts/scaffold-company.sh`) to initialize the directory structure and register the project in Linear automatically.

### 5.3 Karpathy Integration
All reports must follow the "Think Before Coding" and "Goal-Driven Execution" principles, explicitly stating assumptions and verification steps.

 2026 Galyarder Labs. Galyarder Framework.
