# colors
autoload -Uz colors && colors

# Options
setopt autocd
zle_highlight=('paste:none')
stty stop undef
unsetopt BEEP

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

# autocompletion
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

eval "$(/opt/homebrew/bin/brew shellenv)"

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
