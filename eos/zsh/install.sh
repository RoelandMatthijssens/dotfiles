#!/usr/bin/env bash
# zsh: the shell
# starship: fast Rust-based prompt (git, go, python venv, node, kubectl context)
# fnm: Fast Node Manager — replaces nvm, near-zero startup overhead, reads .nvmrc
# fzf: fuzzy finder — Ctrl+R history search, Ctrl+T file picker
# direnv: per-project environment variables via .envrc files
sudo pacman -S --needed --noconfirm zsh starship fnm fzf direnv

# antidote (plugin manager) is bootstrapped automatically on first shell launch
# via the clone check at the top of .zshrc — no manual install needed

# Set zsh as the default shell if it isn't already
if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo "Setting zsh as default shell..."
  chsh -s "$(which zsh)"
fi
