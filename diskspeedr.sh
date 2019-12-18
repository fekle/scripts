#!/usr/bin/env bash
set -euf -o pipefail

# s specific stuff
if ${s_child:-false}; then
  dd
fi

if [[ ${1:-} == "help" ]]; then
  echo " usage: ${0} <file or device> <block size [100M]> <block count [10]>"
  exit
fi

function clean() {
  printf "\ncleaning up...\n"
  rm "${testfile}"
  rm "${randfile}"
}
export -f clean

if [[ -z ${1:-} ]]; then
  ${0} help
  exit 1
fi

trap "clean \"${1}\"" TERM INT HUP EXIT

testfile="${1}"
randfile="$(mktemp)"
bs=${2:-100M}
count=${3:-10}
pcount=$(((count * 110) / 100))

printf "=> creating test file in memory...\n"

dd if=/dev/urandom of=${randfile} iflag=fullblock bs=${bs} count=${pcount} status=progress

printf "\n=> preparation finished\n"

printf "\n=> testing write speed\n"
dd if=${randfile} of=${testfile} iflag=fullblock oflag=direct bs=${bs} count=${count} status=progress

printf "\n=> testing read speed\n"
dd if=${testfile} of=/dev/null iflag=direct bs=${bs} count=${count} status=progress
