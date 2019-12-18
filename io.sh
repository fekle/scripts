#!/usr/bin/env bash
set -euf -o pipefail

sudo -v
sudo iostat -hNt 1
