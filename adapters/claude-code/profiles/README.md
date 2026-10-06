# Profiles

Settings that plugins can't carry, like environment variables and permission
rules. Copy the one you want into `~/.claude/settings.json` (all projects) or a
repo's `.claude/settings.json` (that repo only), merging with what's there.

- `solo.settings.json`: one session at a time, with guardrails.
- `agent-teams.settings.json`: turns on agent teams (experimental) with the
  same guardrails.

Add a profile for each setup you try, and log what you learned in the
experiment log at the bottom of `docs/ROADMAP.md`.
