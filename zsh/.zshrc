# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Set environment variables and modify $PATH
export ZSH="$HOME/.oh-my-zsh"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PROTO_HOME="$HOME/.proto"
export BUN_INSTALL="$HOME/.bun"

# Modify PATH with important directories
export PATH="$(brew --prefix)/opt/python@3/libexec/bin:/opt/homebrew/opt/libpq/bin:$HOME/go/bin:$HOME/bin:$HOME/.rvm/bin:/usr/local/opt/php@7.4/bin:$BUN_INSTALL/bin:$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

# Set theme for oh-my-zsh
ZSH_THEME="headline"

# Plugins for oh-my-zsh
plugins=(git)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
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
alias diff='git diff'
alias staged='git diff --staged'
alias gds='git diff --staged'
alias gb='git branch'
alias gbd='git branch -D'
alias gs='git status'
alias gsp='git status --porcelain'
alias gst='git stash'
alias gstat='git diff --stat main...HEAD'
alias gstatma='git diff --stat master...HEAD'
alias gnstat='git diff --name-status main...HEAD'
alias gnstatma='git diff --name-status master...HEAD'


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

alias gpu='git push'
alias gp='git pull'
alias gc='git commit'
alias gco='git checkout'
alias gcom='git checkout main'
alias gcoom='git checkout origin/main'
alias gcoma='git checkout master'
alias gcooma='git checkout origin/master'
alias mwmb='git commit -am "merge with main branch"'
alias gpo='git push origin'
alias gpom='git pull origin/main'
alias gpoma='git pull origin/master'
alias gl='git log'
alias glo='git log --oneline'
alias tags='git tag --list'
alias gchr="open -a Google\ Chrome"
alias arc="open -a 'Arc'"
alias codeDir="cd ~/code"

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

# Enable fnm (Node version manager) environment
eval "$(fnm env --use-on-cd)"

# Repository navigation
repo() {
  cd ~/code/$1
}

# Source external configurations (envman and bun)
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
[ -s "/Users/scottkaye/.bun/_bun" ] && source "/Users/scottkaye/.bun/_bun"
[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"


source <(fzf --zsh)
