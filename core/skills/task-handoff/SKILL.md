---
name: task-handoff
description: The standard format for handing a task to an agent and for reporting back. Use for every assignment from the manager and every completion report from a coder or reviewer, so nothing gets lost between agents.
---

# Task handoff format

## Assignment (manager to coder)

```
TASK <id>: <one-line title>
Repo: <repo name>
Branch: agent/<id>-<slug>
Goal: <one or two sentences on why this matters>
Files you may change: <paths>
Acceptance criteria:
  1. ...
  2. ...
Context: <links to OpenLore docs, known issues, related tasks>
Do not: <anything out of scope or risky>
```

## Report (coder to manager)

```
REPORT <id>: <done | blocked | needs decision>
Changed: <files and a one-line summary each>
Verified: <commands run and results; say "not run" if not run>
Unsure about: <assumptions, edge cases, anything you'd want a human to check>
For other agents: <gotchas worth publishing to shared context>
```

Write both in the style of the `ste-writing` skill. Keep both short. If a report needs more than a screen, the task was too big.
