# Legacy Purge: Removing Galyarder Branding

> **For agentic workers:** REQUIRED SUB-SKILL: Use galyarder-framework:subagent-driven-development (recommended) or galyarder-framework:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace all legacy '@galyarder' and lowercase 'galyarder' branding with '@galyarder' and 'galyarder' respectively across the repository.

**Architecture:** A systematic find-and-replace operation targeting documentation, manifests, and skill files. Real code dependencies are checked but assumed to be internal to the project or already updated.

**Tech Stack:** `sed`, `grep`, `rtk` (for token economy).

---

### Task 1: Replace '@galyarder' scope with '@galyarder'

**Files:**
- Modify: All files containing '@galyarder'

- [ ] **Step 1: Identify all files containing '@galyarder'**

Run: `grep -r "@galyarder" . --exclude-dir=.git`
Expected: List of files (mostly .md and integration rules)

- [ ] **Step 2: Replace '@galyarder' with '@galyarder' using sed**

Run: `grep -rl "@galyarder" . --exclude-dir=.git | xargs sed -i 's/@galyarder/@galyarder/g'`
Expected: All occurrences updated.

- [ ] **Step 3: Verify the replacement**

Run: `grep -r "@galyarder" . --exclude-dir=.git`
Expected: No matches found.

- [ ] **Step 4: Commit**

```bash
git add .
git commit -m "refactor: replace @galyarder with @galyarder scope"
```

---

### Task 2: Replace lowercase 'galyarder' with 'galyarder' in branding contexts

**Files:**
- Modify: All files containing lowercase 'galyarder' where it refers to branding.

- [ ] **Step 1: Identify all files containing 'galyarder' (lowercase)**

Run: `grep -r "galyarder" . --exclude-dir=.git`
Expected: List of files.

- [ ] **Step 2: Filter and replace 'galyarder' with 'galyarder'**

*Note: Be careful with potential real dependencies if any.*

Run: `grep -rl "galyarder" . --exclude-dir=.git | xargs sed -i 's/galyarder/galyarder/g'`
Expected: Branding references updated.

- [ ] **Step 3: Verify the replacement**

Run: `grep -r "galyarder" . --exclude-dir=.git`
Expected: No matches found (except perhaps ignored files).

- [ ] **Step 4: Commit**

```bash
git add .
git commit -m "refactor: replace lowercase galyarder branding with galyarder"
```

---

### Task 3: Replace 'Galyarder' (Capitalized) with 'Galyarder'

**Files:**
- Modify: All files containing 'Galyarder' (capitalized)

- [ ] **Step 1: Identify and replace 'Galyarder' with 'Galyarder'**

Run: `grep -rl "Galyarder" . --exclude-dir=.git | xargs sed -i 's/Galyarder/Galyarder/g'`
Expected: Capitalized branding updated.

- [ ] **Step 2: Verify the replacement**

Run: `grep -r "Galyarder" . --exclude-dir=.git`
Expected: No matches found.

- [ ] **Step 3: Commit**

```bash
git add .
git commit -m "refactor: replace capitalized Galyarder with Galyarder"
```
