# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="headline"
# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_DISABLE_RPROMPT=true
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=~/bin:$PATH
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias vim="nvim"
alias branches="for-each-ref --sort=-committerdate refs/heads/ --format='%1B[0;31m%(committerdate:relative)%1B[m%09%(refname:short) [%1B[1;34m%(upstream:short)%1B[m]'"
alias chrome='open -a Google\ Chrome'
alias mergeCodeDiff='git fetch && git merge origin/main && printf "\n----DIFFSTATS----\n" && git diff --stat origin/main && codediff origin/main'
alias mergeDiff='git fetch && git merge origin/main && printf "\n----DIFFSTATS----\n" && git diff --stat origin/main && vdiff origin/main'
alias merge='git fetch && git merge origin/main'
alias bd='git diff main...$(git symbolic-ref --short HEAD)'
alias diff='git diff'
alias staged='git diff --staged'
alias gb='git branch'
alias gbd='git branch -D'
alias gs='git status'
alias gst='git stash'
alias gstat='git stat'
alias gpush='git push'
alias gp='git pull'
alias gc='git commit'
alias gco='git checkout'
alias gcom='git checkout main'
alias gcoom='git checkout origin/main'
alias mwmb='git commit -am "merge with main branch"'
alias gpo='git push origin'
alias gpom='git pull origin/main'
alias gl='git log'
alias tags='git tag --list'
alias gchr="open -a Google\ Chrome"
alias codeDir="cd ~/code"


codeDiff() {
  git diff --full-index $1 $2 $3 $4 $5 >~/temp.diff
  code -n ~/temp.diff
}

codeStageDiff() {
  git diff --staged >~/temp.diff
  code -n ~/temp.diff
}

tempDiff() {
  git diff --full-index $1 $2 $3 $4 $5 >~/temp.diff
  nvim -n ~/temp.diff
}

tempStagedDiff() {
  git diff --staged >~/temp.diff
  nvim -n ~/temp.diff
}

eval "$(fnm env --use-on-cd)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/usr/local/opt/php@7.4/bin:$PATH"

repo() {
  cd ~/code/$1
}


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# bun completions
[ -s "/Users/scottkaye/.bun/_bun" ] && source "/Users/scottkaye/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
