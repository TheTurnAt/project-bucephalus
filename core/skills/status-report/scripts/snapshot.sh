#!/usr/bin/env bash
# Read-only snapshot of agent branches across repos.
# Usage: snapshot.sh <repo-dir> [<repo-dir> ...]
set -euo pipefail
echo "SNAPSHOT $(date -u +%Y-%m-%dT%H:%MZ)"
for repo in "$@"; do
  name=$(basename "$repo")
  git -C "$repo" fetch --quiet origin 2>/dev/null || echo "  ($name: fetch failed, using local refs)"
  base=main
  git -C "$repo" rev-parse --verify --quiet "$base" >/dev/null || base=master
  branches=$(git -C "$repo" for-each-ref --format='%(refname:short)' 'refs/heads/agent/*')
  [ -z "$branches" ] && { echo "$name: no agent branches"; continue; }
  for b in $branches; do
    sha=$(git -C "$repo" rev-parse --short "$b")
    ahead=$(git -C "$repo" rev-list --count "$base..$b")
    files=$(git -C "$repo" diff --name-only "$base...$b" | wc -l | tr -d ' ')
    if git -C "$repo" rev-parse --verify --quiet "origin/$b" >/dev/null; then
      unpushed=$(git -C "$repo" rev-list --count "origin/$b..$b")
      [ "$unpushed" -eq 0 ] && push="pushed" || push="$unpushed local commit(s) not pushed"
    else
      push="not pushed"
    fi
    echo "$name $b @ $sha  +$ahead commits, $files files, $push"
    git -C "$repo" diff --stat "$base...$b" | tail -1 | sed 's/^/    /'
  done
done
