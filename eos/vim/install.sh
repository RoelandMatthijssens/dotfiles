#!/usr/bin/env bash
# neovim: text editor (config requires v0.12+)
# tree-sitter-cli: required by nvim-treesitter v1.0 to compile parsers locally
#                  (must be installed via pacman, NOT npm)
sudo pacman -S --needed --noconfirm neovim tree-sitter-cli
