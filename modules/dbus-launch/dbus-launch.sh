#!/usr/bin/env bash

set -oue pipefail

dbus-uuidgen > /var/lib/dbus/machine-id

mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface cursor-theme 'Breeze'
sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface cursor-size 32