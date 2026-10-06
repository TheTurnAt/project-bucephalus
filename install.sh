#!/usr/bin/env bash
# Link core/ (agents, skills, AGENTS.md) into an adapter, or into an external
# project's directory for tools that expect a local copy.
#
# Usage:
#   ./install.sh claude-code                 Wire adapters/claude-code to core/ (symlinks)
#   ./install.sh codex                       Wire adapters/codex to core/ (symlinks)
#   ./install.sh codex   <project-dir>       Copy AGENTS.md + skills into a project
#   ./install.sh cursor                      Regenerate adapters/cursor/rules from core/
#   ./install.sh cursor  <project-dir>       Write generated rules into a project's .cursor/rules

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOL="${1:-}"
TARGET="${2:-}"

link() {
  local target="$1" link_path="$2"
  mkdir -p "$(dirname "$link_path")"
  rm -rf "$link_path"
  ln -s "$target" "$link_path"
  echo "linked $link_path -> $target"
}

# Strip a leading YAML frontmatter block (---...---) so it can be replaced
# with the target tool's own frontmatter.
strip_frontmatter() {
  awk '
    NR == 1 && $0 == "---" { infm = 1; next }
    infm && $0 == "---" { infm = 0; next }
    infm { next }
    { print }
  ' "$1"
}

write_cursor_rule() {
  local src="$1" out="$2" description="$3" always="$4"
  {
    echo "---"
    echo "description: $description"
    echo "alwaysApply: $always"
    echo "---"
    echo
    strip_frontmatter "$src"
  } > "$out"
}

case "$TOOL" in
  claude-code)
    link "../../../../core/agents" "$ROOT/adapters/claude-code/plugins/core/agents"
    link "../../../../core/skills" "$ROOT/adapters/claude-code/plugins/core/skills"
    ;;

  codex)
    if [ -n "$TARGET" ]; then
      mkdir -p "$TARGET"
      cp "$ROOT/core/AGENTS.md" "$TARGET/AGENTS.md"
      rm -rf "$TARGET/skills"
      cp -R "$ROOT/core/skills" "$TARGET/skills"
      echo "copied AGENTS.md and skills/ into $TARGET"
    else
      link "../../core/AGENTS.md" "$ROOT/adapters/codex/AGENTS.md"
      link "../../core/skills" "$ROOT/adapters/codex/skills"
    fi
    ;;

  cursor)
    OUT="${TARGET:-$ROOT/adapters/cursor/rules}"
    mkdir -p "$OUT"
    rm -f "$OUT"/*.mdc
    write_cursor_rule "$ROOT/core/AGENTS.md" "$OUT/agents.mdc" \
      "Shared instructions for all agents (source: core/AGENTS.md)" "true"
    for f in "$ROOT"/core/agents/*.md; do
      name="$(basename "$f" .md)"
      write_cursor_rule "$f" "$OUT/$name.mdc" \
        "$name agent role (source: core/agents/$name.md)" "false"
    done
    echo "wrote rules to $OUT"
    ;;

  *)
    echo "Usage: $0 {claude-code|codex|cursor} [project-dir]" >&2
    exit 1
    ;;
esac
