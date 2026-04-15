# Git Worktree Detection

At the start of any session involving code or files, immediately run the following to orient yourself:

## Step 1: Detect the worktree

```bash
git worktree list 2>/dev/null
```

This outputs all worktrees in the format:

```
/path/to/main        abc1234 [main]
/path/to/worktree-a  def5678 [feature/my-branch]
```

## Step 2: Identify the active worktree

Run this to find where you currently are:

```bash
pwd && git rev-parse --show-toplevel 2>/dev/null && git branch --show-current 2>/dev/null
```

Cross-reference `pwd` output with the worktree list to determine which worktree is active.

## Step 3: Surface it to the user

At the top of your first substantive response, briefly state the active worktree and branch, e.g.:

> 📂 Worktree: `/path/to/worktree-a` — branch: `feature/my-branch`

Keep it to one line. Don't make it a big deal — just orient the user so they know you know where you are.

## Edge cases

- **Not a git repo**: Skip silently, don't mention it.
- **Detached HEAD**: Show the commit hash instead of branch name.
- **Only one worktree (main)**: Still show it — the user may have multiple and want confirmation.
- **Git not installed**: Skip silently.
