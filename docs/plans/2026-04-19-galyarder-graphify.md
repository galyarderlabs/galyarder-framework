# Mission Plan: Galyarder Graphify Integration

**Codename**: Operation Neural Link
**Status**: Initializing
**Lead**: `obsidian-architect`, `elite-developer`

## 1. Objective
Transform Galyarder Framework from a collection of static files into a **Self-Mapping Knowledge Graph**. Implement structural RAG to reduce token consumption by 70% and provide high-fidelity visual intelligence in Obsidian.


## 2. Architecture: The 4-Phase Ascension

### Phase 1: The Extraction Engine (Deterministic Core)
- **Tool**: `scripts/galyarder-graph-engine.py` (Python + NetworkX).
- **Function**: Recursively scan the repository to map:
    - **Code Links**: `calls`, `imports`, and `inherits` (Python/JS).
    - **Doc Links**: Markdown `[[wikilinks]]` and relative `(paths.md)`.
    - **Departmental Boundaries**: Auto-cluster files by Silo.

### Phase 2: The Semantic Bridge (Humans 3.0 Logic)
- **Tool**: Specialist agent `obsidian-architect`.
- **Function**: Analyze non-structural assets (READMEs, Diagrams, Transcripts).
- **Output**: Inject "INFERRED" edges into the graph (e.g., `Code Logic -> Strategic Goal`).

### Phase 3: The Obsidian Visualization (Digital HQ 2.0)
- **Output Path**: `docs/departments/Knowledge/World-Map/`.
- **Function**: Convert `graph.json` into a browsable vault of interconnected markdown files.
- **Value**: Enable native Obsidian Graph View for real-time visual strategy.

### Phase 4: The Strategic Hook (Map-First Protocol)
- **Integration**: Update "Mandatory Protocols" in every agent.
- **Rule**: Agents must read `docs/reports/KNOWLEDGE_GRAPH_SUMMARY.md` before performing any high-volume search (grep/glob).


## 3. Vertical Slices (Tracer Bullets)

- [ ] **Slice 1**: Basic graph engine that maps Markdown links in `docs/`.
- [ ] **Slice 2**: Python AST parser integration to map internal script dependencies.
- [ ] **Slice 3**: Export to Obsidian format with automatic Wikilink generation.
- [ ] **Slice 4**: Global protocol injection of lazy Neural Link lookup guidance.


## 4. Technical Guardrails

- **Language**: Python 3.10+.
- **Dependencies**: `networkx`, `matplotlib` (optional), `tree-sitter` (future expansion).
- **Hard Rule**: No external database. The Graph must be local and file-system persistent.
- **Branding**: Output artifacts must follow the "Professional Anomaly" tone.

**Mandat**: Sesuai perintah Founder ("Sikatlah gaskeun"), operasi ini resmi dimulai.
