#!/bin/sh
set -eufx
sudo chown -R "$(id -u):$(id -g)" "${HOME}"
sudo chmod 0750 "${HOME}"
