# general
alias e="$EDITOR"
alias ls=" ls -lahF --color=auto"
alias ..=" cd .."
alias ...=" cd ../.."

# zsh
alias econf="$EDITOR $ZDOTDIR/.zshrc"
alias rconf="source $ZDOTDIR/.zshrc"

# git
alias ga="git add"
alias gaa="git add ."
alias gs="git status"
alias gd="git diff HEAD"
alias gds="git diff HEAD --staged"
alias gc="git commit"
alias gl="git log"
alias glo="git log --oneline"

# kubernetes
alias get-clusters="kubectl config get-contexts"
alias set-cluster="kubectl config use-context"
alias get-pods="kubectl get pods -A"
