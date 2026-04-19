#!/usr/bin/env bash
# Usage:
#   ./scripts/convert.sh [--tool <name>] [--out <dir>] [--help]
#
# Tools: antigravity, cursor, aider, kilocode, windsurf, opencode, augment, claude-code, codex, gemini, openclaw, hermes, all
# Default: all

set -euo pipefail

# HARDENED PATH RESOLUTION: Trace symlinks to the real framework source
REAL_PATH=$(readlink -f "$0")
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

TOOL="all"
OUT_BASE="${REPO_ROOT}/integrations"
TODAY="$(date +%F)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

ok() { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[!!]${NC} $*"; }
err() { echo -e "${RED}[ERR]${NC} $*" >&2; }
info() { echo -e "${BLUE}[*]${NC} $*"; }

usage() {
  cat <<'USAGE'
Usage:
  ./scripts/convert.sh [--tool <name>] [--out <dir>] [--help]

Tools:
  antigravity, cursor, aider, kilocode, windsurf, opencode, augment, claude-code, codex, gemini, openclaw, hermes, all

Defaults:
  --tool all
  --out  <repo-root>/integrations
USAGE
}

is_valid_tool() {
  case "$1" in
    antigravity|cursor|aider|kilocode|windsurf|opencode|augment|claude-code|codex|gemini|openclaw|hermes|all) return 0 ;;
    *) return 1 ;;
  esac
}

yaml_unquote() {
  local value="$1"
  value="${value#\"}"
  value="${value%\"}"
  value="${value#\'}"
  value="${value%\'}"
  printf '%s' "$value"
}

yaml_quote() {
  local value="$1"
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  printf '"%s"' "$value"
}

init_count_vars() {
  converted_antigravity=0; converted_cursor=0; converted_aider=0; converted_kilocode=0
  converted_windsurf=0; converted_opencode=0; converted_augment=0; converted_claudecode=0
  converted_codex=0; converted_gemini=0; converted_openclaw=0; converted_hermes=0
  
  skipped_antigravity=0; skipped_cursor=0; skipped_aider=0; skipped_kilocode=0
  skipped_windsurf=0; skipped_opencode=0; skipped_augment=0; skipped_claudecode=0
  skipped_codex=0; skipped_gemini=0; skipped_openclaw=0; skipped_hermes=0
}

inc_converted() {
  local t="$1"
  case "$t" in
    antigravity) converted_antigravity=$((converted_antigravity + 1)) ;;
    cursor) converted_cursor=$((converted_cursor + 1)) ;;
    aider) converted_aider=$((converted_aider + 1)) ;;
    kilocode) converted_kilocode=$((converted_kilocode + 1)) ;;
    windsurf) converted_windsurf=$((converted_windsurf + 1)) ;;
    opencode) converted_opencode=$((converted_opencode + 1)) ;;
    augment) converted_augment=$((converted_augment + 1)) ;;
    claude-code) converted_claudecode=$((converted_claudecode + 1)) ;;
    codex) converted_codex=$((converted_codex + 1)) ;;
    gemini) converted_gemini=$((converted_gemini + 1)) ;;
    openclaw) converted_openclaw=$((converted_openclaw + 1)) ;;
    hermes) converted_hermes=$((converted_hermes + 1)) ;;
  esac
}

inc_skipped() {
  local t="$1"
  case "$t" in
    antigravity) skipped_antigravity=$((skipped_antigravity + 1)) ;;
    cursor) skipped_cursor=$((skipped_cursor + 1)) ;;
    aider) skipped_aider=$((skipped_aider + 1)) ;;
    kilocode) skipped_kilocode=$((skipped_kilocode + 1)) ;;
    windsurf) skipped_windsurf=$((skipped_windsurf + 1)) ;;
    opencode) skipped_opencode=$((skipped_opencode + 1)) ;;
    augment) skipped_augment=$((skipped_augment + 1)) ;;
    claude-code) skipped_claudecode=$((skipped_claudecode + 1)) ;;
    codex) skipped_codex=$((skipped_codex + 1)) ;;
    gemini) skipped_gemini=$((skipped_gemini + 1)) ;;
    openclaw) skipped_openclaw=$((skipped_openclaw + 1)) ;;
    hermes) skipped_hermes=$((skipped_hermes + 1)) ;;
  esac
}

get_converted() {
  local t="$1"
  case "$t" in
    antigravity) echo "$converted_antigravity" ;;
    cursor) echo "$converted_cursor" ;;
    aider) echo "$converted_aider" ;;
    kilocode) echo "$converted_kilocode" ;;
    windsurf) echo "$converted_windsurf" ;;
    opencode) echo "$converted_opencode" ;;
    augment) echo "$converted_augment" ;;
    claude-code) echo "$converted_claudecode" ;;
    codex) echo "$converted_codex" ;;
    gemini) echo "$converted_gemini" ;;
    openclaw) echo "$converted_openclaw" ;;
    hermes) echo "$converted_hermes" ;;
  esac
}

get_skipped() {
  local t="$1"
  case "$t" in
    antigravity) echo "$skipped_antigravity" ;;
    cursor) echo "$skipped_cursor" ;;
    aider) echo "$skipped_aider" ;;
    kilocode) echo "$skipped_kilocode" ;;
    windsurf) echo "$skipped_windsurf" ;;
    opencode) echo "$skipped_opencode" ;;
    augment) echo "$skipped_augment" ;;
    claude-code) echo "$skipped_claudecode" ;;
    codex) echo "$skipped_codex" ;;
    gemini) echo "$skipped_gemini" ;;
    openclaw) echo "$skipped_openclaw" ;;
    hermes) echo "$skipped_hermes" ;;
  esac
}

extract_frontmatter() {
  local file="$1"
  awk '
    BEGIN { in_fm = 0; name = ""; desc = ""; in_desc_block = 0 }
    function trim(s) { sub(/^[[:space:]]+/, "", s); sub(/[[:space:]]+$/, "", s); return s }
    function dequote(s, first, last) {
      s = trim(s); first = substr(s, 1, 1); last = substr(s, length(s), 1)
      if ((first == "\"" && last == "\"") || (first == "\047" && last == "\047")) {
        s = substr(s, 2, length(s) - 2)
        if (first == "\"") { gsub(/\\\\/, "\\", s); gsub(/\\"/, "\"", s) } else { gsub(/\047\047/, "\047", s) }
      }
      return s
    }
    function append_desc(chunk) {
      chunk = trim(chunk); if (chunk == "") return
      if (desc == "") desc = chunk; else desc = desc " " chunk
    }
    NR == 1 {
      if ($0 == "---") { in_fm = 1; next }
      if ($0 ~ /^# /) {
          name = $0; sub(/^# /, "", name);
          desc = "Documentation and rules for " name;
          exit;
      }
    }
    in_fm == 1 {
      if ($0 == "---") { in_fm = 0; next }
      if (in_desc_block == 1) {
        if ($0 ~ /^[[:space:]]+/ || $0 == "") {
          line = $0; sub(/^[[:space:]]+/, "", line)
          append_desc(line)
          next
        }
        in_desc_block = 0
      }
      if ($0 ~ /^name:[[:space:]]*/) { line = $0; sub(/^name:[[:space:]]*/, "", line); name = dequote(line); next }
      if ($0 ~ /^description:[[:space:]]*/) {
        line = $0; sub(/^description:[[:space:]]*/, "", line); line = trim(line)
        if (line ~ /^>[+-]?$/ || line ~ /^\|[+-]?$/) { in_desc_block = 1; next }
        desc = dequote(line); next
      }
    }
    END { printf "%s\t%s\n", trim(name), trim(desc) }
  ' "$file"
}

extract_body() {
  local file="$1"
  awk '
    BEGIN { in_fm = 0 }
    NR == 1 { if ($0 == "---") { in_fm = 1; next }; print; next }
    in_fm == 1 { if ($0 == "---") { in_fm = 0; next }; next }
    { print }
  ' "$file" | sed '/^© 202/d' | sed '/^---/d' | tr -d '\000-\011\013\014\016-\037\177-\377'
}

copy_supporting_dirs() {
  local src_dir="$1"; local dst_dir="$2"; local d
  for d in scripts references templates; do
    if [[ -d "${src_dir}/${d}" ]]; then cp -R "${src_dir}/${d}" "${dst_dir}/${d}"; fi
  done
}

append_aider_skill() {
  local name="$1"; local description="$2"; local body_file="$3"
  { echo "---"; echo; echo "## ${name}"; echo "> ${description}"; echo; cat "$body_file"; echo; } >> "${AIDER_FILE}"
}

tool_title() {
  case "$1" in
    antigravity) echo "Antigravity" ;; cursor) echo "Cursor" ;; aider) echo "Aider" ;;
    kilocode) echo "Kilo Code" ;; windsurf) echo "Windsurf" ;; opencode) echo "OpenCode" ;;
    augment) echo "Augment" ;; claude-code) echo "Claude Code" ;; codex) echo "OpenAI Codex" ;;
    gemini) echo "Gemini CLI" ;; openclaw) echo "OpenClaw" ;; hermes) echo "Hermes Agent" ;;
  esac
}

write_tool_readme() {
  local tool="$1"; local count="$2"; local out_dir="${OUT_BASE}/${tool}"
  local format_line=""; local manual_install=""; local script_install="./scripts/install.sh --tool ${tool}"
  case "$tool" in
    antigravity)
      format_line='Directory skill bundles: `SKILL.md` plus copied `scripts/`, `references/`, `templates/`.'
      manual_install='Copy each folder to `~/.gemini/antigravity/skills/`.' ;;
    cursor)
      format_line='Flat Cursor rules: `.cursor/rules/<name>.mdc`.'
      manual_install='Copy `integrations/cursor/rules/*.mdc` into `.cursor/rules/`.' ;;
    aider)
      format_line='Single conventions file: `CONVENTIONS.md`.'
      manual_install='Copy `integrations/aider/CONVENTIONS.md` into project root.' ;;
    *)
      format_line='Native Markdown assets.'
      manual_install='Copy assets to the required tool directory.' ;;
  esac
  {
    printf '# %s Integration\n\n' "$(tool_title "$tool")"
    printf 'This directory contains converted Galyarder Framework assets for **%s**.\n\n' "$(tool_title "$tool")"
    printf '## Included Assets\n\n- **%s** assets.\n\n' "$count"
    printf '## Format\n\n%s\n\n## Install\n\n```bash\n%s\n```\n' "$format_line" "$script_install"
  } > "${out_dir}/README.md"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool) TOOL="${2:-}"; shift 2 ;;
    --out) OUT_BASE="${2:-}"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) err "Unknown argument: $1"; usage; exit 1 ;;
  esac
done

if ! is_valid_tool "$TOOL"; then err "Invalid --tool: ${TOOL}"; usage; exit 1; fi

TOOLS="antigravity cursor aider kilocode windsurf opencode augment claude-code codex gemini openclaw hermes"
[[ "$TOOL" != "all" ]] && TOOLS="$TOOL"

SKILLS_TMP="$(mktemp)"
( cd "$REPO_ROOT"
  # SURGICAL FIND: Search across all Department Directories
  DEPT_DIRS="Executive Engineering Growth Security Product Infrastructure Legal-Finance Knowledge"
  for d in $DEPT_DIRS; do
    if [ -d "$d" ]; then
        find "$d" -maxdepth 2 -type f -name "*.md" -not -path './.git/*' | sort
        find "$d" -type f -name 'SKILL.md' -not -path '*/assets/*' -not -path '*/scripts/*' -not -path '*/references/*' -not -path './.git/*' | sort
    fi
  done
) | sort -u > "$SKILLS_TMP"

for t in $TOOLS; do
  rm -rf "${OUT_BASE}/${t}"; mkdir -p "${OUT_BASE}/${t}"
  [[ "$t" =~ ^(cursor|kilocode|augment|openclaw|hermes)$ ]] && mkdir -p "${OUT_BASE}/${t}/rules"
  [[ "$t" =~ ^(windsurf|opencode)$ ]] && mkdir -p "${OUT_BASE}/${t}/skills"
  if [[ "$t" == "aider" ]]; then
    AIDER_FILE="${OUT_BASE}/aider/CONVENTIONS.md"
    { echo "# Galyarder Framework — Aider Conventions"; echo "> Generated: ${TODAY}"; echo; } > "$AIDER_FILE"
  fi
done

init_count_vars

while IFS= read -r rel_path; do
  # Skip plugin manifests
  [[ "$rel_path" =~ plugin.json$ ]] && continue
  [[ "$rel_path" =~ gemini-extension.json$ ]] && continue
  
  src="${REPO_ROOT}/${rel_path#./}"; src_dir="$(dirname "$src")"

  meta="$(extract_frontmatter "$src")"; name="${meta%%$'\t'*}"; description="${meta#*$'\t'}"
  name="$(yaml_unquote "$name")"; description="$(yaml_unquote "$description")"

  if [[ -z "$name" ]]; then
    [[ "$(basename "$src")" == "SKILL.md" ]] && name=$(basename "$src_dir") || name=$(basename "$src" .md)
  fi
  
  if [[ -z "$name" || -z "$description" ]]; then
    for t in $TOOLS; do inc_skipped "$t"; done
    continue
  fi

  # SAFE FILENAME GENERATION
  safe_name=$(echo "$name" | sed 's/[^a-zA-Z0-9_ -]//g' | tr ' ' '-')
  body_tmp="$(mktemp)"; extract_body "$src" > "$body_tmp"

  for t in $TOOLS; do
    case "$t" in
      antigravity)
        out_dir="${OUT_BASE}/antigravity/${safe_name}"; mkdir -p "$out_dir"
        { echo "---"; echo "name: $(yaml_quote "$name")"; echo "description: $(yaml_quote "$description")"; echo "risk: low"; echo "source: internal"; echo "date_added: '${TODAY}'"; echo "---"; cat "$body_tmp"; } > "${out_dir}/SKILL.md"
        copy_supporting_dirs "$src_dir" "$out_dir" ;;
      cursor)
        out_file="${OUT_BASE}/cursor/rules/${safe_name}.mdc"
        { echo "---"; echo "description: $(yaml_quote "$description")"; echo "globs:"; echo "alwaysApply: false"; echo "---"; cat "$body_tmp"; } > "$out_file" ;;
      aider) append_aider_skill "$name" "$description" "$body_tmp" ;;
      kilocode|augment)
        out_file="${OUT_BASE}/${t}/rules/${safe_name}.md"
        { echo "---"; echo "description: $(yaml_quote "$description")"; echo "---"; cat "$body_tmp"; } > "$out_file" ;;
      windsurf|opencode)
        out_dir="${OUT_BASE}/${t}/skills/${safe_name}"; mkdir -p "$out_dir"
        { echo "---"; echo "name: $(yaml_quote "$name")"; echo "description: $(yaml_quote "$description")"; echo "---"; cat "$body_tmp"; } > "${out_dir}/SKILL.md"
        copy_supporting_dirs "$src_dir" "$out_dir" ;;
      openclaw|hermes)
        out_file="${OUT_BASE}/${t}/rules/${safe_name}.md"
        { echo "# ${name}"; echo "> ${description}"; echo; cat "$body_tmp"; } > "$out_file" ;;
      claude-code|codex|gemini)
        if [[ "$(basename "$src")" == "SKILL.md" ]]; then
            mkdir -p "${OUT_BASE}/${t}/skills/${safe_name}"; cp "$src" "${OUT_BASE}/${t}/skills/${safe_name}/SKILL.md"; copy_supporting_dirs "$src_dir" "${OUT_BASE}/${t}/skills/${safe_name}"
        else
            cp "$src" "${OUT_BASE}/${t}/"
        fi
        ;;
    esac
    inc_converted "$t"
  done
  rm -f "$body_tmp"
done < "$SKILLS_TMP"

rm -f "$SKILLS_TMP"

for t in $TOOLS; do write_tool_readme "$t" "$(get_converted "$t")"; done
echo; info "Conversion summary"
for t in $TOOLS; do echo "  ${t}: $(get_converted "$t") converted, $(get_skipped "$t") skipped"; done
echo; ok "Done"
