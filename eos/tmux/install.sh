#!/usr/bin/env bash
# tmux: terminal multiplexer
# xclip: clipboard integration — used in .tmux.conf copy-mode bindings
#        (bind -T copy-mode-vi y ... copy-pipe-and-cancel 'xclip -selection clipboard')
sudo pacman -S --needed --noconfirm tmux xclip
