#!/usr/bin/env bash
#? update system with apt and snap
set -euf -o pipefail

s sudoprompt "root permissions needed to update system packages"

sudo apt update && sudo apt full-upgrade

sudo snap refresh
