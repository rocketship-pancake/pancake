#!/usr/bin/env bash

set -oue pipefail

wget --content-disposition https://mullvad.net/download/app/rpm/latest
rpm-ostree install MullvadVPN-*.rpm
rm -f MullvadVPN-*.rpm
