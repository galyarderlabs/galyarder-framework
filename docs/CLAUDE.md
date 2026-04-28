# Claude Code: Implementation Protocol

This guide defines the high-integrity integration of Galyarder Framework within the **Claude Code** (Anthropic) environment.

## 1. Installation

Register the Galyarder Labs marketplace and install the complete framework:

```bash
/plugin marketplace add galyarderlabs/galyarder-framework
/plugin install galyarder-framework@galyarderlabs-marketplace
```

Or install departments selectively:

```bash
/plugin install executive-dept@galyarderlabs-marketplace
/plugin install engineering-dept@galyarderlabs-marketplace
/plugin install growth-dept@galyarderlabs-marketplace
/plugin install security-dept@galyarderlabs-marketplace
/plugin install product-dept@galyarderlabs-marketplace
/plugin install infrastructure-dept@galyarderlabs-marketplace
/plugin install legal-finance-dept@galyarderlabs-marketplace
/plugin install knowledge-dept@galyarderlabs-marketplace
```

## 2. Mandatory Protocols

Every session in Claude Code is governed by the **Humans 3.0** logic gate. The agent is hardcoded to execute the following sequence:

- **RTK Shield**: All shell commands must be proxied via `rtk` (e.g., `rtk npm test`).
- **Linear Traceability**: All labor must be linked to a project-scoped ticket.
- **Thinking Loop**: Mandatory use of `sequentialthinking` before any tool call.
- **Context Truth**: Real-time documentation verification via `context7`.

## 3. Command Triggers

Claude Code supports instant mission triggers via slash commands:

| Command | Department | Mission |
| :--- | :--- | :--- |
| `/tdd` | Engineering | Strict Test-Driven Development workflow. |
| `/plan` | Product | Vertical Slice (Tracer Bullet) architecture mapping. |
| `/marketing` | Growth | CRO audit and behavioral copywriting. |
| `/cybersecurity` | Security | Advanced offensive/defensive security audit. |
| `/review` | Engineering | Principal-level code quality and security review. |

