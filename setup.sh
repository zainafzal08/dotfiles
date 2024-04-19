#!/bin/bash

set -e

current="$PWD"

link() {
  local path="$current/$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ]; then
    rm "$dest"
  fi
  echo "$dest -> $path"
  ln -fs "$path" "$dest"
}

link editorconfig ~/.editorconfig

# Generic shell
link shell ~/.shell
link bin ~/.local/df-bin
link shell/env ~/.zshenv
link shell/env ~/.bashenv

# Bash
link bash/bash_profile ~/.bash_profile

# Zsh
link zsh ~/.zsh
link zsh/zshrc ~/.zshrc

# Tmux
link tmux/tmux.conf ~/.tmux.conf

# Git
link git/gitconfig ~/.gitconfig
link git/global-gitignore ~/.global-gitignore
link git/jjconfig.toml ~/.jjconfig.toml

# SSH
link ssh/config ~/.ssh/config

# No login motd
touch ~/.hushlogin

# Yabai
link yabai/yabairc ~/.yabairc

# Configs
link config ~/.config

# Wezterm
link wezterm/.wezterm.lua ~/.wezterm.lua

# Vim
link vim/vimrc ~/.vimrc

link dircolors ~/.dircolors

