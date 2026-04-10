import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import { ensureCodexSkillsInjected } from "@paperclipai/adapter-codex-local/server";

async function makeTempDir(prefix: string): Promise<string> {
  return fs.mkdtemp(path.join(os.tmpdir(), prefix));
}

async function createGalyarderRepoSkill(root: string, skillName: string) {
  await fs.mkdir(path.join(root, "server"), { recursive: true });
  await fs.mkdir(path.join(root, "packages", "adapter-utils"), { recursive: true });
  await fs.mkdir(path.join(root, "skills", skillName), { recursive: true });
  await fs.writeFile(path.join(root, "pnpm-workspace.yaml"), "packages:\n  - packages/*\n", "utf8");
  await fs.writeFile(path.join(root, "package.json"), '{"name":"galyarder"}\n', "utf8");
  await fs.writeFile(
    path.join(root, "skills", skillName, "SKILL.md"),
    `---\nname: ${skillName}\n---\n`,
    "utf8",
  );
}

async function createCustomSkill(root: string, skillName: string) {
  await fs.mkdir(path.join(root, "custom", skillName), { recursive: true });
  await fs.writeFile(
    path.join(root, "custom", skillName, "SKILL.md"),
    `---\nname: ${skillName}\n---\n`,
    "utf8",
  );
}

describe("codex local adapter skill injection", () => {
  const galyarderKey = "galyarder/galyarder/galyarder";
  const cleanupDirs = new Set<string>();

  afterEach(async () => {
    await Promise.all(Array.from(cleanupDirs).map((dir) => fs.rm(dir, { recursive: true, force: true })));
    cleanupDirs.clear();
  });

  it("repairs a Codex Galyarder Dashboard skill symlink that still points at another live checkout", async () => {
    const currentRepo = await makeTempDir("galyarder-codex-current-");
    const oldRepo = await makeTempDir("galyarder-codex-old-");
    const skillsHome = await makeTempDir("galyarder-codex-home-");
    cleanupDirs.add(currentRepo);
    cleanupDirs.add(oldRepo);
    cleanupDirs.add(skillsHome);

    await createGalyarderRepoSkill(currentRepo, "galyarder");
    await createGalyarderRepoSkill(oldRepo, "galyarder");
    await fs.symlink(path.join(oldRepo, "skills", "galyarder"), path.join(skillsHome, "galyarder"));

    const logs: Array<{ stream: "stdout" | "stderr"; chunk: string }> = [];
    await ensureCodexSkillsInjected(
      async (stream, chunk) => {
        logs.push({ stream, chunk });
      },
      {
        skillsHome,
        skillsEntries: [{
          key: galyarderKey,
          runtimeName: "galyarder",
          source: path.join(currentRepo, "skills", "galyarder"),
        }],
      },
    );

    expect(await fs.realpath(path.join(skillsHome, "galyarder"))).toBe(
      await fs.realpath(path.join(currentRepo, "skills", "galyarder")),
    );
    expect(logs).toContainEqual(
      expect.objectContaining({
        stream: "stdout",
        chunk: expect.stringContaining('Repaired Codex skill "galyarder"'),
      }),
    );
  });

  it("preserves a custom Codex skill symlink outside Galyarder Dashboard repo checkouts", async () => {
    const currentRepo = await makeTempDir("galyarder-codex-current-");
    const customRoot = await makeTempDir("galyarder-codex-custom-");
    const skillsHome = await makeTempDir("galyarder-codex-home-");
    cleanupDirs.add(currentRepo);
    cleanupDirs.add(customRoot);
    cleanupDirs.add(skillsHome);

    await createGalyarderRepoSkill(currentRepo, "galyarder");
    await createCustomSkill(customRoot, "galyarder");
    await fs.symlink(path.join(customRoot, "custom", "galyarder"), path.join(skillsHome, "galyarder"));

    await ensureCodexSkillsInjected(async () => {}, {
      skillsHome,
      skillsEntries: [{
        key: galyarderKey,
        runtimeName: "galyarder",
        source: path.join(currentRepo, "skills", "galyarder"),
      }],
    });

    expect(await fs.realpath(path.join(skillsHome, "galyarder"))).toBe(
      await fs.realpath(path.join(customRoot, "custom", "galyarder")),
    );
  });

  it("prunes broken symlinks for unavailable Galyarder Dashboard repo skills before Codex starts", async () => {
    const currentRepo = await makeTempDir("galyarder-codex-current-");
    const oldRepo = await makeTempDir("galyarder-codex-old-");
    const skillsHome = await makeTempDir("galyarder-codex-home-");
    cleanupDirs.add(currentRepo);
    cleanupDirs.add(oldRepo);
    cleanupDirs.add(skillsHome);

    await createGalyarderRepoSkill(currentRepo, "galyarder");
    await createGalyarderRepoSkill(oldRepo, "agent-browser");
    const staleTarget = path.join(oldRepo, "skills", "agent-browser");
    await fs.symlink(staleTarget, path.join(skillsHome, "agent-browser"));
    await fs.rm(staleTarget, { recursive: true, force: true });

    const logs: Array<{ stream: "stdout" | "stderr"; chunk: string }> = [];
    await ensureCodexSkillsInjected(
      async (stream, chunk) => {
        logs.push({ stream, chunk });
      },
      {
        skillsHome,
        skillsEntries: [{
          key: galyarderKey,
          runtimeName: "galyarder",
          source: path.join(currentRepo, "skills", "galyarder"),
        }],
      },
    );

    await expect(fs.lstat(path.join(skillsHome, "agent-browser"))).rejects.toMatchObject({
      code: "ENOENT",
    });
    expect(logs).toContainEqual(
      expect.objectContaining({
        stream: "stdout",
        chunk: expect.stringContaining('Removed stale Codex skill "agent-browser"'),
      }),
    );
  });

  it("preserves other live Galyarder Dashboard skill symlinks in the shared workspace skill directory", async () => {
    const currentRepo = await makeTempDir("galyarder-codex-current-");
    const skillsHome = await makeTempDir("galyarder-codex-home-");
    cleanupDirs.add(currentRepo);
    cleanupDirs.add(skillsHome);

    await createGalyarderRepoSkill(currentRepo, "galyarder");
    await createGalyarderRepoSkill(currentRepo, "agent-browser");
    await fs.symlink(
      path.join(currentRepo, "skills", "agent-browser"),
      path.join(skillsHome, "agent-browser"),
    );

    await ensureCodexSkillsInjected(async () => {}, {
      skillsHome,
      skillsEntries: [{
        key: galyarderKey,
        runtimeName: "galyarder",
        source: path.join(currentRepo, "skills", "galyarder"),
      }],
    });

    expect((await fs.lstat(path.join(skillsHome, "galyarder"))).isSymbolicLink()).toBe(true);
    expect((await fs.lstat(path.join(skillsHome, "agent-browser"))).isSymbolicLink()).toBe(true);
    expect(await fs.realpath(path.join(skillsHome, "agent-browser"))).toBe(
      await fs.realpath(path.join(currentRepo, "skills", "agent-browser")),
    );
  });
});
