#!/usr/bin/env bash
#
# agents.sh — spin up (or attach to) a tmux session with one window per AI agent.
#
# Each agent gets its own named window so you can flip between them with
# Shift+Left/Right (or prefix + window number) and they keep running even
# after you detach (prefix + d) or close the terminal.
#
# Usage:
#   agents.sh                      # session "agents" in the current directory
#   agents.sh myproj               # session named "myproj"
#   agents.sh myproj ~/code/foo    # session "myproj" rooted at ~/code/foo
#
# Inside tmux:
#   prefix + d         detach (agents keep running in the background)
#   prefix + c         new agent window
#   Shift+Left/Right   switch agent windows
#   prefix + |  / -    split the current window into panes
#   tmux ls            list running sessions
#   agents.sh <name>   reattach to a session later
#
# Customize AGENTS below: "window-name:command". Use an empty command for a
# plain shell you'll start an agent in manually.

set -euo pipefail

SESSION="${1:-agents}"
ROOT="${2:-$PWD}"

# window-name : command-to-run  (empty command = bare shell)
#   - text before the ':'  = the tab name shown in the status bar
#   - text after the ':'   = command to auto-run (empty = plain shell)
AGENTS=(
  "pi:pi"             # main pi agent
  "terminal:"         # plain shell for git, tests, logs, etc.
)

# If the session already exists, just attach (or switch, if already in tmux).
if tmux has-session -t "$SESSION" 2>/dev/null; then
  # Guard against the mirroring gotcha: if this session is already attached
  # somewhere else, warn — viewing one session from two tabs ties them together.
  if [ "$(tmux list-clients -t "$SESSION" 2>/dev/null | wc -l | tr -d ' ')" -ge 1 ] && [ -z "${TMUX:-}" ]; then
    echo "Note: '$SESSION' is already attached in another terminal."
    echo "      Attaching here too will MIRROR them (switching windows affects both)."
    echo "      For an independent workspace, run:  agents <a-different-name>"
  fi
  echo "Session '$SESSION' exists — attaching."
  if [ -n "${TMUX:-}" ]; then
    exec tmux switch-client -t "$SESSION"
  else
    exec tmux attach -t "$SESSION"
  fi
fi

# Create the session detached, with the first agent's window.
first="${AGENTS[0]}"
first_name="${first%%:*}"
first_cmd="${first#*:}"

tmux new-session -d -s "$SESSION" -c "$ROOT" -n "$first_name"
if [ -n "$first_cmd" ]; then
  tmux send-keys -t "$SESSION:$first_name" "$first_cmd" C-m
fi

# Create the remaining agent windows.
for entry in "${AGENTS[@]:1}"; do
  name="${entry%%:*}"
  cmd="${entry#*:}"
  tmux new-window -t "$SESSION" -c "$ROOT" -n "$name"
  if [ -n "$cmd" ]; then
    tmux send-keys -t "$SESSION:$name" "$cmd" C-m
  fi
done

# Land on the first window and attach.
tmux select-window -t "$SESSION:$first_name"
if [ -n "${TMUX:-}" ]; then
  exec tmux switch-client -t "$SESSION"
else
  exec tmux attach -t "$SESSION"
fi
