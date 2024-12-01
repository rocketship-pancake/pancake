#!/bin/bash
set -oue pipefail
sudo tee -a /etc/yum.repos.d/mullvad.repo << 'EOF'
[mullvad-beta]
name=Mullvad VPN (beta)
baseurl=https://repository.mullvad.net/rpm/beta/$basearch
type=rpm
enabled=1
gpgcheck=1
gpgkey=https://repository.mullvad.net/rpm/mullvad-keyring.asc
EOF
