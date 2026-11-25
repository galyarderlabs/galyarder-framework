# DESIGN.md Entry Format

Entry format for a rule learned from a session correction:

```md
## Surfaces

- **Raised surfaces (cards, popovers, menus) use `shadow-raised`, never a solid border.**
  Why: a solid border makes a raised surface look flat and heavy; a semi-transparent shadow separates it from the background and adapts to both themes.
  <!-- 2026-11-12: "no, semi-transparent shadow, not a border" -->
```

The comment holds the date and the operator's words. When a later correction conflicts, it shows which rule is newer and what the operator actually said.

Make sure DESIGN.md gets read: if neither the agent instructions nor the project instructions point to it, propose adding this line: `Before building or changing UI, read DESIGN.md.`
