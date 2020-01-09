#!/usr/bin/env bash
set -euf -o pipefail

sudo -v
echo "removing apt cache"
sudo apt autoclean
