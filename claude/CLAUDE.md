# Global Claude Instructions

## Worktree Detection

At the start of any session involving code or files, immediately orient yourself:

1. Run `git worktree list 2>/dev/null` to list all worktrees
2. Run `pwd && git rev-parse --show-toplevel 2>/dev/null && git branch --show-current 2>/dev/null` to identify the active one
3. At the top of your first substantive response, briefly state the active worktree and branch:

   > 📂 Worktree: `/path/to/worktree-a` — branch: `feature/my-branch`
   > Keep it to one line.

**Edge cases:**

- Not a git repo: skip silently
- Detached HEAD: show the commit hash instead of branch name
- Only one worktree: still show it
- Git not installed: skip silently
