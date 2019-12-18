#!/usr/bin/env bash
set -euf -o pipefail

sudo -v || {
  echo 'permission denied'
  exit 1
}

exec sudo journalctl -a --boot | grep -iC ${1:-3} '\(error\|crit\(ical\)\?\|warn\(ing\)\?\|fatal\)'
