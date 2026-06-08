---
name: my-docs
description: >
  Save any documentation file to the main worktree's `docs/` directory, never to the
  current worktree or repo root. Use this skill whenever the user asks to "write a doc",
  "create a README", "document X", "write an audit", "draft a feature plan", "write a
  platform doc", or otherwise produce a `.md`, `.mdx`, or `.txt` artifact. The skill
  resolves the main worktree (so docs land in one canonical place regardless of which
  branch/worktree you're working from), routes the file into the correct subfolder
  (`audits/`, `feature-plans/`, `platform/`, `decisions/`, `runbooks/`, `postmortems/`,
  `guides/`, `rfcs/`), and never writes docs to the active worktree's `docs/` folder.
  Always trigger this skill proactively when documentation output is involved.
---

# My Docs

When creating any documentation file, always save it to the **main worktree's** `docs/`
directory — never to the current worktree, never to the repo root.

## Step 1: Resolve the main worktree

The active worktree may be a feature branch checkout (e.g. `~/code/myrepo-feature-x`).
Docs must always land in the main worktree (e.g. `~/code/myrepo/docs/...`).

```bash
# Main worktree path (first entry from `git worktree list`)
MAIN_WT=$(git worktree list --porcelain | awk '/^worktree / {print $2; exit}')
DOCS_ROOT="$MAIN_WT/docs"
```

If `git worktree list` is unavailable or returns nothing, fall back to
`git rev-parse --show-toplevel` and warn the user that the main worktree could not be
resolved.

## Step 2: Route to the correct subfolder

| Doc type                                | Subfolder        |
| --------------------------------------- | ---------------- |
| Audit (security, a11y, perf, code)      | `audits/`        |
| Feature plan / build-out / spec         | `feature-plans/` |
| Platform-level doc (infra, conventions) | `platform/`      |
| ADR — "why we chose X"                  | `decisions/`     |
| On-call / operational procedure         | `runbooks/`      |
| Incident retro                          | `postmortems/`   |
| Onboarding, dev setup, how-to           | `guides/`        |
| Proposal / RFC (pre-feature-plan)       | `rfcs/`          |
| Anything else                           | `docs/` root     |

If the user explicitly names a path, honor it under `$DOCS_ROOT`.

## Step 3: How to choose the right subfolder

Don't keyword-match — classify by **intent and time orientation**. Ask these in order:

1. **Is it a record of something that already happened?**
   - Proactive review with findings → `audits/`
   - Incident retro with root cause + action items → `postmortems/`
2. **Is it about a decision?**
   - Asking "should we do X?" / weighing options / seeking feedback → `rfcs/`
   - Recording "we chose X because Y" (immutable, dated, accepted) → `decisions/`
3. **Is it forward-looking implementation work?**
   - Plan for a specific feature already greenlit → `feature-plans/`
4. **Is it evergreen reference?**
   - How the system / infra / conventions work (audience: engineers reading) → `platform/`
   - Step-by-step procedure for an incident or recurring ops task → `runbooks/`
   - How a _person_ accomplishes a task (onboarding, setup, tutorial) → `guides/`
5. **None of the above?** → `docs/` root (READMEs, glossaries, top-level overviews).

### Definitions (key markers)

| Folder           | Tense / orientation | Marker phrase                             |
| ---------------- | ------------------- | ----------------------------------------- |
| `audits/`        | Past, proactive     | "We reviewed X and found…"                |
| `postmortems/`   | Past, reactive      | "Incident on DATE. Root cause…"           |
| `rfcs/`          | Future, open        | "Proposing X. Alternatives…"              |
| `decisions/`     | Past, immutable     | "Status: Accepted. We chose X because Y." |
| `feature-plans/` | Future, committed   | "Plan to build X. Milestones…"            |
| `platform/`      | Evergreen, system   | "How our deploy pipeline works."          |
| `runbooks/`      | Evergreen, ops      | "If pager fires for X, do these steps."   |
| `guides/`        | Evergreen, human    | "How to set up your dev environment."     |

### Common confusions

- **rfc vs feature-plan** — RFC asks _should we?_; feature-plan answers _how will we?_ (decision already made).
- **rfc vs decision** — RFC is the open question; decision is the closed answer. An accepted RFC often _produces_ a decision record.
- **platform vs guide** — Platform docs describe how the _system_ works (reference); guides describe how a _person_ does a task (tutorial).
- **runbook vs guide** — Runbooks are for ops/incidents ("the system is on fire, do this"); guides are for humans learning ("you're new here, do this").
- **audit vs postmortem** — Audits are proactive reviews; postmortems follow a real incident.

### When unsure, ask

If two folders are plausible and the user hasn't been explicit, ask one short clarifying
question before writing — don't guess. Example: _"Is this a proposal seeking feedback
(`rfcs/`) or a plan for work that's already greenlit (`feature-plans/`)?"_

## Rules

- All `.md`, `.mdx`, `.txt` documentation files go under `$DOCS_ROOT`.
- Always resolve the main worktree first — never write to the current worktree's `docs/`
  unless the current worktree _is_ the main worktree.
- If the user gives a filename without a path, route it by topic into the correct
  subfolder above.
- If the user gives a nested path, preserve it under `$DOCS_ROOT`
  (e.g. `audits/2026-q1-a11y.md`).
- Never save docs to the repo root or anywhere outside `$DOCS_ROOT` unless the user
  explicitly overrides this.

## Example mappings

Assume the main worktree is `~/code/myrepo`.

| User says                            | Save to                                          |
| ------------------------------------ | ------------------------------------------------ |
| "write a README"                     | `~/code/myrepo/docs/README.md`                   |
| "write an a11y audit"                | `~/code/myrepo/docs/audits/a11y-audit.md`        |
| "draft a feature plan for checkout"  | `~/code/myrepo/docs/feature-plans/checkout.md`   |
| "document our deploy pipeline"       | `~/code/myrepo/docs/platform/deploy-pipeline.md` |
| "write an ADR for picking Postgres"  | `~/code/myrepo/docs/decisions/0007-postgres.md`  |
| "add a runbook for the auth outage"  | `~/code/myrepo/docs/runbooks/auth-outage.md`     |
| "write the postmortem for yesterday" | `~/code/myrepo/docs/postmortems/2026-06-07.md`   |
| "create an onboarding guide"         | `~/code/myrepo/docs/guides/onboarding.md`        |
| "draft an RFC for the new API"       | `~/code/myrepo/docs/rfcs/new-api.md`             |
| "create an API guide"                | `~/code/myrepo/docs/api-guide.md`                |
| "write docs/setup.md"                | `~/code/myrepo/docs/setup.md`                    |
