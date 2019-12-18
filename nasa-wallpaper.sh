#!/bin/dash
set -euf

if [ "${1:-}" = "update" ]; then
  nasa-wallpaper -a
fi

feh --bg-scale $(find ~/.nasa-wallpaper -type f | grep '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]' | sort -h | tail -n1)
