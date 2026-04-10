# Integration Plan: Framework + Dashboard = Unified Platform

## Vision

**One platform with web UI** where you can:
1. Create digital companies through web interface
2. Hire agents from Framework (galyarder-specialist, elite-developer, etc.)
3. Agents execute using Framework skills (100+ skills)
4. Monitor everything in dashboard UI
5. Agents run via adapters (Claude, Cursor, etc.)

---

## Architecture

```
┌─────────────────────────────────────────────────┐
│         DASHBOARD WEB UI (Frontend)              │
│  - Create companies                              │
│  - Hire agents                                   │
│  - Assign tasks                                  │
│  - Monitor progress                              │
│  - Control budgets                               │
└─────────────────┬───────────────────────────────┘
                  │
                  ↓
┌─────────────────────────────────────────────────┐
│      DASHBOARD API (Backend - Node.js)           │
│  - Company management                            │
│  - Agent registry                                │
│  - Task tracking                                 │
│  - Heartbeat scheduler                           │
│  - Cost tracking                                 │
└─────────────────┬───────────────────────────────┘
                  │
        ┌─────────┼─────────┐
        ↓         ↓         ↓
   ┌────────┐ ┌────────┐ ┌────────┐
   │Claude  │ │Cursor  │ │Codex   │
   │Adapter │ │Adapter │ │Adapter │
   └────┬───┘ └────┬───┘ └────┬───┘
        │          │          │
        └──────────┼──────────┘
                   ↓
        ┌──────────────────────┐
        │  FRAMEWORK LAYER      │
        │  - Agent definitions  │
        │  - Skill library      │
        │  - Orchestration      │
        └──────────────────────┘
```

---

## Implementation Steps

### Phase 1: Framework as Adapter (MVP)

#### 1.1 Create Galyarder Framework Adapter
```bash
dashboard/packages/adapters/galyarder-framework/
├── src/
│   ├── index.ts              # Adapter registration
│   ├── agent-loader.ts       # Load Framework agents
│   ├── skill-executor.ts     # Execute Framework skills
│   └── orchestrator.ts       # galyarder-specialist logic
├── package.json
└── README.md
```

**Key files:**

```typescript
// dashboard/packages/adapters/galyarder-framework/src/index.ts
export const type = "galyarder_framework";
export const label = "Galyarder Framework Agent";

export const agentConfigurationDoc = `
# galyarder_framework adapter

Runs agents using Galyarder Framework skills.

Config:
- agentName: Which Framework agent (galyarder-specialist, elite-developer, etc.)
- skills: Array of skill names this agent can use
- runtime: Underlying runtime (claude, cursor, codex)
- instructionsPath: Path to agent's .md file
`;

export async function executeHeartbeat(config, context) {
  // 1. Load agent definition from ../../agents/{agentName}.md
  // 2. Get assigned tasks from context
  // 3. Route to appropriate skills
  // 4. Execute via runtime adapter
  // 5. Return results
}
```

#### 1.2 Skill Registry
```typescript
// dashboard/packages/galyarder-skills/
// Parse all skills from ../../skills/*/SKILL.md
// Create executable registry

interface Skill {
  name: string;
  department: string;
  managedBy: string; // agent name
  execute: (context: any) => Promise<any>;
}

const skillRegistry: Map<string, Skill> = new Map();

// Auto-discover from skills directory
export async function loadSkills() {
  const skillDirs = await fs.readdir('../../skills');
  for (const dir of skillDirs) {
    const skillMd = await fs.readFile(`../../skills/${dir}/SKILL.md`);
    const skill = parseSkill(skillMd);
    skillRegistry.set(skill.name, skill);
  }
}
```

#### 1.3 Agent Template Importer
```typescript
// dashboard/server/src/services/framework-importer.ts

export async function importFrameworkAgents() {
  const agentFiles = await fs.readdir('../../agents');
  
  for (const file of agentFiles) {
    const agentMd = await fs.readFile(`../../agents/${file}`);
    const agent = parseAgent(agentMd);
    
    // Create agent template in dashboard
    await db.agentTemplates.create({
      name: agent.name,
      role: agent.role,
      department: agent.department,
      skills: agent.skills,
      adapterType: 'galyarder_framework',
      adapterConfig: {
        agentName: agent.name,
        instructionsPath: `../../agents/${file}`
      }
    });
  }
}
```

---

### Phase 2: Web UI Integration

#### 2.1 Agent Hiring Flow
```typescript
// dashboard/ui/src/pages/HireAgent.tsx

function HireAgentPage() {
  const [templates] = useAgentTemplates(); // From Framework
  
  return (
    <div>
      <h1>Hire Agent</h1>
      
      {/* Show Framework agents as templates */}
      <AgentTemplateGrid>
        {templates.map(agent => (
          <AgentCard
            name={agent.name}
            role={agent.role}
            department={agent.department}
            skills={agent.skills}
            onHire={() => hireAgent(agent)}
          />
        ))}
      </AgentTemplateGrid>
    </div>
  );
}
```

#### 2.2 Org Chart Visualization
```typescript
// dashboard/ui/src/components/OrgChart.tsx

function OrgChart({ companyId }) {
  const [agents] = useCompanyAgents(companyId);
  
  // Render tree based on reporting structure
  return (
    <div className="org-chart">
      <AgentNode agent={ceo}>
        {ceo.reports.map(agent => (
          <AgentNode agent={agent} />
        ))}
      </AgentNode>
    </div>
  );
}
```

#### 2.3 Skill Execution Monitor
```typescript
// dashboard/ui/src/components/SkillMonitor.tsx

function SkillMonitor({ agentId }) {
  const [executions] = useSkillExecutions(agentId);
  
  return (
    <div>
      <h2>Active Skills</h2>
      {executions.map(exec => (
        <SkillExecutionCard
          skill={exec.skillName}
          status={exec.status}
          progress={exec.progress}
          cost={exec.tokenCost}
        />
      ))}
    </div>
  );
}
```

---

### Phase 3: Orchestration Integration

#### 3.1 galyarder-specialist as CEO
```typescript
// When company created, auto-hire galyarder-specialist as CEO

async function createCompany(goal: string) {
  const company = await db.companies.create({ goal });
  
  // Auto-hire galyarder-specialist as CEO
  const ceo = await db.agents.create({
    companyId: company.id,
    name: "galyarder-specialist",
    role: "CEO",
    adapterType: "galyarder_framework",
    adapterConfig: {
      agentName: "galyarder-specialist",
      skills: ["brainstorming", "prd-to-plan", ...],
      runtime: "claude"
    }
  });
  
  return { company, ceo };
}
```

#### 3.2 Department-Based Task Routing
```typescript
// galyarder-specialist routes tasks to departments

async function routeTask(task: Task) {
  const department = determineDepartment(task);
  const departmentHead = await getAgentByDepartment(department);
  
  await assignTask(task, departmentHead);
  await triggerHeartbeat(departmentHead);
}
```

---

### Phase 4: External Integrations

#### 4.1 Linear Sync
```typescript
// Sync dashboard tasks ↔ Linear issues

async function syncToLinear(task: Task) {
  const issue = await linear.createIssue({
    title: task.title,
    description: task.description,
    assigneeId: mapAgentToLinearUser(task.assigneeId)
  });
  
  await db.tasks.update(task.id, { linearIssueId: issue.id });
}
```

#### 4.2 Obsidian Reports
```typescript
// Auto-generate Obsidian reports from dashboard data

async function generateDepartmentReport(department: string) {
  const agents = await getAgentsByDepartment(department);
  const tasks = await getTasksByDepartment(department);
  
  const report = renderObsidianReport({
    department,
    agents,
    tasks,
    template: '../../obsidian-templates/...'
  });
  
  await writeToObsidian(report);
}
```

---

## File Structure After Integration

```
galyarder-framework/
├── agents/                    # Agent definitions (source of truth)
├── skills/                    # Skill library (source of truth)
├── commands/                  # Command shortcuts
├── rules/                     # Design systems
├── obsidian-templates/        # Report templates
│
├── dashboard/                 # Web platform
│   ├── ui/                    # React frontend
│   ├── server/                # Node.js API
│   ├── packages/
│   │   ├── adapters/
│   │   │   ├── claude-local/
│   │   │   ├── cursor-local/
│   │   │   └── galyarder-framework/  # NEW: Framework adapter
│   │   ├── galyarder-skills/         # NEW: Skill registry
│   │   └── galyarder-agents/         # NEW: Agent loader
│   └── ...
│
└── docs/
    ├── ORG_CHART.md
    ├── INTEGRATION.md
    └── UNIFIED_PLATFORM.md   # This file
```

---

## User Experience

### Before (Separate):
```
1. Chat with Claude → Use Framework
2. Open dashboard → Manage agents manually
3. No connection between them
```

### After (Unified):
```
1. Open dashboard web UI
2. Create company: "Build $1M SaaS"
3. Click "Hire galyarder-specialist as CEO"
4. CEO auto-hires department heads from Framework
5. Assign task: "Create pitch deck"
6. fundraising-operator picks it up
7. Executes pitch-deck skill via Claude adapter
8. Monitor progress in dashboard
9. Report auto-generated to Obsidian
10. Task synced to Linear
```

---

## Benefits

### For Solo Founder:
- ✅ Visual company management (web UI)
- ✅ Pre-built agents (Framework library)
- ✅ 100+ skills ready to use
- ✅ Cost tracking and budgets
- ✅ Progress monitoring
- ✅ One unified platform

### Technical:
- ✅ Framework agents = reusable templates
- ✅ Skills = executable modules
- ✅ Dashboard = orchestration platform
- ✅ Adapters = runtime flexibility
- ✅ Clean separation of concerns

---

## Migration Path

### Step 1: Keep Both Working
- Framework continues working standalone
- Dashboard continues working independently
- No breaking changes

### Step 2: Add Framework Adapter
- Dashboard can USE Framework agents
- Optional integration
- Gradual adoption

### Step 3: Full Integration
- Dashboard becomes primary interface
- Framework becomes execution engine
- Unified experience

---

## Next Actions

### Immediate (This Week):
1. ✅ Document integration architecture (this file)
2. ⏳ Create galyarder-framework adapter skeleton
3. ⏳ Build skill registry parser
4. ⏳ Test: Hire one Framework agent in dashboard

### Short-term (This Month):
5. ⏳ Import all Framework agents as templates
6. ⏳ Implement galyarder-specialist orchestration
7. ⏳ Build org chart UI
8. ⏳ Add skill execution monitoring

### Long-term (Next Quarter):
9. ⏳ Linear integration
10. ⏳ Obsidian report automation
11. ⏳ Cost tracking per skill
12. ⏳ Multi-company management

---

## Conclusion

**YES, bisa diintegrasiin jadi satu platform dengan web UI.**

Framework provides:
- Agent definitions
- Skill library
- Orchestration logic

Dashboard provides:
- Web UI
- Database
- Monitoring
- Scheduling
- Cost tracking

Together = **Complete autonomous company platform**
