#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service