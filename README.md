# project-bucephalus
A tool-agnostic agent harness: a manager agent that plans and delegates work to coding agents, shared skills, and swappable adapters for Claude Code, Codex, and Cursor. Project context lives outside the repo over MCP, and a feedback loop learns which context each task needs.

A project and model independent framework for directed code development of 1 or more projects.

Goals:
Include:
- Managing Agent personality
- Worker agent personality
- utilize context model
- utilize jev and/or other harnessing methods to save cost w/o sacrificing 
- self improving skill files based on task
- self improving
- loop exiting
- add a librarian agent
- get a CoT log

How the coordination typically works
1.  Context Model monitors project states and detects knowledge gaps (or opportunities).
2.  It formulates a precise request to the Librarian (“Bring high-signal recent info on X that affects Project A’s decision Y, prefer primary sources, score for novelty and relevance”).
3.  Librarian retrieves, filters, deduplicates, summarizes, and tags the material.
4.  Context Model injects the distilled results into the relevant project context(s), updates the shared memory, and may trigger follow-up actions.
5.  Optionally, the Librarian maintains project-specific “shelves” or indexes so future retrievals are faster and more precise.

dev/diagnostic tools:
- dashboard which tracks all the agents you have running
- projects you have running

## Layout

```
core/                 Source of truth, tool-agnostic
  agents/             manager.md, coder.md, reviewer.md
  skills/             SKILL.md folders (Agent Skills format)
  AGENTS.md           Shared instructions (agents.md convention)
adapters/
  claude-code/        Plugin marketplace wrapper (symlinks into core/)
  codex/              AGENTS.md + skills, Codex-ready (symlinks into core/)
  cursor/             Generated .mdc rules exported from core/
docs/
  ROADMAP.md          Stages, future add-ons, experiment log
  starter-lore/       First docs to copy into OpenLore
install.sh            Wires core/ into an adapter or an external project
context.example.yml   Where this project's context lives (MCP URL, repo paths)
```

Edit agents and skills under `core/` only — the adapters link to it and carry
no content of their own except tool-specific wrapping. After changing
`core/`, re-run `./install.sh <claude-code|codex|cursor>` for any adapter
whose symlinks or generated files need refreshing (cursor's `rules/` must be
regenerated; the others are symlinks and update automatically).

Copy `context.example.yml` to `context.yml` and fill in the OpenLore MCP URL
and repo paths for your machine. See `adapters/*/README.md` for how each
tool loads `core/`.


Extra info:

Practical ways to measure

1.  Build a representative evaluation set Create a “golden set” of real or realistic tasks (stratified by difficulty, edge cases, tool needs). Include both happy paths and failure modes. Aim for high coverage of expected behaviors (some teams target ≥70 % of production behaviors).
2.  Log full trajectories Capture every LLM call, tool call (name + arguments + result), intermediate reasoning, and final state. Frameworks that support OpenTelemetry / OpenInference make this easier. Evaluate both the final outcome and the path.
3.  Scoring methods
	•  Deterministic: exact match on final state, unit tests (e.g., code agents), schema validation for tool calls.
	•  LLM-as-judge: for qualitative aspects (reasoning coherence, groundedness, plan quality) with clear rubrics.
	•  Hybrid: best practice.
4.  Run multiple times Because of non-determinism, report success rate + variance or pass^k. Track percentiles for latency and cost, not just means.
5.  Compare architectures fairly Hold the model, tools, and task set constant while varying architecture (ReAct vs. plan-and-execute vs. multi-agent vs. hybrid, different memory, different orchestration, etc.). Measure the full set of metrics above. Also test under cost or step budgets.
6.  Offline + Online Offline: controlled benchmark runs and regression suites in CI. Online: production monitoring of the same metrics on real traffic, with human feedback or automated checks where possible.

Useful public benchmarks (for calibration, not as the sole measure)
•  GAIA — multi-step general assistant tasks requiring tools, web, reasoning.
•  AgentBench — multi-environment (OS, DB, web, household, etc.).
•  SWE-bench / SWE-bench Verified — coding agents.
•  WebArena, τ-bench, OSWorld, etc. for more specialized domains.


Recommended starting set for most teams
1.  Task success rate (verified end-state)
2.  Tool-call correctness (selection + arguments)
3.  Cost per successful task + p95 latency
4.  Steps / tool calls per task (efficiency)
5.  Safety/policy violation rate
6.  Consistency across repeated runs
7.  
Track these over time, cut by task type/difficulty, and treat evaluation as a first-class engineering activity (some elite teams report dedicating ~40 % of agent development effort to it). Once you have reliable numbers on the dimensions above, comparing architectures becomes much clearer than looking only at tokens and wall-clock time.​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
