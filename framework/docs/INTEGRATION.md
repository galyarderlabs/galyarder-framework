# Galyarder Framework - Integration Guide

## Overview

Galyarder Framework is a **standalone digital company** that operates through AI assistants. It does NOT require the dashboard to function.

---

## Core Integration Points

### 1. AI Assistant (Required)
**Purpose:** Execution runtime for agents and skills

**Supported Platforms:**
- Claude Code
- Cursor
- Gemini CLI
- Codex
- Any MCP-compatible assistant

**How it works:**
```
1. Founder chats with AI assistant
2. AI assistant loads Galyarder Framework
3. galyarder-specialist routes work to departments
4. Department agents execute via skills
5. Results synthesized back to founder
```

**Installation:**
See README.md for platform-specific installation

---

### 2. Linear (Recommended)
**Purpose:** Task system of record

**What gets tracked:**
- Initiatives (roadmap objectives)
- Projects (deliverables)
- Issues (units of work)
- Agent assignments
- Status transitions

**Integration:**
```bash
# Install Linear MCP server
npm install -g @linear/mcp-server

# Configure in AI assistant
# Add to MCP settings
```

**Workflow:**
```
1. product-manager creates PRD
2. prd-to-issues skill creates Linear tickets
3. Agents assigned to tickets
4. Status updated as work progresses
5. Founder monitors in Linear
```

---

### 3. Obsidian (Recommended)
**Purpose:** Strategic memory and founder reports

**What gets stored:**
- Architecture decisions
- Progress summaries
- Department reports
- Knowledge base
- Visual maps (Canvas)

**Setup:**
```bash
# 1. Create Obsidian vault
mkdir ~/galyarder-vault
cd ~/galyarder-vault

# 2. Copy templates
cp -r /path/to/galyarder-framework/obsidian-templates/Galyarder.Framework/* .

# 3. Initialize structure
mkdir -p {Projects,Departments,Reports,Decisions}
```

**Workflow:**
```
1. obsidian-architect maintains vault
2. Department agents write reports
3. Decisions logged automatically
4. Founder reviews in Obsidian
```

---

## Optional Integrations

### 4. RTK (Token Optimization)
**Purpose:** Save 60-90% tokens on shell commands

```bash
# Install RTK
cargo install rtk

# Use in all shell operations
rtk npm test
rtk git status
```

### 5. Stitch (UI Generation)
**Purpose:** Rapid UI component generation

**Used by:** `ui-ux-designer`

### 6. BrowserOS (E2E Testing)
**Purpose:** Automated browser testing

**Used by:** `qa-automation-engineer`, `e2e-runner`

### 7. PostHog (Analytics)
**Purpose:** Product analytics and event tracking

**Used by:** `analytics-architect`

---

## Dashboard Integration (Optional, Future)

### Current Status
**Dashboard is a SEPARATE project** for managing multiple agent companies.

### If You Want Dashboard Integration

**Option A: Monitoring Only**
```
Framework runs standalone
  ↓
Reports metrics to Dashboard API (optional)
  ↓
Dashboard visualizes activity
```

**Option B: Full Orchestration**
```
Dashboard manages multiple Framework instances
  ↓
Each instance = separate company
  ↓
Founder manages all from Dashboard UI
```

### Implementation (Not Yet Built)
```typescript
// Future: Framework → Dashboard reporting
interface DashboardReporter {
  reportTaskStart(taskId: string, agentId: string): void;
  reportTaskComplete(taskId: string, result: any): void;
  reportCost(agentId: string, tokens: number): void;
}

// Framework would optionally call these
// But works fine without them
```

---

## Recommended Setup for Solo Founder

### Minimal (Works Today)
```
1. Install Framework in Claude Code/Cursor
2. Chat with galyarder-specialist
3. Work gets done
```

### Optimal (Full Leverage)
```
1. Install Framework in AI assistant
2. Setup Linear for task tracking
3. Setup Obsidian for memory/reports
4. Install RTK for token savings
5. Configure MCP servers (Linear, Stitch, etc.)
```

### With Dashboard (Future)
```
1. All of the above
2. Run Dashboard server
3. Framework reports to Dashboard
4. Monitor multiple companies from Dashboard UI
```

---

## Integration Architecture

```
┌─────────────────────────────────────────────────┐
│                    FOUNDER                       │
└─────────────────┬───────────────────────────────┘
                  │
                  ↓
┌─────────────────────────────────────────────────┐
│           AI ASSISTANT (Runtime)                 │
│  ┌───────────────────────────────────────────┐  │
│  │      GALYARDER FRAMEWORK                  │  │
│  │  ┌─────────────────────────────────────┐ │  │
│  │  │    galyarder-specialist (CEO)       │ │  │
│  │  └──────────────┬──────────────────────┘ │  │
│  │                 │                         │  │
│  │    ┌────────────┼────────────┐           │  │
│  │    ↓            ↓            ↓           │  │
│  │  [Product]  [Engineering]  [Growth]      │  │
│  │  [Security] [Legal]  [Ops]  [Knowledge]  │  │
│  │                                           │  │
│  └───────────────────────────────────────────┘  │
└─────────────────┬───────────────────────────────┘
                  │
        ┌─────────┼─────────┐
        ↓         ↓         ↓
    ┌──────┐  ┌──────┐  ┌──────────┐
    │Linear│  │Obsidian│ │Dashboard │
    │(Tasks)│ │(Memory)│ │(Optional)│
    └──────┘  └──────┘  └──────────┘
```

---

## Key Principle

**Framework is self-contained.**
- Linear = nice to have
- Obsidian = nice to have
- Dashboard = optional future enhancement

**Core value is in the agents + skills + orchestration.**

The framework works through conversation with AI assistant. Everything else is enhancement.

---

## Next Steps

1. **Today:** Use Framework standalone in Claude/Cursor
2. **This Week:** Add Linear for task tracking
3. **This Month:** Add Obsidian for reports
4. **Future:** Consider Dashboard for multi-company management

---

## Questions?

**"Do I need the dashboard?"**
No. Framework works standalone.

**"How do agents execute?"**
Through AI assistant (Claude/Cursor/etc). You chat, they execute.

**"Where do tasks live?"**
Optionally in Linear. Or just in conversation.

**"Where do reports go?"**
Optionally in Obsidian. Or just in conversation.

**"Can I use dashboard later?"**
Yes, but it's a separate project. Not required.
