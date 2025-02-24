#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Download the install script
curl https://rclone.org/install.sh > install-rclone.sh

# Run the install script
bash install-rclone.sh beta

# Install Python keyring
pip install --user keyring

# Download the management script
wget -P /usr/local/bin https://gist.githubusercontent.com/oleduc/b3473b34801f9618b77e579392a12d79/raw/3fa46a7adc9418d59cd0e38b096765e919fc703d/rclone-mount-proton.sh

# Give the script execution permissions
chmod +x /usr/local/bin/rclone-mount-proton.sh
