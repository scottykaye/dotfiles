autoload -U compinit; compinit

export FZF_BASE=/opt/homebrew/opt/fzf

# Set environment variables and modify $PATH
export ZSH="$HOME/.oh-my-zsh"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PROTO_HOME="$HOME/.proto"
export BUN_INSTALL="$HOME/.bun"
export TERMINFO="$(infocmp -D)"
# Only set JAVA_HOME if a Java runtime is actually installed.
# Note: /usr/libexec/java_home always exists on macOS even with no JDK, and
# prints "Unable to locate a Java Runtime" to stderr — so we check its exit
# status (and silence stderr) instead of just testing that the binary exists.
if [ -x /usr/libexec/java_home ]; then
  _java_home="$(/usr/libexec/java_home -v 1.8 2>/dev/null)"
  if [ -n "$_java_home" ]; then
    export JAVA_HOME="$_java_home"
    export PATH="$JAVA_HOME/bin:$PATH"
  fi
  unset _java_home
fi

# Modify PATH with important directories
# export PATH="$(brew --prefix)/opt/python@3.10/libexec/bin:/opt/homebrew/opt/libpq/bin:$HOME/go/bin:$HOME/bin:$HOME/.rvm/bin:/usr/local/opt/php@7.4/bin:$BUN_INSTALL/bin:$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
else
  BREW_PREFIX=""
fi

export PATH="$BREW_PREFIX/opt/python@3.10/libexec/bin:/opt/homebrew/opt/libpq/bin:$HOME/go/bin:$HOME/bin:$HOME/.rvm/bin:/usr/local/opt/php@7.4/bin:$BUN_INSTALL/bin:$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

# Set theme for oh-my-zsh
ZSH_THEME="headline"
# If we don't symlink: https://github.com/Moarram/headline/blob/main/docs/Installation.md#oh-my-zsh
# ZSH_THEME="headline/headline"

# Plugins for oh-my-zsh
plugins=(git)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# --- Fix 2: throttle the headline prompt's per-command git work ---
# headline runs `git status` + a stash `rev-list` synchronously in precmd on
# EVERY prompt (no async mode), slow in very large repos. We don't need fresh git
# state after every keystroke/Enter — so cache the computed status string per
# repo with a short TTL. The prompt reuses the cached value until it expires,
# then refreshes once. This keeps the prompt instant while still updating.
_HEADLINE_STATUS_TTL=3   # seconds; lower = fresher, higher = snappier
typeset -gA _HEADLINE_STATUS_CACHE _HEADLINE_STATUS_TS
headline_git_status_cached() {
  emulate -L zsh
  local gitdir now key cached ts
  gitdir="$(GIT_OPTIONAL_LOCKS=0 command git rev-parse --git-dir 2>/dev/null)" || { headline_git_status; return; }
  key="$gitdir"
  now=$EPOCHSECONDS
  ts=${_HEADLINE_STATUS_TS[$key]:-0}
  if (( now - ts < _HEADLINE_STATUS_TTL )) && [[ -n ${_HEADLINE_STATUS_CACHE[(e)$key]+x} ]]; then
    print -r -- "${_HEADLINE_STATUS_CACHE[$key]}"
    return
  fi
  local fresh; fresh="$(headline_git_status)"
  _HEADLINE_STATUS_CACHE[$key]="$fresh"
  _HEADLINE_STATUS_TS[$key]=$now
  print -r -- "$fresh"
}
zmodload zsh/datetime 2>/dev/null   # provides $EPOCHSECONDS
HEADLINE_GIT_STATUS_CMD='headline_git_status_cached'

# Aliases
vim() {
  if [[ "$1" =~ ':' ]]; then
    local file="${1%%:*}"
    local line="${1##*:}"
    nvim "+${line}" "$file"
  else
    nvim "$@"
  fi
}
alias branches="for-each-ref --sort=-committerdate refs/heads/ --format='%1B[0;31m%(committerdate:relative)%1B[m%09%(refname:short) [%1B[1;34m%(upstream:short)%1B[m]'"
alias chrome='open -a Google\ Chrome'
alias mergeCodeDiff='git fetch && git merge origin/main && printf "\n----DIFFSTATS----\n" && git diff --stat origin/main && codediff origin/main'
alias mergeDiff='git fetch && git merge origin/main && printf "\n----DIFFSTATS----\n" && git diff --stat origin/main && tempDiff origin/main'
alias mergeDiffMaster='git fetch && git merge origin/master && printf "\n----DIFFSTATS----\n" && git diff --stat origin/master && tempDiff origin/master'
alias merge='git fetch && git merge origin/main'
alias mergeMaster='git fetch && git merge origin/master'
alias rebaseMaster='git fetch && git rebase origin/master'
alias rebase='git fetch && git rebase origin/main'
alias bd='git diff main...$(git symbolic-ref --short HEAD)'
alias bda='git diff master...$(git symbolic-ref --short HEAD)'
alias bdat='git diff master...$(git symbolic-ref --short HEAD) -- . ":!*test*" ":!*spec*" ":!**/__tests__/*"'
alias diff='git diff'
alias staged='git diff --staged'
alias gds='git diff --staged'
alias gdst='git diff --staged . ":!*test*" ":!*spec*" ":!**/__tests__/*"'
alias gb='git branch'
alias gbd='git branch -D'
alias gs='git status'
alias gr='git reset'
alias gsp='git status --porcelain'
alias gst='git stash'
alias gsta='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gspush='git stash push'
alias gsmpu="git stash push -m"
alias gstsp='git stash show -p'
alias gstat='git diff --stat main...HEAD'
alias gstatma='git diff --stat master...HEAD'
alias gnstat='git diff --name-status main...HEAD'
alias gnstatma='git diff --name-status master...HEAD'
alias fp='git push --force-with-lease'
alias fpo='git push --force-with-lease origin'
alias gre='git rebase'
alias grec="git rebase --continue"
alias gagrec="git add . && git rebase --continue"


stackedDiff() {
  local branch="${1:-main}"
  git diff --full-index "$branch"...$(git symbolic-ref --short HEAD)
}

stat() {
  local branch="${1:-main}"
  git diff --stat "$branch"...HEAD
}

statma() {
  local branch="${1:-master}"
  git diff --stat "$branch"...HEAD
}

nstat() {
  local branch="${1:-main}"
  git diff --name-status "$branch"...HEAD
}

nstatma() {
  local branch="${1:-master}"
  git diff --name-status "$branch"...HEAD
}

mergeStackedPR() {
  git fetch && git merge origin/"$1"
}

rebaseStackedPR() {
  git fetch && git rebase origin/"$1"
}

bdaNoTests() {
  local branch="${1:-master}"
  git diff "$branch"...$(git symbolic-ref --short HEAD) -- . ':!*test*' ':!*spec*' ':!**/__tests__/*'
}

gdsNoTests() {
  local branch="${1:-master}"
  git diff --staged . ':!*test*' ':!*spec*' ':!**/__tests__/*'
}

gstpm() {
  git stash push -m "$1"
}

rebase_origin () {
	git fetch origin master && git rebase origin/master && git update-ref refs/heads/master origin/master
}


# tmux / AI agent session helpers
alias agents='~/code/dotfiles/scripts/agents.sh'   # launch/attach the agents session
alias dotfiles-public='~/code/dotfiles/scripts/export-public.sh'  # build sanitized public dotfiles
alias tls='tmux ls'                                 # list running tmux sessions
alias ta='tmux attach -t'                           # ta <name> to reattach
alias tk='tmux kill-session -t'                     # tk <name> to kill a session

alias gpu='git push'
alias gp='git pull'
alias gf='git fetch'
alias gfa='git fetch --all'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gm='git merge'
alias gcp='git cherry-pick'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grs='git restore --staged'
alias gr='git restore'
alias gbl='git blame'
alias gsw='git switch'
alias gswc='git switch -c'
alias gco='git checkout'
alias gcom='git checkout main'
alias gcoom='git checkout origin/main'
alias gcoma='git checkout master'
alias gcooma='git checkout origin/master'
alias mwmb='git commit -am "merge with main branch"'
alias gpo='git push origin'
alias gpuo='git pull origin'
alias gpuom='git pull origin/main'
alias gpuoma='git pull origin/master'
alias gl='git log'
alias glo='git log --oneline'
alias tags='git tag --list'
alias gchr="open -a Google\ Chrome"
alias arc="open -a 'Arc'"
alias codeDir="cd ~/code"


blameurl() {
  local file="$1"
  local line="$2"
  local hash=$(git blame -L "$line,$line" "$file" | awk '{print $1}')
  gh browse "$hash"
}

dropStashes() {
  local start=$1
  local end=$2

  # Delete from highest to lowest to avoid reindex issues
  for i in $(seq $end -1 $start); do
    git stash drop stash@{$i}
  done
}

# Git diff functions
codeDiff() {
  git diff --full-index $1 $2 $3 $4 $5 > ~/temp.diff
  code -n ~/temp.diff
}

codeStageDiff() {
  git diff --staged > ~/temp.diff
  code -n ~/temp.diff
}

tempDiff() {
  git diff --full-index $1 $2 $3 $4 $5 > ~/temp.diff
  nvim -n ~/temp.diff
}

tempStagedDiff() {
  git diff --staged > ~/temp.diff
  nvim -n ~/temp.diff
}

# Repository navigation
repo() {
  cd ~/code/$1
}

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
  fnm use --silent-if-unchanged 2>/dev/null || true
fi


[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
[ -s "/Users/scottkaye/.bun/_bun" ] && source "/Users/scottkaye/.bun/_bun"


# --- fzf: use fd, skip the giant directories ---
if command -v fd >/dev/null 2>&1; then
  _FD_OPTS='--hidden --follow --exclude .git --exclude node_modules'
  export FZF_DEFAULT_COMMAND="fd --type f $_FD_OPTS"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d $_FD_OPTS"
fi
# Sensible default UI + previews
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

if [ -f $HOME/code/dotfiles/.env ]; then
  source $HOME/code/dotfiles/.env
fi


# autoload -U compinit; compinit

# ===========================
# zsh-autosuggestions
# ===========================
# Suggest commands from history as you type
# Install: https://github.com/zsh-users/zsh-autosuggestions
if [ -f ~/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Optional: make autosuggestions lighter or dim
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# ===========================
# zsh-autocomplete
# ===========================
# Fish-style autocomplete for commands, options, and arguments
# Install: https://github.com/marlonrichert/zsh-autocomplete
# Must be sourced last
# Optional tweak for Ghostty rendering
zstyle ':autocomplete:*' floating-menu false

# --- zsh-autocomplete: stop racing on every keystroke ---
zstyle ':autocomplete:*' delay 0.4          # wait before triggering (raised: less per-keystroke work)
zstyle ':autocomplete:*' min-input 3        # need ≥3 chars before completing (skips ga/gl/gco)
zstyle ':autocomplete:*' recent-dirs no     # skip slow dir history scans
zstyle ':autocomplete:*' list-lines 8       # cap menu render cost

# --- Fix 1: tame git completion in huge repos (large monorepos have many refs) ---
# Don't let autocomplete enumerate/sort thousands of refs live as you type.
zstyle ':autocomplete:*' max-lines 8                 # hard cap candidates rendered
zstyle ':autocomplete:tab:*' insert-unambiguous yes  # Tab inserts common prefix instead of full live list
zstyle ':autocomplete:tab:*' widget-style menu-select
# Only build the expensive ref/file lists on an explicit <Tab>, never live.
zstyle ':autocomplete:*' fzf-completion no
# Cap and cache the standard completer so git ref listing isn't recomputed per keystroke.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' gain-privileges 0

# --- Improve git typing latency (e.g. inside `git commit -m "…"`) ---
# zsh-autocomplete fires the completer on every keystroke; for git that can
# touch refs in huge repos and stall while you type a commit message.
# 1) Don't auto-list completions live for git — require an explicit <Tab>.
zstyle ':autocomplete:*:git' list-lines 0
# 2) When the current word is a quoted string (e.g. a commit message), there
#    is nothing useful to complete, so suppress completion there entirely.
#    `ignored-input` is matched (extended-glob) against $words[CURRENT].
#    Build the ["'] character class from vars to avoid quoting headaches.
_ac_dq='"'; _ac_sq="'"
zstyle ':autocomplete:*' ignored-input "[${_ac_dq}${_ac_sq}]*"
unset _ac_dq _ac_sq
# 3) Make git's own completer lazy/cached so ref enumeration isn't recomputed.
zstyle ':completion:*:git:*' use-cache on
zstyle ':completion:*:git-commit:*' command ':'   # no-op completer for commit message context

if [ -f ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
  source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# Restore fzf Ctrl+R (zsh-autocomplete overrides it)
bindkey '^R' fzf-history-widget


