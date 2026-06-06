#!/usr/bin/env bash
# Symlink dotfiles into ~/.config
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"

link() {
  local src="$DOTFILES/$1" dst="$CONFIG/$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  backup: $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "  linked: $dst → $src"
}

link_dir() {
  local src="$DOTFILES/$1" dst="$CONFIG/$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -d "$dst" ]; then
    echo "  backup: $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "  linked: $dst → $src"
}

echo "Installing dotfiles from $DOTFILES"
link alacritty/alacritty.toml  alacritty/alacritty.toml
link zellij/config.kdl         zellij/config.kdl
link zellij/themes/one-dark.kdl zellij/themes/one-dark.kdl
link aerospace/aerospace.toml  aerospace/aerospace.toml
link ghostty/config            ghostty/config
link tmux/tmux.conf            tmux/tmux.conf
link_dir nvim                  nvim
echo "Done"
