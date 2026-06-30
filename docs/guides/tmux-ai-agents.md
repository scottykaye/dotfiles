# Managing AI agents with tmux

tmux lets you run many persistent terminal sessions inside one window. For AI
agents this means: one window per agent, they keep running when you detach, and
you flip between them with a keystroke.

## Mental model

```
session "agents"            ← a workspace; survives detach / terminal close
├── window 1  pi            ← like a tab (full screen)
├── window 2  claude        ← another agent
└── window 3  scratch       ← git / tests / logs
    ├── pane (left)         ← splits within a tab
    └── pane (right)
```

- **Session** — named workspace you attach/detach from
- **Window** — a tab
- **Pane** — a split within a tab

Everything is driven by the **prefix key**, then a command key.
This config uses `Ctrl-a` (and `Ctrl-b` still works too).

## Quick start

```bash
agents               # launch/attach session "agents" in the current dir
agents myproj        # session named "myproj"
agents myproj ~/code/foo   # session "myproj" rooted at a path
```

The launcher (`scripts/agents.sh`) opens one window per agent. Edit the
`AGENTS` array in that script to change which agents/commands start.

## Everyday keys (prefix = Ctrl-a)

| Action                        | Keys                         |
|-------------------------------|------------------------------|
| Detach (agents keep running)  | `prefix` then `d`            |
| New agent window              | `prefix` then `c`            |
| Next / previous window        | `Shift+Right` / `Shift+Left` |
| Jump to window N              | `Alt+1`, `Alt+2`, …          |
| Split right / down            | `prefix` then `|` / `-`      |
| Move between panes            | `Alt+Arrow` (or `prefix h/j/k/l`) |
| Resize pane                   | `prefix` then `H/J/K/L`      |
| Rename current window         | `prefix` then `,`            |
| Scroll / copy mode            | `prefix` then `[` (q to exit)|
| Reload config                 | `prefix` then `r`            |
| Mouse: click/scroll/resize    | enabled                      |

A window flashes yellow in the status bar when it has activity — handy for
spotting when an agent finishes while you're looking at another window.

## Detach / reattach (the killer feature)

```bash
# inside tmux: prefix + d  to detach — agents keep working in the background
tls                  # list running sessions  (alias for: tmux ls)
ta agents            # reattach              (alias for: tmux attach -t)
tk agents            # kill a session        (alias for: tmux kill-session -t)
```

Close your terminal, reboot the terminal app, reconnect over SSH — the session
and its running agents are still there. Just `ta <name>` to jump back in.

## Files

- `tmux/.tmux.conf`     → symlinked to `~/.tmux.conf`
- `scripts/agents.sh`   → the session launcher (`agents` alias)
- aliases in `zsh/.zshrc`: `agents`, `tls`, `ta`, `tk`
