#!/usr/bin/env bash
# obs-studio: screen/audio recorder and live streaming tool
# dkms: framework that auto-rebuilds kernel modules after kernel updates
sudo pacman -S --needed --noconfirm obs-studio dkms

# v4l2loopback-dkms: virtual V4L2 loopback device used by OBS virtual camera.
# The -dkms variant ensures the kernel module is automatically rebuilt
# whenever the kernel is updated, so the virtual camera survives pacman -Syu.
# linux-headers must be installed for DKMS to build against (already in main install).
yay -S --needed --noconfirm v4l2loopback-dkms

# --- v4l2loopback module options ---
# exclusive_caps=1  required for apps like Discord, Chrome, and Firefox to
#                   recognize the virtual camera as a proper V4L2 capture device.
# video_nr=10       pins the device to /dev/video10, keeping it stable and
#                   separate from real webcams which land at /dev/video0-2.
# card_label        human-readable name shown in app device lists.
echo "options v4l2loopback devices=1 video_nr=10 card_label=\"OBS Virtual Camera\" exclusive_caps=1" \
  | sudo tee /etc/modprobe.d/v4l2loopback.conf

# --- auto-load at boot ---
echo "v4l2loopback" | sudo tee /etc/modules-load.d/v4l2loopback.conf

# Load the module immediately without rebooting.
# Options are read from /etc/modprobe.d/ automatically.
sudo modprobe v4l2loopback
