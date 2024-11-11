#!/bin/zsh
source ~/alias.sh

# Update outdated packages after running brew commands.
function brew() {
  command brew "$@"
}

# History
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HISTIGNORESPACE
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/._zsh_history
setopt inc_append_history share_history

REPORTTIME=10

export FZF_TMUX_OPTS="-p"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

if [ -d /opt/homebrew/Cellar/fzf/*/shell/ ]; then
  source /opt/homebrew/Cellar/fzf/*/shell/key-bindings.zsh
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if which z > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if which starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
