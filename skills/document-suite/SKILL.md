---
name: document-suite
description: "Use when creating, reading, editing, or converting office documents in any format: Word (.docx), PDF, PowerPoint (.pptx), Excel (.xlsx), or a co-authored doc such as a proposal, spec, or decision doc. Each format has its own value and its own method."
---
## Forge Anything operating protocols

- **Human-directed.** You are the operator's tool, not a replacement. Public, external, financial, irreversible, or production-sensitive actions need the operator's approval.
- **Ideas to Give Back.** Turn ideas into a goal, build it, check it against evidence, ship it, earn from it, and give back. The flow closes at give back, and the next cycle starts at Ideas.
- **Tests before fixes.** Write the failing test first, then the fix. A test that never failed proves nothing.
- **Evidence before completion.** A claim counts only with proof you can check: tests, builds, logs, screenshots, workflow runs, or citations.
- **Smallest viable path.** Do the minimum that meets the goal. No speculative architecture.
- **Durable handoff.** Useful work leaves a readable artifact: a report, a release note, a decision, a PR, an issue, a doc, or a reusable skill.

---

# Document Suite

You are the document specialist. Your job is to produce office documents that open cleanly in their native application, in the format the operator asked for, with the content the operator approved. A document is not done when the file is written. It is done when it opens in its real application and reads the way it should.

This skill covers five formats. Each format has a different value, so each gets a different method. Do not force one format's method onto another.

## When to Use

- The operator asks for a Word document, a PDF, a slide deck, or a spreadsheet
- The operator asks to read, edit, convert, merge, split, or fix an existing office file
- The operator asks to co-author a proposal, spec, decision doc, or RFC
- The operator names a file by extension: .docx, .dotx, .pdf, .pptx, .potx, .xlsx, .xlsm, .csv

Do not use this for Google Docs or Google Sheets work, or for a plain text or Markdown deliverable. Those are different tools with different methods.

## Pick the Format Method First

A .docx, .pdf, .pptx, and .xlsx are all ZIP archives of XML or structured data underneath. The method follows the task, not the file alone.

| Task | Approach |
|---|---|
| Create a new document | Build it with the format library, never by hand-editing XML |
| Edit an existing document | Unpack, edit the inner XML, re-zip, and verify it still opens |
| Read content | Extract to Markdown first, then work from the Markdown |
| Convert between formats | Extract the content, then rebuild it in the target format |

## Word Documents (.docx)

Create with the `docx` npm package. Read with `pandoc -t markdown file.docx`.

Gotchas that decide whether the file opens cleanly:

- Page size defaults to A4. For US Letter, set the page size explicitly (12240 by 15840 DXA, where 1440 DXA is one inch).
- Tables need dual widths: set column widths on the table and width on every cell, both in DXA. Percentage widths break in Google Docs. Column widths must sum to the table width.
- Table shading uses `ShadingType.CLEAR`, never `SOLID`, which renders black.
- Lists use a numbering config with `LevelFormat.BULLET`. Never insert a bullet character literally.
- Never use `\n` inside a paragraph. Use separate `Paragraph` elements.
- `ImageRun` requires an explicit image type (`png`, `jpg`, and so on).
- `PageBreak` must sit inside a `Paragraph`.
- Style every heading level you use in `styles.default` before using it.

Editing an existing .docx: unpack the ZIP, edit `word/document.xml`, re-zip. The `docx` package cannot open existing files, so do not try.

## PDF Files

Use Python: `pypdf` for basic operations, `pdfplumber` for text and tables with layout.

- Merge: one `PdfWriter`, add every page from every reader, write once.
- Split: one `PdfWriter` per page, write each to its own file.
- Rotate: rotate the page object, then add it to a writer.
- Extract metadata: title, author, subject, creator, from the reader metadata.
- Extract tables: `pdfplumber` table extraction, checked page by page. A table that extracts wrong is a table to fix by hand, not to ship.
- Scanned PDFs: OCR them so the text becomes searchable before you call the content extracted.
- Fill a form only after reading the form field structure. Never guess field names.

## Slide Decks (.pptx)

Create with `pptxgenjs`, built as a structured deck unless the operator asks for a quick throwaway. Read with a slide-text extractor that reports one block per slide plus speaker notes, and a thumbnail grid for picking template layouts.

- Build from a template (.potx) when the operator has one. Match its layouts instead of inventing new ones.
- Edit an existing deck by unpacking, editing `ppt/slides/slideN.xml`, and re-zipping. Keep the slide ID list consistent, then clean unreferenced slides, media, and relationships.
- Every slide carries its title, text, tables, chart data, picture alt text, and speaker notes. Check all of them when you read a deck, not just the visible text.
- Apply a theme with `theme-factory` so the deck matches the rest of the operator's output.

## Spreadsheets (.xlsx)

Use `openpyxl` for create and edit with formulas and formatting, `pandas` for bulk data in and out, and `markitdown` for a quick look at a sheet.

Rules for every spreadsheet output:

- Professional font (Arial or Times New Roman) throughout, unless the operator says otherwise.
- Zero formula errors. Never ship while a recalculation check reports errors. If you think an error predates you, prove it by loading the original file and looking at that cell.
- Use formulas, never hardcoded results. Write `=SUM(B2:B9)`, not the Python-computed total. The sheet must recalculate when its inputs change.
- Follow the operator's spec literally: exact tab names, exact column headers, exact formulas.
- Read a model with two passes: one for formulas, one for values. A single pass hides either the logic or the result.

## Co-Authoring a Document

Some documents are not format work. They are thinking work: a proposal, a technical spec, a decision doc, an RFC. For those, run the three-stage co-authoring workflow.

### Stage 1: Context gathering

Ask for the meta-context before writing anything: document type, primary audience, desired impact on the reader, any template or format constraint, and any other context. Let the operator answer in shorthand or dump information however works. The goal is to close the gap between what the operator knows and what you know, so later guidance is smart instead of generic.

### Stage 2: Refinement and structure

Build the document section by section, iterating with the operator. Brainstorm structure first, then draft, then tighten. Each section gets written, read back, and corrected before moving on.

### Stage 3: Reader testing

Test the doc with a fresh reader who has no context: a fresh agent session, or the operator reading it cold. The test catches blind spots, missing context, and claims that only make sense to the author. Fix what the test finds before the doc ships.

If the operator declines the structured workflow, work freeform. The workflow is an offer, not a gate.

## Output

- The document file itself, in the format asked for, openable in its native application
- For co-authored docs: the finished doc plus the list of open questions the reader test surfaced, resolved or explicitly deferred

## Verification

- Every document is opened in its native application and checked: layout, fonts, tables, images, page breaks
- Every spreadsheet passes a recalculation check with zero formula errors
- Every PDF extraction is spot-checked against the original pages
- Every co-authored doc passes a reader test with no context before it ships
- A document that fails any of these is not shipped. Fix it, then verify again.

## The Forge Mark

This skill carries the Forge value in its substance: no AI slop, flow goal to shipped, everything evidence-based, output as changes. A document is a change: a file committed, a PR opened, or a dept note filed, not a draft left in chat. Report by work: documents produced, format checks passed, reader tests run. Use the related skills (`theme-factory` for consistent styling, `doc-maintenance` for keeping docs current, `verification-before-completion` before any doc counts as done). Update the agent's memory with the templates, formats, and gotchas that worked so the next document starts further ahead.

## Related Skills

- `theme-factory` - consistent visual theme across decks, docs, and reports
- `doc-maintenance` - keeping existing documents current and correct
- `verification-before-completion` - proving a document before it counts as done
- `writing-skills` - writing quality for the words inside the document

## Research source

Anthropic document skills, https://github.com/anthropics/skills/tree/main/skills (docx, pdf, pptx, xlsx, doc-coauthoring)
