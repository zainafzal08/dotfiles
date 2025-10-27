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
  zsh-autosuggestions
  zsh-syntax-highlighting
  # Fast fuzzy search.
  fzf
  # Traverse, query, filter and process json files.
  jq
  # Ls but better. ls gets auto mapped to this in alias.sh
  eza
  # cat but better
  bat
  # Ls but print a tree.
  tree
  # Smarter cd
  zoxide
  # Sexy prompt
  starship
  # git but better
  jj
)
for dep in ${deps[@]}; do
  brew list $dep > /dev/null|| brew install $dep
done

if ! [[ "$SHELL" = *zsh ]]; then
  chsh -s "$(which zsh)"
fi

# Link all the config.
[ -d ~/.config ] || mkdir ~/.config
link starship.toml ~/.config/starship.toml
link bin ~/bin
link zshrc ~/.zshrc
link gitconfig ~/.gitconfig
link wezterm.lua ~/.wezterm.lua
link .vimrc ~/.vimrc
link dircolors ~/.dircolors
link .tmux.conf ~/.config/.tmux.conf
link alias.sh ~/alias.sh

echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
