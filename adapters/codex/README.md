# adapters/codex

Codex adapter for `core/`. `AGENTS.md` and `skills/` below are symlinks back
to the top-level `core/AGENTS.md` and `core/skills` — Codex picks up
`AGENTS.md` automatically from a project root under the
[agents.md](https://agents.md) convention.

The `manager`/`coder`/`reviewer` role files in `core/agents/` are written as
Claude Code subagents (YAML frontmatter with a `tools:` allowlist). Codex has
no subagent concept, so read them as role prompts: paste the relevant one in
as the session's instructions when you want Codex to act as that role, on
top of the shared `AGENTS.md` rules.

## Using it in an external project

Point Codex at this repo's `core/` directly, or copy a local snapshot into
a project that doesn't have this repo checked out:

```
./install.sh codex /path/to/your-project
```

This copies `core/AGENTS.md` and `core/skills/` into the target directory.
Re-run it after `core/` changes — it overwrites the previous copy, it does
not merge.

## Regenerating the symlinks here

```
./install.sh codex
```
