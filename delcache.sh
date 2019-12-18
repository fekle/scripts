#!/usr/bin/env bash
set -euf -o pipefail

sudo -v
echo "removing pacman and pacaur cache"
yes y | yay -Scc || true
sudo rm -rf "${HOME}/.cache/pacaur"
