import fs from "node:fs";
import { galyarderConfigSchema, type Galyarder DashboardConfig } from "@paperclipai/shared";
import { resolveGalyarderConfigPath } from "./paths.js";

export function readConfigFile(): Galyarder DashboardConfig | null {
  const configPath = resolveGalyarderConfigPath();

  if (!fs.existsSync(configPath)) return null;

  try {
    const raw = JSON.parse(fs.readFileSync(configPath, "utf-8"));
    return galyarderConfigSchema.parse(raw);
  } catch {
    return null;
  }
}
