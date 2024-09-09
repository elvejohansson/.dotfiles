# Editor environment
# All of these aren't strictly necessary, but let's be explicit in case someone doesn't fallback
EDIT="$(command -v nvim 2>/dev/null || command -v vim)"
export EDITOR=$EDIT
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Brew
if [[ $(uname) == "Darwin" ]] then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/sbin:$PATH"
    export PATH="/opt/homebrew/opt:$PATH"
    export PATH="/opt/homebrew/include:$PATH"
fi

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
