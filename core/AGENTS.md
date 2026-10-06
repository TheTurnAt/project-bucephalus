# The Turn At — agent instructions

This file is the tool-agnostic entry point for any agent working in this
organization's repos, under the [agents.md](https://agents.md) convention.
`core/` is the source of truth. `adapters/` holds thin, per-tool wrappers that
point back here — see `adapters/*/README.md` for how each tool loads it.

## Who's who
- `agents/manager.md` — plans work, splits it into tasks, assigns them to
  coders, and verifies results. Does not write production code.
- `agents/coder.md` — implements one task, in one repo, on its own branch.
- `agents/reviewer.md` — reviews a branch before the manager calls it done.

Run these as subagents in one session (tools that support it, like Claude
Code), or as the system prompt for separate sessions in tools that don't.

## How every agent works
1. Load context first. Follow `skills/shared-context/SKILL.md`: read the
   system map and known issues before planning or coding. Where this
   project's shared context lives (the OpenLore MCP server, repo paths) is
   configured in `context.yml` at the repo root — copy `context.example.yml`
   to make one.
2. Hand off and report work with the format in
   `skills/task-handoff/SKILL.md`, so nothing is lost between agents.
3. Split multi-step or multi-repo requests with
   `skills/delegate-task/SKILL.md` before assigning anything.
4. Report status with `skills/status-report/SKILL.md`: one snapshot, the
   same report in the terminal, email, and tracker.
5. Write every assignment, report, email, and note in the style of
   `skills/ste-writing/SKILL.md`.

## Guardrails — stop and ask the user before
- Any write to a production database or production config (Render env vars,
  Firebase, App Store Connect, Stripe).
- Deleting data, branches, or accounts.
- Pushing to `main` or merging a PR.
- Anything involving secrets, keys, or passwords.
- Changing scope: if a task turns out bigger than planned, say so and
  re-plan instead of continuing.

Never read or print `.env` values. Record where a secret lives (for example,
"in the password manager under X"), never its value.

## Sources of truth
If updates disagree (an email, the terminal, the tracker, an agent's
report), trust them in this order: git, then reviewer verdicts, then checks
that were actually run, then the tracker, then agent reports, then older
messages. Never report a task as done because an agent said it was done.
See `skills/status-report/SKILL.md`.
