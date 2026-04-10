import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import {
  listCodexSkills,
  syncCodexSkills,
} from "@paperclipai/adapter-codex-local/server";

async function makeTempDir(prefix: string): Promise<string> {
  return fs.mkdtemp(path.join(os.tmpdir(), prefix));
}

describe("codex local skill sync", () => {
  const galyarderKey = "galyarder/galyarder/galyarder";
  const cleanupDirs = new Set<string>();

  afterEach(async () => {
    await Promise.all(Array.from(cleanupDirs).map((dir) => fs.rm(dir, { recursive: true, force: true })));
    cleanupDirs.clear();
  });

  it("reports configured Galyarder Dashboard skills for workspace injection on the next run", async () => {
    const codexHome = await makeTempDir("galyarder-codex-skill-sync-");
    cleanupDirs.add(codexHome);

    const ctx = {
      agentId: "agent-1",
      companyId: "company-1",
      adapterType: "codex_local",
      config: {
        env: {
          CODEX_HOME: codexHome,
        },
        galyarderSkillSync: {
          desiredSkills: [galyarderKey],
        },
      },
    } as const;

    const before = await listCodexSkills(ctx);
    expect(before.mode).toBe("ephemeral");
    expect(before.desiredSkills).toContain(galyarderKey);
    expect(before.entries.find((entry) => entry.key === galyarderKey)?.required).toBe(true);
    expect(before.entries.find((entry) => entry.key === galyarderKey)?.state).toBe("configured");
    expect(before.entries.find((entry) => entry.key === galyarderKey)?.detail).toContain("CODEX_HOME/skills/");
  });

  it("does not persist Galyarder Dashboard skills into CODEX_HOME during sync", async () => {
    const codexHome = await makeTempDir("galyarder-codex-skill-prune-");
    cleanupDirs.add(codexHome);

    const configuredCtx = {
      agentId: "agent-2",
      companyId: "company-1",
      adapterType: "codex_local",
      config: {
        env: {
          CODEX_HOME: codexHome,
        },
        galyarderSkillSync: {
          desiredSkills: [galyarderKey],
        },
      },
    } as const;

    const after = await syncCodexSkills(configuredCtx, [galyarderKey]);
    expect(after.mode).toBe("ephemeral");
    expect(after.entries.find((entry) => entry.key === galyarderKey)?.state).toBe("configured");
    await expect(fs.lstat(path.join(codexHome, "skills", "galyarder"))).rejects.toMatchObject({
      code: "ENOENT",
    });
  });

  it("keeps required bundled Galyarder Dashboard skills configured even when the desired set is emptied", async () => {
    const codexHome = await makeTempDir("galyarder-codex-skill-required-");
    cleanupDirs.add(codexHome);

    const configuredCtx = {
      agentId: "agent-2",
      companyId: "company-1",
      adapterType: "codex_local",
      config: {
        env: {
          CODEX_HOME: codexHome,
        },
        galyarderSkillSync: {
          desiredSkills: [],
        },
      },
    } as const;

    const after = await syncCodexSkills(configuredCtx, []);
    expect(after.desiredSkills).toContain(galyarderKey);
    expect(after.entries.find((entry) => entry.key === galyarderKey)?.state).toBe("configured");
  });

  it("normalizes legacy flat Galyarder Dashboard skill refs before reporting configured state", async () => {
    const codexHome = await makeTempDir("galyarder-codex-legacy-skill-sync-");
    cleanupDirs.add(codexHome);

    const snapshot = await listCodexSkills({
      agentId: "agent-3",
      companyId: "company-1",
      adapterType: "codex_local",
      config: {
        env: {
          CODEX_HOME: codexHome,
        },
        galyarderSkillSync: {
          desiredSkills: ["galyarder"],
        },
      },
    });

    expect(snapshot.warnings).toEqual([]);
    expect(snapshot.desiredSkills).toContain(galyarderKey);
    expect(snapshot.desiredSkills).not.toContain("galyarder");
    expect(snapshot.entries.find((entry) => entry.key === galyarderKey)?.state).toBe("configured");
    expect(snapshot.entries.find((entry) => entry.key === "galyarder")).toBeUndefined();
  });
});
