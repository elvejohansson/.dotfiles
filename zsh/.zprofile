# set up xdg home
export XDG_CONFIG_HOME="$HOME/.config"

# all of these aren't strictly necessary, but let's be explicit in case someone doesn't fallback
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

# move zsh files out of home folder
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
