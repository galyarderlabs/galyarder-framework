# Galyarder Framework Adapter

Adapter that enables Dashboard to execute Galyarder Framework agents and skills.

## Purpose

Bridges the gap between:
- **Dashboard**: Web UI, orchestration, monitoring, database
- **Framework**: Agent definitions, skill library, execution logic

## How It Works

```
Dashboard
  ↓
  Assigns task to agent
  ↓
Framework Adapter
  ↓
  Loads agent definition (../../agents/)
  Loads required skills (../../skills/)
  ↓
Runtime Adapter (Claude/Cursor/etc.)
  ↓
  Executes with Framework context
  ↓
Returns result to Dashboard
```

## Installation

```bash
cd dashboard
pnpm install
```

The adapter is automatically registered when Dashboard starts.

## Usage

### 1. Create Company in Dashboard

```typescript
const company = await dashboard.createCompany({
  goal: "Build $1M MRR SaaS in 6 months"
});
```

### 2. Hire Framework Agent

```typescript
const ceo = await dashboard.hireAgent({
  companyId: company.id,
  name: "galyarder-specialist",
  role: "CEO",
  adapterType: "galyarder_framework",
  adapterConfig: {
    agentName: "galyarder-specialist",
    runtime: "claude",
    model: "claude-sonnet-4-6",
    skills: ["brainstorming", "prd-to-plan"],
    workingDirectory: "/workspace"
  }
});
```

### 3. Assign Task

```typescript
const task = await dashboard.createTask({
  companyId: company.id,
  assigneeId: ceo.id,
  title: "Create product roadmap",
  description: "Define Q2 2026 product priorities"
});
```

### 4. Agent Executes

Agent automatically:
1. Picks up task on heartbeat
2. Loads Framework skills
3. Executes via Claude/Cursor
4. Reports results back
5. Updates task status

## Configuration

### Agent Config Schema

```typescript
{
  agentName: string;        // Required: Framework agent name
  runtime: string;          // Required: "claude" | "cursor" | "codex" | "gemini"
  skills?: string[];        // Optional: Specific skills (defaults to all for department)
  department?: string;      // Optional: Department name
  instructionsPath?: string; // Optional: Path to agent .md file
  workingDirectory?: string; // Optional: Working directory
  model?: string;           // Optional: LLM model
  maxTurns?: number;        // Optional: Max conversation turns
  timeoutSec?: number;      // Optional: Timeout in seconds
}
```

### Available Agents

See `../../agents/` for full list. Key agents:

- **galyarder-specialist** - CEO/Orchestrator
- **elite-developer** - Senior engineer
- **security-guardian** - Security lead
- **growth-strategist** - Growth lead
- **fundraising-operator** - Fundraising lead

### Available Skills

See `../../skills/` for full list (100+ skills).

## Development

### Project Structure

```
galyarder-framework/
├── agents/                    # Agent definitions (Framework)
├── skills/                    # Skill library (Framework)
└── dashboard/
    └── packages/
        └── adapters/
            └── galyarder-framework/
                ├── src/
                │   ├── index.ts           # Main adapter
                │   ├── agent-loader.ts    # Load agent definitions
                │   ├── skill-executor.ts  # Execute skills
                │   └── orchestrator.ts    # Orchestration logic
                ├── package.json
                └── README.md              # This file
```

### TODO

- [ ] Implement agent-loader.ts (parse agent .md files)
- [ ] Implement skill-executor.ts (execute skills via runtime)
- [ ] Implement orchestrator.ts (galyarder-specialist routing)
- [ ] Add skill registry (map skill names to executables)
- [ ] Add department-based routing
- [ ] Add cost tracking per skill
- [ ] Add Linear integration
- [ ] Add Obsidian report generation

## Testing

```bash
# Run adapter tests
pnpm test

# Test with real agent
pnpm test:integration
```

## Examples

### Example 1: Hire CEO

```typescript
const ceo = await dashboard.hireAgent({
  companyId: "company-123",
  adapterType: "galyarder_framework",
  adapterConfig: {
    agentName: "galyarder-specialist",
    runtime: "claude",
    model: "claude-sonnet-4-6"
  }
});
```

### Example 2: Hire Engineering Team

```typescript
// Hire CTO
const cto = await dashboard.hireAgent({
  companyId: "company-123",
  reportsTo: ceo.id,
  adapterType: "galyarder_framework",
  adapterConfig: {
    agentName: "super-architect",
    runtime: "claude",
    department: "Engineering"
  }
});

// Hire developers under CTO
const dev1 = await dashboard.hireAgent({
  companyId: "company-123",
  reportsTo: cto.id,
  adapterType: "galyarder_framework",
  adapterConfig: {
    agentName: "elite-developer",
    runtime: "cursor",
    skills: ["test-driven-development", "systematic-debugging"]
  }
});
```

### Example 3: Execute Task

```typescript
// Create task
const task = await dashboard.createTask({
  companyId: "company-123",
  assigneeId: dev1.id,
  title: "Implement user authentication",
  description: "Add JWT-based auth with refresh tokens"
});

// Agent picks up on heartbeat and executes
// Uses Framework skills: test-driven-development, code-reviewer, etc.
// Reports progress back to Dashboard
```

## Integration with Framework

### Agent Definitions

Adapter loads agent definitions from `../../agents/*.md`:

```markdown
# elite-developer

**Mission:** Principal Full-Stack Engineer...

**Core Responsibilities:**
- TDD enforcement
- Complex debugging
- ...

**Skills:**
- test-driven-development
- systematic-debugging
- ...
```

### Skill Execution

Adapter loads skills from `../../skills/*/SKILL.md` and executes them via runtime adapter.

### Workflow Enforcement

Adapter enforces Framework's 5-phase workflow:
1. Market Intelligence & Discovery
2. Architecture & Blueprinting
3. Execution & Testing
4. Integration, CI/CD, & QA
5. Marketing, Video, & Conversion

## Benefits

### For Dashboard:
- ✅ Pre-built agent library (34 agents)
- ✅ 100+ executable skills
- ✅ Proven workflow orchestration
- ✅ Department structure
- ✅ Skill-based execution

### For Framework:
- ✅ Web UI for management
- ✅ Database for persistence
- ✅ Cost tracking
- ✅ Multi-company support
- ✅ Monitoring and analytics

### For Users:
- ✅ Visual company management
- ✅ Ready-to-use agents
- ✅ Proven execution patterns
- ✅ Unified platform
- ✅ Best of both worlds

## License

MIT
