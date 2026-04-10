# Quick Start: Unified Platform

Get Framework + Dashboard working together in 5 minutes.

## Prerequisites

- Node.js 20+
- pnpm installed
- Framework repository cloned

## Step 1: Install Dependencies

```bash
cd /home/galyarder/projects/galyarder-framework/dashboard
pnpm install
```

## Step 2: Test Framework Adapter

```bash
cd packages/adapters/galyarder-framework
node test.js
```

Expected output:
```
🚀 Testing Galyarder Framework Adapter

📋 Test 1: Load single agent
✅ Loaded agent: galyarder-specialist
   Role: CEO / orchestrator
   Department: Executive
   Skills: brainstorming, prd-to-plan, prd-to-issues...

📋 Test 2: Load all agents
✅ Loaded 34 agents
   - galyarder-specialist (Executive)
   - product-manager (Product)
   ...

✨ All tests complete!
```

## Step 3: Start Dashboard

```bash
cd /home/galyarder/projects/galyarder-framework/dashboard
pnpm dev
```

Dashboard will start at: http://localhost:3100

## Step 4: Create Your First Company

### Via Web UI:

1. Open http://localhost:3100
2. Click "Create Company"
3. Enter goal: "Build $1M MRR SaaS in 6 months"
4. Click "Create"

### Via API:

```bash
curl -X POST http://localhost:3100/api/companies \
  -H "Content-Type: application/json" \
  -d '{
    "name": "My Startup",
    "goal": "Build $1M MRR SaaS in 6 months"
  }'
```

## Step 5: Hire Your First Agent

### Via Web UI:

1. Go to company page
2. Click "Hire Agent"
3. Select "galyarder-specialist" from Framework agents
4. Configure:
   - Runtime: Claude
   - Model: claude-sonnet-4-6
5. Click "Hire"

### Via API:

```bash
curl -X POST http://localhost:3100/api/companies/{companyId}/agents \
  -H "Content-Type: application/json" \
  -d '{
    "name": "galyarder-specialist",
    "role": "CEO",
    "adapterType": "galyarder_framework",
    "adapterConfig": {
      "agentName": "galyarder-specialist",
      "runtime": "claude",
      "model": "claude-sonnet-4-6"
    }
  }'
```

## Step 6: Assign a Task

### Via Web UI:

1. Go to company page
2. Click "Create Task"
3. Enter:
   - Title: "Create product roadmap"
   - Description: "Define Q2 2026 priorities"
   - Assign to: galyarder-specialist
4. Click "Create"

### Via API:

```bash
curl -X POST http://localhost:3100/api/companies/{companyId}/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Create product roadmap",
    "description": "Define Q2 2026 priorities",
    "assigneeId": "{agentId}"
  }'
```

## Step 7: Watch It Work

Agent will:
1. Pick up task on next heartbeat
2. Load Framework skills (brainstorming, prd-to-plan, etc.)
3. Execute via Claude
4. Report results back
5. Update task status

Monitor in dashboard UI or via API:

```bash
curl http://localhost:3100/api/companies/{companyId}/tasks/{taskId}
```

## What's Next?

### Build Your Team

Hire more agents from Framework:

- **elite-developer** - For implementation
- **security-guardian** - For security review
- **growth-strategist** - For marketing
- **fundraising-operator** - For fundraising

### Assign More Tasks

Create tasks and let agents execute:

- "Implement user authentication"
- "Create pitch deck for investors"
- "SEO audit and optimization"
- "Security vulnerability scan"

### Monitor Progress

Dashboard shows:
- Active agents
- Task status
- Skills being used
- Cost tracking (coming soon)

## Troubleshooting

### Adapter not found

Make sure you're in the dashboard directory:
```bash
cd /home/galyarder/projects/galyarder-framework/dashboard
```

### Can't load agents

Check that agents directory exists:
```bash
ls ../agents/
```

### Can't load skills

Check that skills directory exists:
```bash
ls ../skills/
```

### Dashboard won't start

Install dependencies:
```bash
pnpm install
```

## Architecture

```
You (Founder)
  ↓
Dashboard Web UI
  ↓
Dashboard API
  ↓
Framework Adapter
  ↓
Framework Agents + Skills
  ↓
Runtime (Claude/Cursor/etc.)
```

## Key Files

- `dashboard/packages/adapters/galyarder-framework/` - Adapter code
- `agents/` - Agent definitions
- `skills/` - Skill library
- `docs/ORG_CHART.md` - Organization structure
- `docs/UNIFIED_PLATFORM.md` - Integration architecture

## Support

Issues? Check:
- `docs/INTEGRATION.md` - Integration guide
- `docs/DASHBOARD_VS_FRAMEWORK.md` - Concept explanation
- `dashboard/packages/adapters/galyarder-framework/README.md` - Adapter docs

## Next Steps

1. ✅ Basic integration working
2. ⏳ Add Linear sync
3. ⏳ Add Obsidian reports
4. ⏳ Add cost tracking
5. ⏳ Add org chart visualization
6. ⏳ Add multi-company support

---

**You now have a unified platform with web UI!** 🎉

Framework provides the brains (agents + skills).
Dashboard provides the body (UI + orchestration).
Together = Complete autonomous company platform.
