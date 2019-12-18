#!/usr/bin/env bash
set -euf -o pipefail

case ${1:-} in
battery)
  sudo tlp battery
  ;;
ac | desktop)
  sudo tlp ac
  ;;
help | *)
  echo 'usage: s power <battery|ac/desktop>'
  ;;
esac
