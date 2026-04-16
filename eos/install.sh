#!/usr/bin/env bash
# Bootstrap script for a fresh EndeavourOS install.
# Installs all dependencies and deploys dotfiles via stow.
# Run from anywhere: bash ~/dotfiles/eos/install.sh

set -euo pipefail

DOTFILES_EOS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Base ---
# stow: used to symlink all dotfiles packages into ~/
sudo pacman -S --needed --noconfirm stow cat btop eza flameshot

# --- Per-tool installs ---
echo ""
for pkg in git kitty tmux vim zsh i3 obs; do
  script="$DOTFILES_EOS/$pkg/install.sh"
  if [[ -f "$script" ]]; then
    echo "==> $pkg"
    bash "$script"
  fi
done

# --- Deploy dotfiles ---
echo ""
echo "==> Deploying dotfiles with stow..."
cd "$DOTFILES_EOS"

for pkg in git kitty tmux vim zsh i3; do
  # If the target already exists as a real directory (not a symlink), remove it
  # so stow can replace it with a symlink. This is safe since the contents are
  # now tracked in this repo.
  target_dir="$HOME/.config/$pkg"
  if [[ -d "$target_dir" && ! -L "$target_dir" ]]; then
    echo "    Removing existing (non-symlinked) $target_dir"
    rm -rf "$target_dir"
  fi
  stow "$pkg"
done

echo ""
echo "Done. Open a new terminal and launch nvim to finish plugin installation."
