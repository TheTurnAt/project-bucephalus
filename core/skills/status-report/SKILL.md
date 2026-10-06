---
name: status-report
description: Build one status snapshot from git and send the same report to the terminal and to email, so the two never disagree. Use whenever the manager reports progress, lists code changes that are ready to push, sends a daily or ready-for-review email, or finds that an email, the terminal, the tracker, or an agent report disagree.
---

# Status report

## Rule: one snapshot, many views
Do not write the terminal update and the email update separately. Make one
snapshot. Then render the snapshot to the terminal, to email, and to the
tracker. Every view shows the snapshot time and the commit SHAs.

## 1. Make the snapshot
Run `scripts/snapshot.sh <repo-dir> [<repo-dir> ...]` from this skill. The
script lists each `agent/*` branch with:
- the commits ahead of `main`,
- the changed files (diff stat),
- the push state (not pushed, pushed, or local commits ahead of the remote).

Add these items from the task table:
- the reviewer verdict (APPROVE or CHANGES NEEDED),
- the checks that the coder ran and the results.

## 2. Sort each branch into one status
| Status | Condition |
|--------|-----------|
| Ready to push | Reviewer verdict is APPROVE. Checks passed. Branch is not pushed, or has local commits that are not pushed. |
| Pushed | Approved and all commits are on the remote. |
| In review | Coder reported done. No reviewer verdict yet. |
| Changes needed | Reviewer verdict is CHANGES NEEDED. |
| Blocked | The coder or the manager reported a blocker. |
| Mismatch | The sources disagree. See step 3. |

## 3. Resolve disagreements
Use this order of trust. A higher source wins over a lower source:
1. Git: the branches and commits that exist now.
2. Reviewer verdicts.
3. Checks that were run, with their output.
4. The tracker (Linear or Notion).
5. Agent reports.
6. Earlier emails and earlier terminal updates.

Apply these rules:
- An agent reports "done" and git shows no new commits: set the status to
  Mismatch. Do not report the task as done.
- The tracker shows "done" and the branch has no APPROVE verdict: set the
  status to Mismatch. Correct the tracker.
- An earlier email gave a status that is now wrong: add a "Corrections" section
  to the next report. Give the old status, the new status, and the reason.
- The terminal and the email show different data: the snapshot with the later
  time is correct. Send the later snapshot again to the view that is old.

## 4. Render the report
Use the same template for the terminal and for email:

```
STATUS — <snapshot time> — <n> branches

READY TO PUSH
  <repo> agent/<id>-<slug> @ <short sha>  (+<commits> commits, <files> files)
    <one-line summary>. Checks: <result>.
    Push: git -C <repo> push -u origin agent/<id>-<slug>

IN REVIEW / CHANGES NEEDED / BLOCKED
  <repo> <branch> — <one-line reason>

MISMATCH
  <what disagrees and which source wins>

CORRECTIONS
  <earlier statement> → <current statement> (<reason>)
```

Email subject: `[The Turn At] <n> ready to push, <n> blocked — <date>`.

## 5. Limits
- Do not push. List the push command. William pushes or approves the push.
- Do not send an email that is different from the terminal report.
- Keep the report short. One line for each branch, plus one line of detail.
