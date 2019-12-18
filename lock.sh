#!/usr/bin/bash

ISRUNNING="$(ps -aux | rg i3lock | rg -v rg)"

if [[ -z ${ISRUNNING} ]]; then
  exec i3lock -t -e -f -i ~/Pictures/lockscreen.png
fi
