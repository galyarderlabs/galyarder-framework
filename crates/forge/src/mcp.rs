//! `forge mcp`: the Forge Anything MCP server, on stdio.
//!
//! One MCP server carrying the Forge Anything workflow, so any MCP client
//! (including a free-tier chatbot) can read the skills, agents, and
//! commands, and scaffold a new project. No network, no external service:
//! everything is read from the local Forge Anything source checkout.
//!
//! Transport is newline-delimited JSON-RPC 2.0 over stdin/stdout, per the
//! MCP stdio transport. Handled methods: `initialize`,
//! `notifications/initialized` (and any other `notifications/*`, which get
//! no reply), `ping`, `tools/list`, `tools/call`. Anything else is a
//! JSON-RPC `-32601` (method not found). Diagnostics go to stderr only —
//! stdout is the protocol and must stay clean JSON.
//!
//! Tools:
//! - `list_skills` — every skill (name + description) from `skills/`.
//! - `read_skill` — a skill's `SKILL.md` (+ its `references/` file list).
//! - `read_command` — a command's `.md` file from `commands/`.
//! - `scaffold` — scaffold a new project (the `forge-scaffold` library).
//!
//! The source checkout is resolved exactly like `forge scaffold` does
//! (`forge-scaffold::source::resolve`: explicit `--source`, `FORGE_SOURCE`,
//! walk up from the cwd, walk up from the executable directory; a source
//! has `skills/using-forge-anything/SKILL.md` and `agents/forge-ceo/SOUL.md`). When no source
//! is found the server still answers `initialize`/`ping`/`tools/list`, and
//! every tool that needs the source returns a clear error instead of
//! crashing or inventing a source.

use crate::json::{self, Json};
use forge_scaffold::{scaffold as rs_scaffold, source as rs_source};
use std::fs;
use std::io::{BufRead, BufReader, Write};
use std::path::{Path, PathBuf};
use std::process::ExitCode;

const SERVER_NAME: &str = "forge-anything";
const PROTOCOL_VERSION: &str = "2025-06-18";

/// Run the MCP server on stdio until stdin closes. `--source <dir>` pins
/// the source checkout; `--help` prints usage.
pub fn run(args: &[String]) -> ExitCode {
    let mut source_arg: Option<PathBuf> = None;
    let mut i = 0;
    while i < args.len() {
        let arg = &args[i];
        match arg.as_str() {
            "--help" | "-h" => {
                print!("{MCP_HELP}");
                return ExitCode::from(0);
            }
            "--source" => {
                i += 1;
                match args.get(i) {
                    Some(v) => source_arg = Some(PathBuf::from(v)),
                    None => {
                        eprintln!("forge mcp: --source needs a value (see --help)");
                        return ExitCode::from(1);
                    }
                }
            }
            _ if arg.starts_with("--source=") => {
                source_arg = Some(PathBuf::from(arg.trim_start_matches("--source=")));
            }
            _ => {
                eprintln!("forge mcp: unknown option '{arg}' (see --help)");
                return ExitCode::from(1);
            }
        }
        i += 1;
    }

    // Resolve once, but do not fail the server when there is no source:
    // tools report the missing source as an error instead.
    let source = match rs_source::resolve(source_arg.as_deref()) {
        Ok(src) => Some(src),
        Err(e) => {
            eprintln!("forge mcp: no Forge Anything source found: {e}");
            None
        }
    };

    let server = Server { source };
    server.serve();
    ExitCode::from(0)
}

struct Server {
    source: Option<PathBuf>,
}

impl Server {
    fn serve(&self) {
        let stdin = std::io::stdin();
        let mut reader = BufReader::new(stdin.lock());
        let stdout = std::io::stdout();
        let mut out = stdout.lock();
        let mut line = String::new();
        loop {
            line.clear();
            match reader.read_line(&mut line) {
                Ok(0) => break, // EOF: the client went away.
                Ok(_) => {}
                Err(e) => {
                    eprintln!("forge mcp: error reading stdin: {e}");
                    break;
                }
            }
            let text = line.trim();
            if text.is_empty() {
                continue;
            }
            if let Some(response) = self.handle(text) {
                let _ = writeln!(out, "{}", response.to_string_compact());
                let _ = out.flush();
            }
        }
    }

    /// Handle one JSON-RPC message. Returns the response, or `None` for
    /// notifications (which never get a reply).
    fn handle(&self, text: &str) -> Option<Json> {
        let request = match json::parse(text) {
            Ok(v) => v,
            Err(e) => {
                return Some(error_response(
                    &Json::Null,
                    -32700,
                    &format!("parse error: {e}"),
                ));
            }
        };
        let method = match request.get("method").and_then(Json::as_str) {
            Some(m) => m.to_string(),
            None => {
                return Some(error_response(
                    &id_of(&request),
                    -32600,
                    "invalid request: missing method",
                ));
            }
        };
        let id = id_of(&request);
        let has_id = request.get("id").is_some_and(|v| *v != Json::Null);

        // Notifications never get a reply, even unknown ones.
        if method.starts_with("notifications/") || !has_id {
            if method.starts_with("notifications/") {
                return None;
            }
            // A method call without an id is a notification by definition.
            return None;
        }

        match method.as_str() {
            "initialize" => Some(result_response(
                &id,
                json::obj(vec![
                    ("protocolVersion", Json::Str(PROTOCOL_VERSION.to_string())),
                    (
                        "capabilities",
                        json::obj(vec![("tools", json::obj(vec![]))]),
                    ),
                    (
                        "serverInfo",
                        json::obj(vec![
                            ("name", Json::Str(SERVER_NAME.to_string())),
                            ("version", Json::Str(crate::version::version())),
                        ]),
                    ),
                ]),
            )),
            "ping" => Some(result_response(&id, json::obj(vec![]))),
            "tools/list" => Some(result_response(
                &id,
                json::obj(vec![("tools", tools_list())]),
            )),
            "tools/call" => Some(self.handle_tools_call(&id, request.get("params"))),
            _ => Some(error_response(
                &id,
                -32601,
                &format!("method not found: {method}"),
            )),
        }
    }

    fn handle_tools_call(&self, id: &Json, params: Option<&Json>) -> Json {
        let Some(params) = params else {
            return error_response(id, -32602, "tools/call needs params");
        };
        let Some(name) = params.get("name").and_then(Json::as_str) else {
            return error_response(id, -32602, "tools/call needs params.name (string)");
        };
        let args = params
            .get("arguments")
            .cloned()
            .unwrap_or(Json::Obj(vec![]));
        if !matches!(args, Json::Obj(_)) {
            return error_response(id, -32602, "tools/call arguments must be an object");
        }
        match name {
            "list_skills" => result_response(id, self.tool_result(self.list_skills())),
            "read_skill" => result_response(
                id,
                self.tool_result(self.read_skill(arg_str(&args, "name"))),
            ),
            "read_command" => result_response(
                id,
                self.tool_result(self.read_command(arg_str(&args, "name"))),
            ),
            "scaffold" => result_response(id, self.tool_result(self.tool_scaffold(&args))),
            _ => error_response(id, -32602, &format!("unknown tool: {name}")),
        }
    }

    /// Wrap a tool outcome as a `tools/call` result: `content` with an
    /// `isError` flag on failure. (A tool-level failure is a result, not a
    /// JSON-RPC error, so the client can show the message.)
    fn tool_result(&self, outcome: Result<String, String>) -> Json {
        match outcome {
            Ok(text) => json::obj(vec![
                (
                    "content",
                    Json::Arr(vec![json::obj(vec![
                        ("type", Json::Str("text".to_string())),
                        ("text", Json::Str(text)),
                    ])]),
                ),
                ("isError", Json::Bool(false)),
            ]),
            Err(message) => json::obj(vec![
                (
                    "content",
                    Json::Arr(vec![json::obj(vec![
                        ("type", Json::Str("text".to_string())),
                        ("text", Json::Str(message)),
                    ])]),
                ),
                ("isError", Json::Bool(true)),
            ]),
        }
    }

    /// The source checkout, or an error telling the client how to point
    /// the server at one.
    fn require_source(&self) -> Result<&Path, String> {
        self.source.as_deref().ok_or_else(|| {
            "no Forge Anything source checkout found. Run this from inside a \
             forge-anything checkout, pass --source <dir> to `forge mcp`, or set \
             FORGE_SOURCE to the checkout directory. A source checkout contains \
             skills/using-forge-anything/SKILL.md and agents/forge-ceo/SOUL.md."
                .to_string()
        })
    }

    fn list_skills(&self) -> Result<String, String> {
        let src = self.require_source()?;
        let dir = src.join("skills");
        let entries = read_dir_sorted(&dir)?;
        let mut skills = Vec::new();
        for entry in entries {
            let path = entry.path();
            if !path.is_dir() {
                continue;
            }
            let skill_md = path.join("SKILL.md");
            if !skill_md.is_file() {
                continue;
            }
            let text = fs::read_to_string(&skill_md)
                .map_err(|e| format!("cannot read '{}': {e}", skill_md.display()))?;
            let (fm_name, fm_desc) = parse_frontmatter(&text);
            let name = fm_name.unwrap_or_else(|| entry.file_name().to_string_lossy().into_owned());
            let description = fm_desc.unwrap_or_default();
            skills.push(json::obj(vec![
                ("name", Json::Str(name)),
                ("description", Json::Str(description)),
            ]));
        }
        Ok(Json::Arr(skills).to_string_compact())
    }

    fn read_skill(&self, name: Option<String>) -> Result<String, String> {
        let name = name.ok_or("read_skill needs a 'name' argument (string)")?;
        let clean = clean_name(&name, "skill")?;
        let src = self.require_source()?;
        let skill_md = src.join("skills").join(&clean).join("SKILL.md");
        if !skill_md.is_file() {
            return Err(format!(
                "skill '{clean}' not found in '{}'. Use list_skills to see the available skills.",
                src.join("skills").display()
            ));
        }
        let content = fs::read_to_string(&skill_md)
            .map_err(|e| format!("cannot read '{}': {e}", skill_md.display()))?;
        let refs_dir = src.join("skills").join(&clean).join("references");
        let mut out = content;
        if refs_dir.is_dir() {
            let files = read_dir_sorted(&refs_dir)?;
            let names: Vec<String> = files
                .iter()
                .filter(|e| e.path().is_file())
                .map(|e| e.file_name().to_string_lossy().into_owned())
                .collect();
            if !names.is_empty() {
                out.push_str("\n\n## References\n");
                for name in names {
                    out.push_str(&format!("- references/{name}\n"));
                }
            }
        }
        Ok(out)
    }

    fn read_command(&self, name: Option<String>) -> Result<String, String> {
        let name = name.ok_or("read_command needs a 'name' argument (string)")?;
        let clean = clean_name(&name, "command")?;
        let src = self.require_source()?;
        let path = src.join("commands").join(format!("{clean}.md"));
        read_named_file(&path, "command", &clean)
    }

    fn tool_scaffold(&self, args: &Json) -> Result<String, String> {
        let target = arg_str(args, "target")
            .ok_or("scaffold needs a 'target' argument (string: the directory to scaffold into)")?;
        let name = arg_str(args, "name").unwrap_or_default();
        let force = args.get("force").and_then(Json::as_bool).unwrap_or(false);
        let src = self.require_source()?;
        let target_path = absolutize(&target);
        let summary = rs_scaffold::scaffold(src, &target_path, &name, force)?;
        let display_name = if name.is_empty() {
            target_path
                .file_name()
                .map(|n| n.to_string_lossy().into_owned())
                .unwrap_or_else(|| "project".to_string())
        } else {
            name
        };
        Ok(format!(
            "scaffolded {display_name} into '{}': {} skills, {} agents, {} commands, \
             {} design specs, {} files total",
            target_path.display(),
            summary.skills,
            summary.agents,
            summary.commands,
            summary.design_specs,
            summary.files,
        ))
    }
}

/// The `tools/list` payload: the four tools with their input schemas.
fn tools_list() -> Json {
    let tool =
        |name: &str, description: &str, properties: Vec<(&str, Json)>, required: Vec<&str>| {
            json::obj(vec![
                ("name", Json::Str(name.to_string())),
                ("description", Json::Str(description.to_string())),
                (
                    "inputSchema",
                    json::obj(vec![
                        ("type", Json::Str("object".to_string())),
                        (
                            "properties",
                            Json::Obj(
                                properties
                                    .into_iter()
                                    .map(|(k, v)| (k.to_string(), v))
                                    .collect(),
                            ),
                        ),
                        (
                            "required",
                            Json::Arr(
                                required
                                    .into_iter()
                                    .map(|r| Json::Str(r.to_string()))
                                    .collect(),
                            ),
                        ),
                    ]),
                ),
            ])
        };
    let str_prop = |desc: &str| {
        json::obj(vec![
            ("type", Json::Str("string".to_string())),
            ("description", Json::Str(desc.to_string())),
        ])
    };
    Json::Arr(vec![
        tool(
            "list_skills",
            "List all Forge Anything skills (name + description). Read a skill with read_skill.",
            vec![],
            vec![],
        ),
        tool(
            "read_skill",
            "Read a Forge Anything skill by name. Returns its SKILL.md content, plus the files in its references/ directory when it has one.",
            vec![(
                "name",
                str_prop("The skill name, e.g. \"using-forge-anything\" or \"brainstorming\"."),
            )],
            vec!["name"],
        ),
        tool(
            "read_command",
            "Read a Forge Anything slash command by name. Returns the command's .md file content.",
            vec![(
                "name",
                str_prop("The command name, e.g. \"plan\" (with or without the .md suffix)."),
            )],
            vec!["name"],
        ),
        tool(
            "scaffold",
            "Scaffold a new Forge Anything project into a target directory (the curated skills, agents, commands, docs structure, and department folders).",
            vec![
                (
                    "target",
                    str_prop(
                        "The directory to scaffold into (created when missing). Relative paths resolve against the server's working directory.",
                    ),
                ),
                (
                    "name",
                    str_prop(
                        "Project name for the generated README (default: the target directory's name).",
                    ),
                ),
                (
                    "force",
                    json::obj(vec![
                        ("type", Json::Str("boolean".to_string())),
                        (
                            "description",
                            Json::Str(
                                "Scaffold into a non-empty directory (default false).".to_string(),
                            ),
                        ),
                    ]),
                ),
            ],
            vec!["target"],
        ),
    ])
}

fn result_response(id: &Json, result: Json) -> Json {
    json::obj(vec![
        ("jsonrpc", Json::Str("2.0".to_string())),
        ("id", id.clone()),
        ("result", result),
    ])
}

fn error_response(id: &Json, code: i64, message: &str) -> Json {
    json::obj(vec![
        ("jsonrpc", Json::Str("2.0".to_string())),
        ("id", id.clone()),
        (
            "error",
            json::obj(vec![
                ("code", Json::Num(code as f64)),
                ("message", Json::Str(message.to_string())),
            ]),
        ),
    ])
}

/// The request id, preserved verbatim (`null` when absent).
fn id_of(request: &Json) -> Json {
    request.get("id").cloned().unwrap_or(Json::Null)
}

/// One string argument from a `tools/call` arguments object.
fn arg_str(args: &Json, key: &str) -> Option<String> {
    args.get(key).and_then(Json::as_str).map(str::to_string)
}

/// Validate a skill/command name: a bare name, never a path, so a
/// tool call cannot escape the source directory. A trailing `.md` is
/// accepted for commands.
fn clean_name(name: &str, kind: &str) -> Result<String, String> {
    let base = name.strip_suffix(".md").unwrap_or(name);
    if base.is_empty()
        || base == "."
        || base == ".."
        || base.contains('/')
        || base.contains('\\')
        || base.contains('\0')
    {
        return Err(format!(
            "invalid {kind} name '{name}': expected a bare name, not a path"
        ));
    }
    Ok(base.to_string())
}

fn read_named_file(path: &Path, kind: &str, name: &str) -> Result<String, String> {
    if !path.is_file() {
        return Err(format!(
            "{kind} '{name}' not found: '{}' does not exist",
            path.display()
        ));
    }
    fs::read_to_string(path).map_err(|e| format!("cannot read '{}': {e}", path.display()))
}

/// Directory entries in sorted order, so `list_skills` is deterministic.
fn read_dir_sorted(dir: &Path) -> Result<Vec<fs::DirEntry>, String> {
    let mut entries: Vec<fs::DirEntry> = fs::read_dir(dir)
        .map_err(|e| format!("cannot read '{}': {e}", dir.display()))?
        .collect::<Result<_, _>>()
        .map_err(|e| format!("cannot read '{}': {e}", dir.display()))?;
    entries.sort_by_key(|e| e.file_name());
    Ok(entries)
}

/// Parse the YAML frontmatter (`---` block) of a SKILL.md file, returning
/// the `name` and `description` values. Handles quoted strings, plain
/// strings, and folded block scalars (`description: >` with indented
/// continuation lines joined with spaces).
fn parse_frontmatter(content: &str) -> (Option<String>, Option<String>) {
    let body = match content.strip_prefix("---\n") {
        Some(rest) => rest,
        None => return (None, None),
    };
    let end = match body.find("\n---\n") {
        Some(i) => i,
        None => return (None, None),
    };
    let fm = &body[..end];
    let mut name = None;
    let mut description = None;
    let mut lines = fm.lines().peekable();
    while let Some(line) = lines.next() {
        let Some((key, raw)) = line.split_once(':') else {
            continue;
        };
        let key = key.trim();
        if key != "name" && key != "description" {
            continue;
        }
        let raw = raw.trim();
        let value = if raw == ">" || raw == "|" {
            // Folded/literal block: indented continuation lines.
            let mut parts: Vec<String> = Vec::new();
            while let Some(next) = lines.peek() {
                if next.starts_with(' ') || next.starts_with('\t') || next.trim().is_empty() {
                    let taken = lines.next().unwrap_or("");
                    if !taken.trim().is_empty() {
                        parts.push(taken.trim().to_string());
                    }
                } else {
                    break;
                }
            }
            if raw == ">" {
                parts.join(" ")
            } else {
                parts.join("\n")
            }
        } else if (raw.starts_with('"') && raw.ends_with('"') && raw.len() >= 2)
            || (raw.starts_with('\'') && raw.ends_with('\'') && raw.len() >= 2)
        {
            raw[1..raw.len() - 1].to_string()
        } else {
            raw.to_string()
        };
        if key == "name" {
            name = Some(value);
        } else {
            description = Some(value);
        }
    }
    (name, description)
}

/// Make a path absolute (relative to the current directory).
fn absolutize(path: &str) -> PathBuf {
    let p = Path::new(path);
    if p.is_absolute() {
        return p.to_path_buf();
    }
    match std::env::current_dir() {
        Ok(cwd) => cwd.join(p),
        Err(_) => p.to_path_buf(),
    }
}

const MCP_HELP: &str = "forge mcp: run the Forge Anything MCP server on stdio.\n\
     \n\
     Usage: forge mcp [OPTIONS]\n\
     \n\
     Options:\n\
       --source <dir>   Forge Anything checkout to read skills from\n\
                        (default: auto-detect; see FORGE_SOURCE)\n\
       --help           Show this help\n\
     \n\
     The server speaks JSON-RPC 2.0 (MCP) over stdin/stdout: initialize,\n\
     ping, tools/list, tools/call. Tools: list_skills, read_skill,\n\
     read_command, scaffold. It reads the local source checkout\n\
     only — no network, no external service.\n";

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parses_quoted_frontmatter() {
        let md = "---\nname: using-forge-anything\ndescription: \"Use when starting any conversation.\"\n---\n\n# Using Forge Anything\n";
        assert_eq!(
            parse_frontmatter(md),
            (
                Some("using-forge-anything".to_string()),
                Some("Use when starting any conversation.".to_string())
            )
        );
    }

    #[test]
    fn parses_folded_block_description() {
        let md = "---\nname: release\ndescription: >\n  Coordinate a full release across engineering,\n  npm, and GitHub.\n---\nbody\n";
        assert_eq!(
            parse_frontmatter(md),
            (
                Some("release".to_string()),
                Some("Coordinate a full release across engineering, npm, and GitHub.".to_string())
            )
        );
    }

    #[test]
    fn rejects_path_like_names() {
        assert!(clean_name("../forge", "skill").is_err());
        assert!(clean_name("a/b", "skill").is_err());
        assert!(clean_name("", "skill").is_err());
        assert_eq!(clean_name("plan.md", "command").unwrap(), "plan");
        assert_eq!(clean_name("plan", "command").unwrap(), "plan");
    }

    #[test]
    fn tools_list_has_the_four_tools() {
        let list = tools_list();
        let Json::Arr(tools) = &list else {
            panic!("tools/list must be an array");
        };
        assert_eq!(tools.len(), 4);
        let names: Vec<&str> = tools
            .iter()
            .filter_map(|t| t.get("name"))
            .filter_map(Json::as_str)
            .collect();
        assert_eq!(
            names,
            ["list_skills", "read_skill", "read_command", "scaffold"]
        );
    }
}
