#!/bin/bash
alias f="$EDITOR"
alias :e="$EDITOR"

# Python
alias python="python3"
alias py="python3"

alias :q="exit"

# Global utilities

if [ -d /Users ]; then
  export CLICOLOR=1
  alias ls="ls -G"
  alias finder="open ."
else
  alias ls="ls --color=auto"
  alias grep="grep --color=auto"
  eval "$(dircolors -b ~/.dircolors)"
fi

if which eza > /dev/null 2>&1; then
  alias ls="eza --icons"
fi

if which z > /dev/null 2>&1; then
  alias cd=zoxide
fi

