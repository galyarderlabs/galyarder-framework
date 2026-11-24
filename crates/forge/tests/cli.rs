//! Behavior tests for the Rust `forge` CLI.
//!
//! The help text, version output, no-args behavior and unknown-command
//! handling are asserted directly. `scaffold` must produce a ready repo
//! through the CLI, and `smoke` must run the repo's smoke test.

use std::fs;
use std::path::PathBuf;
use std::process::Command;

fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("..")
        .join("..")
        .canonicalize()
        .expect("repo root resolves")
}

fn forge_bin() -> String {
    env!("CARGO_BIN_EXE_forge").to_string()
}

/// The version in the source checkout's package.json.
fn package_version() -> String {
    let text = fs::read_to_string(repo_root().join("package.json")).expect("read package.json");
    let key = "\"version\"";
    let at = text.find(key).expect("package.json has a version");
    let rest = &text[at + key.len()..];
    let after_colon = rest.trim_start().strip_prefix(':').expect("version colon");
    let after_quote = after_colon
        .trim_start()
        .strip_prefix('"')
        .expect("version quote");
    let end = after_quote.find('"').expect("version closing quote");
    after_quote[..end].to_string()
}

fn run_forge(args: &[&str]) -> std::process::Output {
    Command::new(forge_bin())
        .args(args)
        .current_dir(repo_root())
        .output()
        .expect("run forge")
}

#[test]
fn help_lists_the_commands() {
    let out = run_forge(&["--help"]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.starts_with("\nForge Anything CLI v"));
    assert!(text.contains("Forge anything with AI agents."));
    assert!(text.contains("forge <command> [options]"));
    for cmd in ["scaffold", "smoke", "version", "help"] {
        assert!(text.contains(cmd), "help lists {cmd}");
    }
    assert!(text.contains("forge scaffold"));
    assert!(text.contains("forge smoke"));
}

#[test]
fn version_matches_package_json() {
    let out = run_forge(&["--version"]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert_eq!(
        text.trim(),
        format!("Forge Anything v{}", package_version())
    );
}

#[test]
fn no_args_shows_help() {
    let out = run_forge(&[]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("Forge Anything CLI"));
    assert!(text.contains("forge <command> [options]"));
}

#[test]
fn unknown_command_exits_1_with_error_and_help() {
    let out = run_forge(&["bogus"]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("[ERR] Unknown command: bogus"));
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("Forge Anything CLI"));
}

#[test]
fn removed_commands_are_unknown() {
    // deploy/convert/sync were removed when the manual integrations went
    // away; installation is via each harness's native plugin manifest.
    for cmd in ["deploy", "convert", "sync"] {
        let out = run_forge(&[cmd]);
        assert_eq!(out.status.code(), Some(1), "{cmd} must exit 1");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(err.contains(&format!("[ERR] Unknown command: {cmd}")));
    }
}

#[test]
fn scaffold_through_cli_produces_a_ready_repo() {
    let tmp = std::env::temp_dir().join(format!("forge-cli-e2e-{}", std::process::id()));
    let _ = fs::remove_dir_all(&tmp);
    let target = tmp.join("my-project");
    let out = Command::new(forge_bin())
        .arg("scaffold")
        .arg("--name")
        .arg("my-project")
        .arg(&target)
        .current_dir(repo_root())
        .output()
        .expect("run forge scaffold");
    assert!(
        out.status.success(),
        "forge scaffold failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(target.join("README.md").is_file());
    assert!(target.join("skills/forge/SKILL.md").is_file());
    assert!(target.join("agents/forge-ceo.md").is_file());
    assert!(target.join("commands/plan.md").is_file());
    assert!(
        target
            .join("docs/departments/Executive/README.md")
            .is_file()
    );
    assert_eq!(fs::read_dir(target.join("skills")).unwrap().count(), 38);
    assert_eq!(fs::read_dir(target.join("agents")).unwrap().count(), 18);
    assert_eq!(fs::read_dir(target.join("commands")).unwrap().count(), 25);
    // No per-host copies or manifests in the scaffolded repo.
    assert!(!target.join(".claude-plugin").exists());
    assert!(!target.join(".cursor").exists());
    assert!(!target.join("gemini-extension.json").exists());
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn smoke_through_cli_succeeds() {
    let out = run_forge(&["smoke"]);
    assert!(
        out.status.success(),
        "forge smoke failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("SMOKE TEST PASSED"));
}
