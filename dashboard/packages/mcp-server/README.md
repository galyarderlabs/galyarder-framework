# Galyarder MCP Server

Model Context Protocol server for Galyarder.

This package is a thin MCP wrapper over the existing Galyarder REST API. It does
not talk to the database directly and it does not reimplement business logic.

## Authentication

The server reads its configuration from environment variables:

- `GALYARDER_API_URL` - Galyarder base URL, for example `http://localhost:3100`
- `GALYARDER_API_KEY` - bearer token used for `/api` requests
- `GALYARDER_COMPANY_ID` - optional default company for company-scoped tools
- `GALYARDER_AGENT_ID` - optional default agent for checkout helpers
- `GALYARDER_RUN_ID` - optional run id forwarded on mutating requests

## Usage

```sh
npx -y @paperclipai/mcp-server
```

Or locally in this repo:

```sh
pnpm --filter @paperclipai/mcp-server build
node packages/mcp-server/dist/stdio.js
```

## Tool Surface

Read tools:

- `galyarderMe`
- `galyarderInboxLite`
- `galyarderListAgents`
- `galyarderGetAgent`
- `galyarderListIssues`
- `galyarderGetIssue`
- `galyarderGetHeartbeatContext`
- `galyarderListComments`
- `galyarderGetComment`
- `galyarderListIssueApprovals`
- `galyarderListDocuments`
- `galyarderGetDocument`
- `galyarderListDocumentRevisions`
- `galyarderListProjects`
- `galyarderGetProject`
- `galyarderListGoals`
- `galyarderGetGoal`
- `galyarderListApprovals`
- `galyarderGetApproval`
- `galyarderGetApprovalIssues`
- `galyarderListApprovalComments`

Write tools:

- `galyarderCreateIssue`
- `galyarderUpdateIssue`
- `galyarderCheckoutIssue`
- `galyarderReleaseIssue`
- `galyarderAddComment`
- `galyarderUpsertIssueDocument`
- `galyarderRestoreIssueDocumentRevision`
- `galyarderCreateApproval`
- `galyarderLinkIssueApproval`
- `galyarderUnlinkIssueApproval`
- `galyarderApprovalDecision`
- `galyarderAddApprovalComment`

Escape hatch:

- `galyarderApiRequest`

`galyarderApiRequest` is limited to paths under `/api` and JSON bodies. It is
meant for endpoints that do not yet have a dedicated MCP tool.
