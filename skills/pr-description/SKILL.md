---
name: pr-description
description: >
  Generate a PR description and push it to GitHub — creating a new PR if one doesn't exist,
  or updating the description if one already exists. Use this skill whenever the user says
  things like "write my PR description", "create a PR", "update my PR", "push a PR description",
  "draft PR", "open a pull request", or asks for help writing or submitting a GitHub PR.
  This skill uses the user's exact template format, infers content from git diff/commits,
  confirms reviewers and test steps before pushing, and never attributes the description to Claude.
  Always trigger this skill proactively when the user wants a PR created or updated on GitHub.
---

# PR Description Skill

You are writing and pushing a professional GitHub pull request description on behalf of the user.
**Never mention Claude or AI in the output.** The PR should read as written by the developer.

---

## Step 1 — Gather Context

Before writing, collect what you need. Use available tools in this order:

1. **Git diff / commits** — Run `git log --oneline -20` and `git diff main...HEAD --stat` (or equivalent base branch) to understand what changed.
2. **Branch name** — Often hints at the ticket/feature (e.g. `feat/checkout-redesign`, `fix/PULSE-123-cart-bug`).
3. **Existing PR** — Use the GitHub MCP to check if a PR already exists for the current branch.
4. **Ask the user** — If context is still thin, ask ONE focused question: "Can you describe what this PR does and why?"

---

## Step 2 — Draft the Full PR Description

**CRITICAL: Draft the COMPLETE description BEFORE asking the user to confirm anything.** The user must see Context, Goal, and all content before being asked to approve.

Use **exactly** this template. Do not add extra sections, do not reorder, do not add a Claude attribution line.

```markdown
## Context

<!-- Context gives us the back story, whats the problem, why are we doing this and how are we solving it -->

[2–4 sentences. What's the problem/why, and how does this PR solve it.]

## Goal

<!-- Summarize quickly the goal real simple keep it title -->

[One tight sentence — what this PR achieves.]

- [x] [specific thing done — tight and clear]
- [x] [specific thing done]
- [x] [add as many bullets as needed, one per meaningful change]

## Reviewers

[confirmed reviewer handles, space-separated on one line with @]

## How was it tested and/or documented?

- [x] [confirmed test method 1]
- [x] [confirmed test method 2]
```

### Writing guidelines

- **Context**: Tell the story — what broke or what was missing, why it matters, how this PR addresses it. No fluff.
- **Goal**: One sentence max. Plain language. E.g. "Add retry logic to the payment processor to reduce failed transactions."
- **Bullets**: Each bullet = one concrete thing done. Tight but meaningful. Use as many as the diff warrants.
- **Reviewers**: Exactly as confirmed. Space-separated on one line.
- **Testing**: Exactly as confirmed. Checked boxes only.

---

## Step 3 — Generate a PR Title

If creating a new PR, also produce a title:

- Format: `[type]: [what it does]` — e.g. `fix: retry failed payment processor calls` or `feat: add checkout flow redesign`
- Keep it under 72 characters
- No ticket numbers unless the user provides one
- No mention of Claude

---

## Step 4 — Present Full Draft for Review

**Always show the COMPLETE PR description first** — rendered as formatted markdown with real headers, bullets, and spacing. Do NOT dump raw escaped text or wrap it in a code block.

After the full description, show the reviewer and testing defaults so the user can edit them:

```
Reviewers: @kyle-steiner @xin-yin @airbnb/pulse
Testing:   Airdev  CI
```

Then present this exact prompt:

---

**How does this look?**

`[ ]` **1. Looks good** — create the PR

`[ ]` **2. Suggest changes** — type your feedback below and I'll revise

---

> "Review the description above. Edit reviewers/testing or suggest any changes, or say 'looks good' to proceed."

Wait for the user's response:

- If they say **"1"**, **"looks good"**, **"lgtm"**, or anything affirmative → mark option 1 as checked (`[✅] 1. Looks good`) and proceed to Step 5.
- If they say **"2"** or type any feedback or suggested changes → mark option 2 as checked (`[✅] 2. Suggest changes`), incorporate their feedback, and loop back to re-display the updated description with the same prompt.
- If they edit the reviewers/testing line, parse their changes and use those values instead.
- Keep looping until the user approves.

---

## Step 5 — Push to GitHub

Use the **GitHub MCP** tool to:

### If no PR exists for this branch

```
Create PR with:
- title: [generated title]
- body: [generated description]
- base: main (or the appropriate base branch)
- head: [current branch]
- draft: false (unless user says draft)
```

### If a PR already exists

```
Update PR body with:
- body: [generated description]
```

Do NOT create a duplicate PR. Always check first.

---

## Step 6 — Confirm to User

After pushing, respond with:

- The PR URL (from the GitHub MCP response)
- Whether it was created or updated
- One line: "PR is live." — nothing more about Claude's involvement.

---

## Error Handling

- If the GitHub MCP isn't connected: tell the user and show them the full description to copy manually.
- If git context is unavailable: ask the user to paste their `git diff --stat` or describe the changes.
- If the branch has no commits ahead of main: flag it before proceeding.

---

## Tone & Voice

Write like the developer who built it. Confident, clear, no filler. Avoid:

- "This PR..." as an opener (start with the context directly)
- Passive voice where active works
- Buzzwords: "leverage", "utilize", "streamline"
- Any mention of AI, Claude, or automation
