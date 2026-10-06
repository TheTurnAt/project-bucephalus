# project-bucephalus
A tool-agnostic agent harness: a manager agent that plans and delegates work to coding agents, shared skills, and swappable adapters for Claude Code, Codex, and Cursor. Project context lives outside the repo over MCP, and a feedback loop learns which context each task needs.

## Layout

```
core/                 Source of truth, tool-agnostic
  agents/             manager.md, coder.md, reviewer.md
  skills/             SKILL.md folders (Agent Skills format)
  AGENTS.md           Shared instructions (agents.md convention)
adapters/
  claude-code/        Plugin marketplace wrapper (symlinks into core/)
  codex/              AGENTS.md + skills, Codex-ready (symlinks into core/)
  cursor/             Generated .mdc rules exported from core/
docs/
  ROADMAP.md          Stages, future add-ons, experiment log
  starter-lore/       First docs to copy into OpenLore
install.sh            Wires core/ into an adapter or an external project
context.example.yml   Where this project's context lives (MCP URL, repo paths)
```

Edit agents and skills under `core/` only — the adapters link to it and carry
no content of their own except tool-specific wrapping. After changing
`core/`, re-run `./install.sh <claude-code|codex|cursor>` for any adapter
whose symlinks or generated files need refreshing (cursor's `rules/` must be
regenerated; the others are symlinks and update automatically).

Copy `context.example.yml` to `context.yml` and fill in the OpenLore MCP URL
and repo paths for your machine. See `adapters/*/README.md` for how each
tool loads `core/`.
