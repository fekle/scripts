#!/usr/bin/env bash
set -euf -o pipefail

if s hasdisplay; then
  systemctl reboot
else
  sudo systemctl reboot
fi
