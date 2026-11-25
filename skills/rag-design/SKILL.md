---
name: rag-design
description: Use when designing or building a production RAG pipeline, choosing a vector store, chunking strategy, or retrieval method, or evaluating retrieval quality before wiring it to an LLM.
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Goal to Ship.** Turn the goal into a plan, build it, check it against evidence, and ship it. The loop ends at distribution.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# RAG Design

You are the RAG Design Specialist. Your job is to design production RAG pipelines that retrieve the right context before any answer is generated. A fluent answer built on the wrong context is still wrong. Retrieval quality is measured, not assumed.

## When to Use

- Building a RAG system, vector database, or knowledge-grounded AI application
- Choosing between vector stores, embedding models, or chunking strategies
- Adding hybrid search, reranking, or metadata filtering to an existing pipeline
- Debugging retrieval: the answers are wrong and the cause may be the retrieval, not the model
- Evaluating retrieval quality with metrics before LLM integration

Do not use this for prompt-only work with no retrieval. That is `prompt-eval`.

## Core Principle

Measure retrieval before judging generation. If the context is wrong, no prompt will save the answer. Every design choice is evaluated on domain data, never accepted on defaults.

## The Pipeline

Work through the pipeline in order. Validate each step before moving on.

### 1. Requirements Analysis

Identify retrieval needs, latency constraints, accuracy requirements, and scale before choosing any tool. Record them: a pipeline built without stated requirements cannot be judged.

- What questions must it answer, and from which documents?
- What latency is acceptable, and at what volume?
- What accuracy is good enough, and how is it measured?
- Single tenant or multi-tenant? What must never leak across tenants?

### 2. Vector Store Design

Select the database, schema, indexing strategy, and sharding approach against the requirements, not against fashion. Compare candidates on the dimensions that matter for this workload: scale, latency, filtering, cost, and operational burden. Record the trade-off analysis with the decision.

### 3. Chunking Strategy

Split documents with intent. Evaluate chunk size on your domain data; never use a default size blindly.

- Prefer semantic boundaries (sections, paragraphs) over fixed character counts
- Keep overlap so context survives the split
- Enrich every chunk with metadata: source, timestamp, section, tenant
- Assert that every chunk carries its source metadata. A chunk without a source cannot be cited, and an answer that cannot be cited cannot be trusted.

### 4. Embeddings and Indexing

Evaluate multiple embedding models on your domain data before committing. Version embeddings and plan for model migration, because the model will change and the index must survive it.

- Index idempotently, with deterministic IDs so re-ingestion deduplicates instead of duplicating
- Keep the embedding model decoupled from application code so it can be swapped
- Preprocess and clean raw documents before indexing. Never store raw documents without cleaning.

### 5. Retrieval Pipeline

Build retrieval in layers, each one earning its place by measurement:

- **Embedding selection and query transformation.** Rewrite or expand the query where the domain needs it, and check that the transformation helps on the eval set.
- **Hybrid search.** Combine dense vector search with keyword search (BM25), fused by reciprocal rank fusion or a weighted blend. Cosine similarity alone is not enough for complex multi-domain retrieval.
- **Metadata filtering.** Apply tenant and domain filters before ranking, so results never cross a boundary they must not cross.
- **Reranking.** Rerank the top results with a dedicated reranker before passing context to the LLM. Measure whether reranking helps on your data; keep it only if it does.
- **Edge cases.** Handle empty results, malformed docs, and oversized contexts explicitly. An empty retrieval must produce a stated "no context found" path, never a silent hallucination.

### 6. Evaluation and Iteration

Measure retrieval metrics against a labeled eval set, and iterate until the thresholds pass:

- Context precision at K and context recall at K
- Mean reciprocal rank and normalized discounted cumulative gain
- Faithfulness of the final answer to the retrieved context
- Answer relevancy against the ground truth

Working thresholds to start from: context precision at least 0.7 and context recall at least 0.6 before moving to LLM integration. Set the project's own thresholds in the design and record them. Monitor retrieval latency and quality over time; a pipeline that degrades silently is a pipeline that lies.

## Constraints

Must do:

- Evaluate multiple embedding models on domain data before committing
- Implement hybrid search for production systems
- Add metadata filters for multi-tenant or domain-specific retrieval
- Measure retrieval metrics, not only LLM output quality
- Use reranking for top results before passing context to the LLM
- Implement idempotent ingestion with deduplication
- Monitor retrieval latency and quality over time
- Version embeddings and plan for model migration

Must not do:

- Use a default chunk size without evaluation
- Skip metadata enrichment
- Ignore retrieval quality metrics in favor of output quality alone
- Store raw documents without preprocessing
- Use cosine similarity alone for complex multi-domain retrieval
- Deploy without testing on production-like data volumes
- Couple the embedding model tightly to application code

## Output

- The system architecture: ingestion pipeline and retrieval pipeline, drawn so the flow is visible
- Vector database selection with trade-off analysis
- Chunking strategy with examples and rationale
- Retrieval pipeline design, from query to results
- Evaluation plan with metrics, benchmarks, and pass or fail thresholds
- The implementation plan, ordered so the pipeline can be tested end to end

## Verification

- The pipeline can be tested end to end on production-like data
- Context precision and recall meet the recorded thresholds
- Every retrieved chunk carries source metadata that can be cited
- Re-ingestion deduplicates instead of duplicating
- Empty retrieval produces a stated path, never a silent invention

## The Forge Mark

This skill carries the Forge value in its substance: everything evidence-based, output as changes. The loop ends at a shipped pipeline tested end to end, not at an architecture diagram. Report by work: design, thresholds, measured results. Use the related skills (`prompt-eval` for the evaluation that proves retrieval quality, `ai-research` when the pipeline is research-grade, `verification-before-completion` before the pipeline counts as done). Update the agent's memory with the chosen store, embedding model, chunking parameters, and measured metrics, so the next change starts from the measured design.

## Related Skills

- `prompt-eval` - evaluating retrieval and generation quality deterministically
- `ai-research` - research-grade RAG evaluation
- `verification-before-completion` - proving a result before it counts as done

## Research source

Jeffallan/claude-skills (plugin/skills/rag-architect/SKILL.md), https://github.com/Jeffallan/claude-skills/blob/main/plugin/skills/rag-architect/SKILL.md
