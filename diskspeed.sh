#!/usr/bin/env bash
set -euf -o pipefail

# s specific stuff
if ${s_child:-false}; then
  dd
fi

if [[ ${1:-} == "help" ]]; then
  echo " usage: ${0} <file or device> <block size [512]> <block count [1953125]>"
  exit
fi

function clean() {
  printf "\ncleaning up\n"
  rm "${1}"
}
export -f clean

if [[ -z ${1:-} ]]; then
  ${0} help
  exit 1
fi

trap "clean \"${1}\"" TERM INT HUP

printf "\n=> testing write speed\n"
dd if=/dev/zero of="${1}" bs=${2:-512} count=${3:-1953125} status=progress

printf "\n=> testing read speed\n"
dd if="${1}" of=/dev/null bs=${2:-512} count=${3:-1953125} status=progress

clean "${1}"
