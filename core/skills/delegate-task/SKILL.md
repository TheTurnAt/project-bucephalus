---
name: delegate-task
description: Break a request, bug list, or todo list into scoped tasks with owners, file boundaries, and acceptance criteria. Use whenever the manager plans work, whenever a request touches more than one repo, or whenever the user hands over several things to do at once.
---

# Delegate a task

## 1. Understand before splitting
- Restate the goal in one sentence.
- Read the system map (`shared-context`) to see which pieces are involved:
  backend, resident app, vendor app, admin, infrastructure.
- If the goal is ambiguous in a way that changes the work, ask one question.

## 2. Split
Each task must be:
- **Owned by one agent** and **confined to one repo**.
- **Small**: finishable in one session. If not, split again.
- **Independent where possible**. If B needs A, mark the dependency and
  don't assign B until A is approved.
- **File-bounded**: list the files or directories the agent may change.
  Two tasks may never share files.

## 3. Write acceptance criteria
2 to 5 checkable statements per task. Prefer observable behavior
("Forgot Password returns a resetToken and the app navigates to Reset") over
activity ("fix Verification/index.jsx").

## 4. Assign
Send each task with the `task-handoff` format. Track status in a simple table:

| ID | Task | Repo | Owner | Depends on | Status |
|----|------|------|-------|------------|--------|

Statuses: planned, in progress, in review, changes needed, done, blocked.

## 5. Close out
A task is done only when the reviewer approved it and you checked the
criteria. Report blocked tasks with the reason and what would unblock them.
