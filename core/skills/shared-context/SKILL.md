---
name: shared-context
description: How agents read and publish shared team knowledge (OpenLore). Use at the start of any task to load the system map and known issues, and at the end of any task to publish durable learnings. Use it whenever an agent hits a gotcha another agent could hit too.
---

# Shared context

The team's shared knowledge lives on the OpenLore server, exposed to agents as
the `openlore` MCP server.

## Before starting work
1. Read the system map: `/turnat/system-map.md`.
2. Grep known issues for the service, script, or error you're touching:
   `/turnat/known-issues/`.
3. Check decisions that constrain the work: `/turnat/decisions/`.

## After finishing work
Publish anything another agent would need to `/inbox/` as a short note:

```
# <short title>
Date: <YYYY-MM-DD>
Repo: <repo>
What happened: <one or two sentences>
What to do: <the fix or the rule>
```

A human reviews the inbox and moves good notes into the main folders.

## Never publish
Passwords, tokens, keys, connection strings, `.p8` files, or customer data.
Record where a secret lives ("in the password manager under X"), never its
value.
