//! Behavior tests for the Rust `forge` CLI.
//!
//! The help text, version output, no-args behavior and unknown-command
//! handling are asserted directly. `scaffold` must produce a ready repo
//! through the CLI, and `smoke` must run the repo's smoke test.

use std::fs;
use std::path::{Path, PathBuf};
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

fn run_forge_in(args: &[&str], dir: &PathBuf) -> std::process::Output {
    Command::new(forge_bin())
        .args(args)
        .current_dir(dir)
        .output()
        .expect("run forge")
}

/// A fresh temp dir per company test (cargo runs tests in parallel, so
/// the pid alone is not enough to keep them apart).
fn company_tmp(name: &str) -> PathBuf {
    let tmp = std::env::temp_dir().join(format!("forge-cli-company-{}-{name}", std::process::id()));
    let _ = fs::remove_dir_all(&tmp);
    fs::create_dir_all(&tmp).expect("create tmp dir");
    tmp
}

fn write_file(path: &Path, content: &str) {
    if let Some(parent) = path.parent() {
        fs::create_dir_all(parent).expect("create parent dirs");
    }
    fs::write(path, content).expect("write file");
}

/// A minimal company package mirroring the example company (Lean Dev
/// Shop): 2 agents, 1 team, 1 project, 2 tasks (one under the project,
/// one top-level), 1 skill.
fn write_company_package(dir: &Path, slug: &str, name: &str) {
    write_file(
        &dir.join("COMPANY.md"),
        &format!(
            "---\nname: {name}\ndescription: Small engineering-focused AI company\nslug: {slug}\nschema: agentcompanies/v1\n---\n\n{name} builds software.\n"
        ),
    );
    write_file(
        &dir.join("agents/ceo/AGENTS.md"),
        "---\nname: CEO\ntitle: Chief Executive Officer\nreportsTo: null\nskills:\n  - forge\n---\n\nYou are the CEO.\n",
    );
    write_file(
        &dir.join("agents/cto/AGENTS.md"),
        "---\nname: CTO\ntitle: Chief Technology Officer\nreportsTo: ceo\nskills:\n  - code-review\n  - forge\n---\n\nYou are the CTO.\n",
    );
    write_file(
        &dir.join("teams/engineering/TEAM.md"),
        "---\nname: Engineering\ndescription: Product and platform engineering team\nslug: engineering\nmanager: ../../agents/cto/AGENTS.md\n---\n\nThe engineering team builds software.\n",
    );
    write_file(
        &dir.join("projects/q2-launch/PROJECT.md"),
        "---\nname: Q2 Launch\ndescription: Ship the Q2 product launch\nslug: q2-launch\nowner: cto\n---\n\nDeliver the Q2 launch.\n",
    );
    write_file(
        &dir.join("projects/q2-launch/tasks/monday-review/TASK.md"),
        "---\nname: Monday Review\nassignee: ceo\nproject: q2-launch\n---\n\nReview the Q2 launch status.\n",
    );
    write_file(
        &dir.join("tasks/weekly-review/TASK.md"),
        "---\nname: Weekly Review\nassignee: ceo\n---\n\nReview the week.\n",
    );
    write_file(
        &dir.join("skills/code-review/SKILL.md"),
        "---\nname: code-review\ndescription: Thorough code review skill\n---\n\nReview code changes.\n",
    );
}

#[test]
fn company_help_lists_the_actions() {
    let out = run_forge(&["company", "--help"]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("forge company"));
    assert!(text.contains("import"));
    assert!(text.contains("forge company import --from"));
}

#[test]
fn company_no_action_shows_help() {
    let out = run_forge(&["company"]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("forge company"));
    assert!(text.contains("import"));
}

#[test]
fn company_import_help() {
    let out = run_forge(&["company", "import", "--help"]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("--from <path>"));
    assert!(text.contains("company/<slug>/"));
}

#[test]
fn company_unknown_action_exits_1() {
    let out = run_forge(&["company", "bogus"]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("[ERR] Unknown company action: bogus"));
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("forge company"));
}

#[test]
fn company_import_succeeds() {
    let tmp = company_tmp("import-succeeds");
    let pkg = tmp.join("lean-dev-shop");
    write_company_package(&pkg, "lean-dev-shop", "Lean Dev Shop");
    let target = tmp.join("my-project");
    let out = run_forge(&[
        "company",
        "import",
        "--from",
        pkg.to_str().unwrap(),
        target.to_str().unwrap(),
    ]);
    assert!(
        out.status.success(),
        "forge company import failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let dest = target.join("company/lean-dev-shop");
    assert!(dest.join("COMPANY.md").is_file());
    assert!(dest.join("agents/ceo/AGENTS.md").is_file());
    assert!(dest.join("agents/cto/AGENTS.md").is_file());
    assert!(dest.join("teams/engineering/TEAM.md").is_file());
    assert!(dest.join("projects/q2-launch/PROJECT.md").is_file());
    assert!(
        dest.join("projects/q2-launch/tasks/monday-review/TASK.md")
            .is_file()
    );
    assert!(dest.join("tasks/weekly-review/TASK.md").is_file());
    assert!(dest.join("skills/code-review/SKILL.md").is_file());
    // The package stays self-contained; nothing lands in the project root.
    assert!(!target.join("skills").exists());
    assert!(!target.join("agents").exists());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("Imported Lean Dev Shop (lean-dev-shop)"));
    assert!(text.contains("2 agents, 1 teams, 1 projects, 2 tasks, 1 skills"));
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_defaults_to_current_directory() {
    let tmp = company_tmp("import-default-dir");
    let pkg = tmp.join("lean-dev-shop");
    write_company_package(&pkg, "lean-dev-shop", "Lean Dev Shop");
    let target = tmp.join("my-project");
    fs::create_dir_all(&target).expect("create target");
    let out = run_forge_in(
        &["company", "import", "--from", pkg.to_str().unwrap()],
        &target,
    );
    assert!(
        out.status.success(),
        "forge company import failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(target.join("company/lean-dev-shop/COMPANY.md").is_file());
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_requires_from() {
    let out = run_forge(&["company", "import"]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("--from"), "err: {err}");
}

#[test]
fn company_import_from_must_be_a_directory() {
    let tmp = company_tmp("import-not-a-dir");
    let file = tmp.join("not-a-dir.txt");
    fs::write(&file, "hello").expect("write file");
    let out = run_forge(&["company", "import", "--from", file.to_str().unwrap()]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("is not a directory"), "err: {err}");
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_requires_company_md() {
    let tmp = company_tmp("import-no-company-md");
    let pkg = tmp.join("empty-pkg");
    fs::create_dir_all(&pkg).expect("create pkg");
    let out = run_forge(&["company", "import", "--from", pkg.to_str().unwrap()]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("no COMPANY.md"), "err: {err}");
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_rejects_a_wrong_schema() {
    let tmp = company_tmp("import-wrong-schema");
    let pkg = tmp.join("pkg");
    write_company_package(&pkg, "lean-dev-shop", "Lean Dev Shop");
    fs::write(
        pkg.join("COMPANY.md"),
        "---\nname: Lean Dev Shop\ndescription: Small shop\nslug: lean-dev-shop\nschema: something-else/v2\n---\n",
    )
    .expect("rewrite COMPANY.md");
    let out = run_forge(&["company", "import", "--from", pkg.to_str().unwrap()]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(
        err.contains("unsupported schema 'something-else/v2'"),
        "err: {err}"
    );
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_rejects_a_missing_field() {
    let tmp = company_tmp("import-missing-field");
    let pkg = tmp.join("pkg");
    write_company_package(&pkg, "lean-dev-shop", "Lean Dev Shop");
    fs::write(
        pkg.join("COMPANY.md"),
        "---\nname: Lean Dev Shop\ndescription: Small shop\nschema: agentcompanies/v1\n---\n",
    )
    .expect("rewrite COMPANY.md");
    let out = run_forge(&["company", "import", "--from", pkg.to_str().unwrap()]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("missing 'slug'"), "err: {err}");
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_rejects_a_bad_slug() {
    let tmp = company_tmp("import-bad-slug");
    let pkg = tmp.join("pkg");
    write_company_package(&pkg, "bad slug", "Bad Slug Co");
    let out = run_forge(&["company", "import", "--from", pkg.to_str().unwrap()]);
    assert_eq!(out.status.code(), Some(1));
    let err = String::from_utf8_lossy(&out.stderr);
    assert!(err.contains("not URL-safe"), "err: {err}");
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_twice_without_force_fails() {
    let tmp = company_tmp("import-twice-no-force");
    let pkg = tmp.join("lean-dev-shop");
    write_company_package(&pkg, "lean-dev-shop", "Lean Dev Shop");
    let target = tmp.join("my-project");
    let args = [
        "company",
        "import",
        "--from",
        pkg.to_str().unwrap(),
        target.to_str().unwrap(),
    ];
    let first = run_forge(&args);
    assert!(
        first.status.success(),
        "first import failed: {}",
        String::from_utf8_lossy(&first.stderr)
    );
    let second = run_forge(&args);
    assert_eq!(second.status.code(), Some(1));
    let err = String::from_utf8_lossy(&second.stderr);
    assert!(err.contains("already imported"), "err: {err}");
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn company_import_twice_with_force_succeeds() {
    let tmp = company_tmp("import-twice-force");
    let pkg = tmp.join("lean-dev-shop");
    write_company_package(&pkg, "lean-dev-shop", "Lean Dev Shop");
    let target = tmp.join("my-project");
    let first = run_forge(&[
        "company",
        "import",
        "--from",
        pkg.to_str().unwrap(),
        target.to_str().unwrap(),
    ]);
    assert!(first.status.success());
    // Change a file in the package, then re-import with --force: the
    // installed copy must pick up the change (overwrite, not merge).
    fs::write(
        pkg.join("COMPANY.md"),
        "---\nname: Lean Dev Shop v2\ndescription: Small shop\nslug: lean-dev-shop\nschema: agentcompanies/v1\n---\n",
    )
    .expect("rewrite COMPANY.md");
    let second = run_forge(&[
        "company",
        "import",
        "--from",
        pkg.to_str().unwrap(),
        target.to_str().unwrap(),
        "--force",
    ]);
    assert!(
        second.status.success(),
        "forced import failed: {}",
        String::from_utf8_lossy(&second.stderr)
    );
    let installed = fs::read_to_string(target.join("company/lean-dev-shop/COMPANY.md"))
        .expect("read installed COMPANY.md");
    assert!(installed.contains("Lean Dev Shop v2"));
    let text = String::from_utf8_lossy(&second.stdout);
    assert!(text.contains("Imported Lean Dev Shop v2 (lean-dev-shop)"));
    let _ = fs::remove_dir_all(&tmp);
}

#[test]
fn help_lists_the_commands() {
    let out = run_forge(&["--help"]);
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.starts_with("\nForge Anything CLI v"));
    assert!(text.contains("Forge anything with AI agents."));
    assert!(text.contains("forge <command> [options]"));
    for cmd in ["scaffold", "company", "smoke", "version", "help"] {
        assert!(text.contains(cmd), "help lists {cmd}");
    }
    assert!(text.contains("forge scaffold"));
    assert!(text.contains("forge company import --from ./my-company"));
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
    assert_eq!(fs::read_dir(target.join("commands")).unwrap().count(), 24);
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
