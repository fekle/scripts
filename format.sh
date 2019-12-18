#!/usr/bin/env bash
set -euf -o pipefail

case ${1:-} in
bash)
  FMT="shfmt -i 2 -w -s -l"
  if [[ ${2:-} == "r" ]]; then
    grep --exclude='.*' --exclude-dir='.*' -R -m1 -E '^#!.+(bash|z?sh)$' -l | sort | uniq

    grep --exclude='.*' --exclude-dir='.*' -R -m1 -E '^#!.+(bash|z?sh)$' -l | sort | uniq | xargs -n 10 -P 4 ${FMT}
  elif [[ -f ${2:-} ]]; then
    ${FMT} "${2:-}"
  else
    find ${2:-.} -type f -regex '.*\.\(sh\|zsh\)$' -not -wholename "*/.*"

    find ${2:-.} -type f -regex '.*\.\(sh\|zsh\)$' -not -wholename "*/.*" -print0 | xargs -0 -n 100 -P 4 ${FMT}
  fi
  echo "formatted"
  ;;
help | *)
  echo "usage: s format <bash>"
  ;;
esac
