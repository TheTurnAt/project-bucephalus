# Roadmap

Build in stages. Each stage should work on its own before starting the next.
Each stage is a separate plugin in `plugins/`, so you can turn stages on and off
and compare them.

## Stage 1: Manager + coders (plugin: `core`) — current
- `manager`, `coder`, `reviewer` agents.
- Skills: `delegate-task`, `task-handoff`, `shared-context`, `status-report`,
  `ste-writing`.
- Runs locally, either as subagents in one session or as an agent team
  (`profiles/agent-teams.settings.json`). One repo per coder to avoid file
  conflicts.
- **Done when:** the manager can take three real tasks across two repos, assign
  them, get them reviewed, and report back with no manual copy-pasting between
  terminals.

## Stage 2: Task source (plugin: `tracker`)
- Manager reads its todo list from Linear or Notion over MCP instead of chat.
- Writes status back: in progress, in review, done, blocked, with links to
  branches.
- Skill: `tracker-sync`, mapping tracker statuses to the handoff statuses.
- **Done when:** a bug filed in the tracker becomes a reviewed branch without
  you restating it.

## Stage 3: Project-level understanding (plugin: `project-map`)
- A maintained system map in OpenLore: services, repos, data flows, external
  dependencies, and how they connect (start from
  `docs/starter-lore/system-map.md`).
- Skill: `map-impact`, where the manager checks which pieces a task touches
  before splitting it ("this changes auth, so it affects both apps and the
  backend").
- Skill: `map-maintain`, where agents propose map updates when they learn
  something new.
- **Done when:** the manager catches a cross-repo dependency you didn't mention.

## Stage 4: Always-on (plugin: `remote`)
- Move the manager to a server (Linode) running unattended, triggered by the
  tracker.
- Daily summary email, plus an email when a branch is ready to push. Both come
  from the same `status-report` snapshot as the terminal, so they never
  disagree.
- Hard guardrails: no pushes to main, no production writes, spending cap.
- **Done when:** a week passes with useful branches and no surprises.

## Stage 5: Evaluation
- A small fixed set of real past tasks with known-good outcomes.
- Run them after any change to agents, skills, models, or harness, and record
  pass rate, cost, and time.
- **Done when:** you can say whether a change made things better with numbers,
  not vibes.

---

## Future / add-ons

Ideas to explore once the stages above are stable. Each one should become a
plugin or a profile so it can be tried and compared, not wired in permanently.

### Context model: one model managing memory, skills, and harness
Most setups treat context as something a model *uses*. The idea here is a
model whose job is to *manage* it, across three layers:

- **Memory:** what to load for this task, what to summarize, what to forget,
  what to publish to OpenLore.
- **Skills:** which skills to enable for this task, which are stale, which are
  missing, and drafting new ones from repeated work.
- **Harness:** the loop itself, meaning tools, permissions, turn limits, which
  agents exist and how they hand off. Includes removing rules that newer
  models no longer need.

Open questions:
- Does a separate context manager beat letting the manager agent do it?
- How do you stop it from bloating context instead of trimming it?
- What does it measure to decide a skill or rule is stale?

First experiment: a `context-steward` agent that runs before each manager
session and outputs only the docs and skills to load, then compare task results
with and without it using the Stage 5 evals.

### Dashboards
- Task board: what each agent is doing, status, branch, cost so far.
- Run history: pass rate and cost per task from the Stage 5 evals.
- Inbox review: pending OpenLore notes waiting for approval.

### Harness experiments
- Same agents under different harnesses (Claude Code, the Agent SDK, Codex,
  others) on the Stage 5 task set.
- Keep a profile per harness setup so results are reproducible.

### Research question: do vendors tune models against third-party harnesses?
Hypothesis to test, not a conclusion: a model vendor that also sells its own
harness might have reasons to make its models work best there.

The incentives cut both ways. Vendors also earn from API usage that
third-party harnesses drive, and harness builders are large customers. So treat
this as something to measure:

- Run the same model on the same task set in the vendor's harness, your
  harness, and a minimal raw-API loop. Hold prompts, tools, and limits as equal
  as you can.
- Repeat across model versions. A gap that widens release after release for
  third-party harnesses only would be a signal. A stable or shrinking gap is
  evidence against.
- Separate harness quality from model behavior: a better harness can explain a
  gap without any intent behind it.
- Record results in the experiment log below, with versions and dates.

### The 80% rule (ASD-STE100) — adopted in Stage 1
Karpathy has his agents write in about 80% of ASD-STE100, the Simplified
Technical English standard for aircraft maintenance documents. Implemented as
the `ste-writing` skill. All agent instructions, handoffs, reports, and emails
use it.

Next steps:
- Measure it: compare handoff misreads and rework with and without the skill
  on the Stage 5 tasks.
- Tune the 80%: log which rules agents break most and whether they matter.

---

## Experiment log

| Date | Change | Profile / plugin | Result | Keep? |
|------|--------|------------------|--------|-------|
|      |        |                  |        |       |
