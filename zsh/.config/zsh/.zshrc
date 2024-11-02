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

# git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' on branch %b'

# prompt
PROMPT='%~${vcs_info_msg_0_} » '

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

function _session() {
    tmux-sessionizer
}
zle -N _session
bindkey '^e' _session

source "$ZDOTDIR/alias.zsh"

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-fzf-history-search/zsh-fzf-history-search.zsh"
