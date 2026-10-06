# adapters/cursor

Cursor adapter for `core/`. Cursor reads `.mdc` rule files, not
`AGENTS.md`/`SKILL.md` directly, so `rules/` here is generated from
`core/AGENTS.md` and `core/agents/*.md`.

`rules/` is build output. Do not hand-edit it — edit `core/` and regenerate:

```
./install.sh cursor
```

- `agents.mdc` — from `core/AGENTS.md`, `alwaysApply: true`.
- `<agent>.mdc` — one per file in `core/agents/`, `alwaysApply: false`. Attach
  the relevant one manually (or `@`-mention it) when you want Cursor to act
  as that role.

Skills under `core/skills/` are not exported here yet: Cursor rules are a
flatter format than the Agent Skills folder structure (`SKILL.md` plus
scripts), and that conversion needs a real mapping, not a mechanical one.
For now, read a skill's `SKILL.md` directly when a rule tells you to follow
it.

## Writing into an external project

```
./install.sh cursor /path/to/your-project/.cursor/rules
```
