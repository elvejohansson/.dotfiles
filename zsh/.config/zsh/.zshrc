# colors
autoload -Uz colors && colors

# history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE=~/.histfile
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt appendhistory

export HOMEBREW_NO_ANALYTICS=1

# completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
_comp_options+=(globdots)
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# alias
alias get-clusters="kubectl config get-contexts"
alias set-cluster="kubectl config use-context"
alias get-pods="kubectl get pods -A"

alias ls=" ls -alh --color=auto"
alias ..=" cd .."
alias ...=" cd ../.."

alias ga="git add"
alias gs="git status"
alias gd="git diff HEAD"
alias gds="git diff HEAD --staged"
alias gc="git commit"
alias gl="git log"
alias glo="git log --oneline"

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-fzf-history-search/zsh-fzf-history-search.zsh"
