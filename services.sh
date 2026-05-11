#!/bin/bash
set -e

# Create symlinks
# https://wiki.archlinux.org/title/Archiso#systemd_units

cd airootfs/etc/systemd/system/

echo "Enabling SDDM and Graphical Target.."
ln -sfv /usr/lib/systemd/system/graphical.target default.target
ln -sfv /usr/lib/systemd/system/sddm.service display-manager.service

echo "Enabling Network Manager..."
ln -sfv /usr/lib/systemd/system/NetworkManager.service multi-user.target.wants/NetworkManager.service
ln -sfv /usr/lib/systemd/system/NetworkManager-wait-online.service network-online.target.wants/NetworkManager-wait-online.service
ln -sfv /usr/lib/systemd/system/NetworkManager-dispatcher.service dbus-org.freedesktop.nm-dispatcher.service
