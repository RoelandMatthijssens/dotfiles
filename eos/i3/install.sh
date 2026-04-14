#!/usr/bin/env bash
# All of these ship with the EndeavourOS i3 edition and are likely already present.
# Listed here so a minimal/custom install has everything the i3 config expects.
#
# i3: tiling window manager
# rofi: app launcher ($mod+d) and window switcher ($mod+t)
# picom: compositor — config at ~/.config/picom.conf
# dunst: notification daemon
# feh: sets the desktop wallpaper on startup
# playerctl: media key bindings (play/pause/next/prev)
# scrot: screenshot utility (Print key bindings)
# i3blocks: status bar feeding i3bar (~/.config/i3/i3blocks.conf)
# xss-lock: locks screen on suspend (uses blur-lock script)
# xdg-utils: dex autostart on login (exec --no-startup-id dex --autostart)
sudo pacman -S --needed --noconfirm \
  i3-wm \
  rofi \
  picom \
  dunst \
  feh \
  playerctl \
  scrot \
  i3blocks \
  xss-lock \
  xdg-utils
