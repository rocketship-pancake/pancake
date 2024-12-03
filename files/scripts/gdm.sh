#!/usr/bin/env bash

set -oue pipefail

sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface cursor-theme 'Breeze'
sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface cursor-size 32