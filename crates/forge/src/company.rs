//! `forge company`: work with agent-company packages.
//!
//! An agent-company package is a directory built by the company-creator
//! skill, conforming to the Agent Companies specification
//! (agentcompanies/v1). `forge company import` copies a package into a
//! project under `company/<slug>/`, so the company runs in Forge Anything.
//! The package stays self-contained there; its skills are not copied into
//! the project's root `skills/` and its agents are not copied into the
//! project's root `agents/`.

use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::ExitCode;

const EXPECTED_SCHEMA: &str = "agentcompanies/v1";

/// Dispatch `forge company <action> ...`.
pub fn run(args: &[String]) -> Result<ExitCode, (u8, String)> {
    let action = args.first().cloned();
    let rest: Vec<String> = args.iter().skip(1).cloned().collect();
    match action.as_deref() {
        None | Some("help") | Some("--help") | Some("-h") => {
            print!("{COMPANY_HELP}");
            Ok(ExitCode::from(0))
        }
        Some("import") => run_import(&rest),
        Some(other) => {
            eprintln!("[ERR] Unknown company action: {other}");
            print!("{COMPANY_HELP}");
            Ok(ExitCode::from(1))
        }
    }
}

/// `forge company import --from <path> [dir] [--force]`.
/// No dir means the current directory; a dir argument is honored.
fn run_import(args: &[String]) -> Result<ExitCode, (u8, String)> {
    let mut from: Option<PathBuf> = None;
    let mut target: Option<PathBuf> = None;
    let mut force = false;

    let mut i = 0;
    while i < args.len() {
        let arg = &args[i];
        match arg.as_str() {
            "--help" | "-h" => {
                print!("{IMPORT_HELP}");
                return Ok(ExitCode::from(0));
            }
            "--force" | "-f" => force = true,
            "--from" => {
                i += 1;
                from = Some(take_value(args, i, "--from")?);
            }
            _ if arg.starts_with("--from=") => {
                let value = arg.trim_start_matches("--from=");
                if value.is_empty() {
                    return Err((1, "company import: --from needs a value".to_string()));
                }
                from = Some(PathBuf::from(value));
            }
            _ if arg.starts_with('-') => {
                return Err((
                    1,
                    format!("company import: unknown option '{arg}' (see --help)"),
                ));
            }
            _ => {
                if target.is_some() {
                    return Err((
                        1,
                        "company import: expected at most one target directory".to_string(),
                    ));
                }
                target = Some(PathBuf::from(arg));
            }
        }
        i += 1;
    }

    let from = match from {
        Some(p) => p,
        None => {
            return Err((
                1,
                "company import: --from <path> is required (see --help)".to_string(),
            ));
        }
    };
    if !from.is_dir() {
        return Err((
            1,
            format!("company import: {} is not a directory", from.display()),
        ));
    }
    let source = fs::canonicalize(&from).map_err(|e| {
        (
            2,
            format!("company import: cannot read {}: {e}", from.display()),
        )
    })?;
    let company_md = source.join("COMPANY.md");
    if !company_md.is_file() {
        return Err((
            1,
            format!(
                "company import: {} is not a company package (no COMPANY.md)",
                from.display()
            ),
        ));
    }
    let text = fs::read_to_string(&company_md).map_err(|e| {
        (
            2,
            format!("company import: cannot read {}: {e}", company_md.display()),
        )
    })?;
    let meta = parse_company_frontmatter(&text).map_err(|e| (1, e))?;

    // Default target: the current directory (absolute, so the company
    // lands under the real project directory, not ".").
    let target = match target {
        Some(t) => t,
        None => {
            env::current_dir().map_err(|e| (2, format!("cannot read current directory: {e}")))?
        }
    };
    let target = absolute(&target)?;
    let dest = target.join("company").join(&meta.slug);

    // Never copy a package into itself: the destination must not be the
    // package or a directory inside it. This matters most with --force,
    // where the destination is removed before the copy.
    if dest.starts_with(&source) {
        return Err((
            1,
            "company import: the target is inside the package (cannot import a package into itself)".to_string(),
        ));
    }
    if dest.exists() {
        if let Ok(canon) = fs::canonicalize(&dest) {
            if canon == source {
                return Err((
                    1,
                    "company import: the target is the package itself".to_string(),
                ));
            }
        }
    }

    if dest.exists() && !force {
        return Err((
            1,
            format!(
                "company import: company '{}' is already imported at {} (use --force to overwrite)",
                meta.slug,
                dest.display()
            ),
        ));
    }
    if dest.exists() {
        // --force: remove the previous import first.
        let removed = if dest.is_dir() {
            fs::remove_dir_all(&dest)
        } else {
            fs::remove_file(&dest)
        };
        removed.map_err(|e| {
            (
                2,
                format!("company import: cannot remove {}: {e}", dest.display()),
            )
        })?;
    }

    copy_dir(&source, &dest).map_err(|e| {
        (
            2,
            format!(
                "company import: cannot copy {} to {}: {e}",
                source.display(),
                dest.display()
            ),
        )
    })?;
    let counts = count_kinds(&source);
    println!(
        "Imported {} ({}) into {}: {} agents, {} teams, {} projects, {} tasks, {} skills.",
        meta.name,
        meta.slug,
        dest.display(),
        counts.0,
        counts.1,
        counts.2,
        counts.3,
        counts.4,
    );
    Ok(ExitCode::from(0))
}

fn take_value(args: &[String], i: usize, flag: &str) -> Result<PathBuf, (u8, String)> {
    args.get(i)
        .map(PathBuf::from)
        .ok_or_else(|| (1, format!("company import: {flag} needs a value")))
}

/// Make a path absolute using the current directory when it is relative.
fn absolute(path: &Path) -> Result<PathBuf, (u8, String)> {
    if path.is_absolute() {
        Ok(path.to_path_buf())
    } else {
        env::current_dir()
            .map(|cwd| cwd.join(path))
            .map_err(|e| (2, format!("cannot read current directory: {e}")))
    }
}

/// The fields `forge company import` reads from a package's COMPANY.md.
/// The description is validated (it must be non-empty) but not stored,
/// because the import summary reports the name and the slug.
#[derive(Debug)]
struct CompanyMeta {
    name: String,
    slug: String,
}

/// Read `schema`, `name`, `description`, and `slug` from the frontmatter
/// block at the top of COMPANY.md. Only simple `key: value` lines are
/// read; list items and nested blocks are skipped. Returns an error
/// naming the first problem found.
fn parse_company_frontmatter(text: &str) -> Result<CompanyMeta, String> {
    let mut lines = text.lines();
    let first = lines.next().unwrap_or("");
    if first.trim() != "---" {
        return Err(
            "company import: COMPANY.md has no frontmatter block (expected schema: agentcompanies/v1)"
                .to_string(),
        );
    }
    let mut fields: Vec<(String, String)> = Vec::new();
    let mut closed = false;
    for line in lines {
        if line.trim() == "---" {
            closed = true;
            break;
        }
        if let Some((key, value)) = line.split_once(':') {
            let key = key.trim();
            if key.is_empty() || key.contains(' ') || key.starts_with('-') {
                continue;
            }
            fields.push((key.to_string(), unquote(value.trim())));
        }
    }
    if !closed {
        return Err("company import: COMPANY.md frontmatter is not closed".to_string());
    }
    let get = |name: &str| -> Option<String> {
        fields
            .iter()
            .find(|(k, _)| k == name)
            .map(|(_, v)| v.clone())
    };
    let schema = get("schema").unwrap_or_default();
    if schema != EXPECTED_SCHEMA {
        return Err(format!(
            "company import: unsupported schema '{schema}' (expected agentcompanies/v1)"
        ));
    }
    let name = get("name").unwrap_or_default();
    if name.is_empty() {
        return Err("company import: COMPANY.md is missing 'name'".to_string());
    }
    let description = get("description").unwrap_or_default();
    if description.is_empty() {
        return Err("company import: COMPANY.md is missing 'description'".to_string());
    }
    let slug = get("slug").unwrap_or_default();
    if slug.is_empty() {
        return Err("company import: COMPANY.md is missing 'slug'".to_string());
    }
    if !is_valid_slug(&slug) {
        return Err(format!(
            "company import: slug '{slug}' is not URL-safe (lowercase letters, digits, and hyphens only)"
        ));
    }
    Ok(CompanyMeta { name, slug })
}

/// Strip one layer of matching single or double quotes from a value.
fn unquote(value: &str) -> String {
    let value = value.trim();
    if value.len() >= 2 {
        let first = value.as_bytes()[0];
        let last = value.as_bytes()[value.len() - 1];
        if (first == b'"' && last == b'"') || (first == b'\'' && last == b'\'') {
            return value[1..value.len() - 1].to_string();
        }
    }
    value.to_string()
}

/// A slug is URL-safe when it is non-empty and holds only lowercase
/// letters, digits, and hyphens.
fn is_valid_slug(slug: &str) -> bool {
    !slug.is_empty()
        && slug
            .chars()
            .all(|c| c.is_ascii_lowercase() || c.is_ascii_digit() || c == '-')
}

/// Copy a directory tree, creating the destination (and its parents) as
/// needed. Symlinks are followed: a link to a directory is copied as a
/// directory, a link to a file is copied as a file.
fn copy_dir(src: &Path, dst: &Path) -> std::io::Result<()> {
    fs::create_dir_all(dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let src_path = entry.path();
        let dst_path = dst.join(entry.file_name());
        if src_path.is_dir() {
            copy_dir(&src_path, &dst_path)?;
        } else {
            fs::copy(&src_path, &dst_path)?;
        }
    }
    Ok(())
}

/// Count the AGENTS.md, TEAM.md, PROJECT.md, TASK.md, and SKILL.md files
/// under a package directory, in that order.
fn count_kinds(pkg: &Path) -> (usize, usize, usize, usize, usize) {
    let mut counts = (0, 0, 0, 0, 0);
    count_in(pkg, &mut counts);
    counts
}

fn count_in(dir: &Path, counts: &mut (usize, usize, usize, usize, usize)) {
    let entries = match fs::read_dir(dir) {
        Ok(e) => e,
        Err(_) => return,
    };
    for entry in entries.flatten() {
        let path = entry.path();
        if path.is_dir() {
            count_in(&path, counts);
        } else if let Some(name) = path.file_name().and_then(|n| n.to_str()) {
            match name {
                "AGENTS.md" => counts.0 += 1,
                "TEAM.md" => counts.1 += 1,
                "PROJECT.md" => counts.2 += 1,
                "TASK.md" => counts.3 += 1,
                "SKILL.md" => counts.4 += 1,
                _ => {}
            }
        }
    }
}

const COMPANY_HELP: &str = "forge company: work with agent-company packages.\n\
     \n\
     Usage: forge company <action> [options]\n\
     \n\
     Actions:\n\
     \x20 import   Import an agent-company package into a project\n\
     \x20 help     Show this help message\n\
     \n\
     Examples:\n\
     \x20 forge company import --from ./my-company\n\
     \x20 forge company import --from ./my-company ./my-project --force\n\
     \n\
     Run 'forge company import --help' for the import options.\n";

const IMPORT_HELP: &str = "forge company import: import an agent-company package into a project.\n\
     \n\
     Usage: forge company import --from <path> [OPTIONS] [dir]\n\
     \n\
     Options:\n\
     \x20 --from <path>  Company package directory to import (required)\n\
     \x20 --force        Overwrite the company if it is already imported\n\
     \x20 --help         Show this help\n\
     \n\
     The package must have COMPANY.md at its root, with schema\n\
     agentcompanies/v1 and a URL-safe slug. The package is copied into\n\
     <dir>/company/<slug>/ (default dir: the current directory). The\n\
     package stays self-contained under company/<slug/>; its skills are\n\
     not copied into the project's root skills/ and its agents are not\n\
     copied into the project's root agents/.\n";

#[cfg(test)]
mod tests {
    use super::*;

    fn frontmatter(body: &str) -> String {
        format!("---\n{body}---\n")
    }

    #[test]
    fn parses_a_valid_company_frontmatter() {
        let text = frontmatter(
            "name: Lean Dev Shop\n\
             description: Small engineering-focused AI company\n\
             slug: lean-dev-shop\n\
             schema: agentcompanies/v1\n\
             version: \"1.8.19\"\n\
             license: MIT\n\
             authors:\n\
               - name: Example Org\n",
        );
        let meta = parse_company_frontmatter(&text).expect("valid frontmatter parses");
        assert_eq!(meta.name, "Lean Dev Shop");
        assert_eq!(meta.slug, "lean-dev-shop");
    }

    #[test]
    fn strips_quotes_from_values() {
        let text = frontmatter(
            "name: \"Lean Dev Shop\"\n\
             description: 'Small shop'\n\
             slug: lean-dev-shop\n\
             schema: agentcompanies/v1\n",
        );
        let meta = parse_company_frontmatter(&text).expect("quoted values parse");
        assert_eq!(meta.name, "Lean Dev Shop");
    }

    #[test]
    fn rejects_a_missing_frontmatter_block() {
        let err = parse_company_frontmatter("name: Lean Dev Shop\n").unwrap_err();
        assert!(err.contains("no frontmatter block"), "err: {err}");
    }

    #[test]
    fn rejects_an_unclosed_frontmatter_block() {
        let err = parse_company_frontmatter("---\nname: Lean Dev Shop\n").unwrap_err();
        assert!(err.contains("not closed"), "err: {err}");
    }

    #[test]
    fn rejects_a_missing_schema() {
        let text =
            frontmatter("name: Lean Dev Shop\ndescription: Small shop\nslug: lean-dev-shop\n");
        let err = parse_company_frontmatter(&text).unwrap_err();
        assert!(err.contains("unsupported schema ''"), "err: {err}");
    }

    #[test]
    fn rejects_a_wrong_schema() {
        let text = frontmatter(
            "name: Lean Dev Shop\n\
             description: Small shop\n\
             slug: lean-dev-shop\n\
             schema: something-else/v2\n",
        );
        let err = parse_company_frontmatter(&text).unwrap_err();
        assert!(
            err.contains("unsupported schema 'something-else/v2'"),
            "err: {err}"
        );
    }

    #[test]
    fn rejects_a_missing_field_by_name() {
        for missing in ["name", "description", "slug"] {
            let mut body = String::new();
            for field in ["name", "description", "slug"] {
                if field != missing {
                    body.push_str(&format!("{field}: some {field}\n"));
                }
            }
            body.push_str("schema: agentcompanies/v1\n");
            let err = parse_company_frontmatter(&frontmatter(&body)).unwrap_err();
            assert!(err.contains(&format!("missing '{missing}'")), "err: {err}");
        }
    }

    #[test]
    fn rejects_a_bad_slug() {
        for bad in [
            "Bad Slug",
            "lean_dev_shop",
            "lean/dev/shop",
            "LEAN-DEV-SHOP",
        ] {
            let text = frontmatter(&format!(
                "name: Lean Dev Shop\ndescription: Small shop\nslug: {bad}\nschema: agentcompanies/v1\n"
            ));
            let err = parse_company_frontmatter(&text).unwrap_err();
            assert!(err.contains("not URL-safe"), "slug {bad}: err: {err}");
        }
    }

    #[test]
    fn accepts_url_safe_slugs() {
        for good in ["lean-dev-shop", "a", "shop2", "a-b-c-1"] {
            assert!(is_valid_slug(good), "slug {good} is valid");
        }
        for bad in ["", "Bad Slug", "lean_dev_shop", "lean/dev/shop", "LEAN"] {
            assert!(!is_valid_slug(bad), "slug {bad} is invalid");
        }
    }
}
