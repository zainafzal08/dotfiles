#!/bin/bash

set -e

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

if ! command -v brew &> /dev/null
then
  echo "Brew not installed. Installing it..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

deps=(
  # Obvious.
  tmux
  vim
  zsh
  git
  # Fast fuzzy search.
  fzf
  # Traverse, query, filter and process json files.
  jq
  # Ls but better. ls gets auto mapped to this in alias.sh
  eza
  # Ls but print a tree.
  tree
  # Smarter cd
  zoxide
  # Sexy prompt
  starship
)
for dep in ${deps[@]}; do
  brew install $dep
done

if ! [[ "$SHELL" = *zsh ]]; then
  chsh -s "$(which zsh)"
fi

# ZSH - install
pug get zsh github: zsh-users/zsh-autosuggestions
pug get zsh github: zsh-users/zsh-syntax-highlighting


# Npm
curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s lts
sudo npm install -g n
sudo npm install -g typescript-language-server typescript
sudo npm i -g vscode-langservers-extracted

# Link all the config.
mkdir -p ~/.config && touch ~/.config/starship.toml
link bin ~/bin
link .zshrc ~/.zshrc
link .gitconfig ~/.gitconfig
link .wezterm.lua ~/.wezterm.lua
link .vimrc ~/.vimrc
link dircolors ~/.dircolors
link .tmux.conf ~/.config/.tmux.conf