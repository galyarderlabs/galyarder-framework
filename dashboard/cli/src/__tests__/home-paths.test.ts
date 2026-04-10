import os from "node:os";
import path from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import {
  describeLocalInstancePaths,
  expandHomePrefix,
  resolveGalyarderHomeDir,
  resolveGalyarderInstanceId,
} from "../config/home.js";

const ORIGINAL_ENV = { ...process.env };

describe("home path resolution", () => {
  afterEach(() => {
    process.env = { ...ORIGINAL_ENV };
  });

  it("defaults to ~/.galyarder and default instance", () => {
    delete process.env.GALYARDER_HOME;
    delete process.env.GALYARDER_INSTANCE_ID;

    const paths = describeLocalInstancePaths();
    expect(paths.homeDir).toBe(path.resolve(os.homedir(), ".galyarder"));
    expect(paths.instanceId).toBe("default");
    expect(paths.configPath).toBe(path.resolve(os.homedir(), ".galyarder", "instances", "default", "config.json"));
  });

  it("supports GALYARDER_HOME and explicit instance ids", () => {
    process.env.GALYARDER_HOME = "~/galyarder-home";

    const home = resolveGalyarderHomeDir();
    expect(home).toBe(path.resolve(os.homedir(), "galyarder-home"));
    expect(resolveGalyarderInstanceId("dev_1")).toBe("dev_1");
  });

  it("rejects invalid instance ids", () => {
    expect(() => resolveGalyarderInstanceId("bad/id")).toThrow(/Invalid instance id/);
  });

  it("expands ~ prefixes", () => {
    expect(expandHomePrefix("~")).toBe(os.homedir());
    expect(expandHomePrefix("~/x/y")).toBe(path.resolve(os.homedir(), "x/y"));
  });
});
