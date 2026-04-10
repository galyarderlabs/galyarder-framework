import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { GalyarderApiClient } from "./client.js";
import { readConfigFromEnv, type GalyarderMcpConfig } from "./config.js";
import { createToolDefinitions } from "./tools.js";

export function createGalyarderMcpServer(config: GalyarderMcpConfig = readConfigFromEnv()) {
  const server = new McpServer({
    name: "galyarder",
    version: "0.1.0",
  });

  const client = new GalyarderApiClient(config);
  const tools = createToolDefinitions(client);
  for (const tool of tools) {
    server.tool(tool.name, tool.description, tool.schema.shape, tool.execute);
  }

  return {
    server,
    tools,
    client,
  };
}

export async function runServer(config: GalyarderMcpConfig = readConfigFromEnv()) {
  const { server } = createGalyarderMcpServer(config);
  const transport = new StdioServerTransport();
  await server.connect(transport);
}
