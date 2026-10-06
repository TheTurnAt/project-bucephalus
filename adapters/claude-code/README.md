# adapters/claude-code

Claude Code plugin marketplace wrapper around `core/`. `agents/` and
`skills/` below are symlinks back to the top-level `core/agents` and
`core/skills` — this folder carries no agent content of its own, only the
Claude Code plugin scaffolding and settings profiles.

## Install

In Claude Code:

```
/plugin marketplace add <org>/project-bucephalus
/plugin install core@project-bucephalus
```

Then copy a settings profile from `profiles/` (see `profiles/README.md`).

## Layout

```
.claude-plugin/marketplace.json   Lists the plugins in this adapter
plugins/
  core/
    .claude-plugin/plugin.json
    agents/                       -> ../../../../core/agents
    skills/                       -> ../../../../core/skills
profiles/                         Settings plugins can't carry (env, permissions)
```

Run `../../install.sh claude-code` from this adapter, or `./install.sh
claude-code` from the repo root, to (re)create the `agents`/`skills`
symlinks after pulling changes.

## Using it

Start Claude Code in a folder that contains the repos, then:

> Use the manager agent. Here are today's tasks: ...

Or, with the agent-teams profile:

> Create an agent team led by the manager agent, with one coder per repo.

## Changing agents or skills

Edit the files under `core/` at the repo root, not here — this folder only
links to them. See `docs/ROADMAP.md` for stages and the experiment log.

Never commit secrets. This repo holds instructions, not credentials.
