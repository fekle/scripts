#!/usr/bin/env bash
set -euf -o pipefail

case ${1:-} in
encrypt)
  if [[ ! -f ${2:-} ]]; then
    echo "no such file or director: ${2:-}"
    exit 1
  fi
  gpg -v --cipher-algo AES256 -c "${2}"
  ;;
decrypt)
  if [[ ! -f ${2:-} ]]; then
    echo "no such file or director: ${2:-}"
    exit 1
  fi
  gpg -v --cipher-algo AES256 -d "${2}"
  ;;
*)
  echo "usage: s crypt <encrypt|decrypt> <file>"
  ;;
esac
