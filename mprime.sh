#!/usr/bin/env bash
set -euf -o pipefail

function stop() {
  kill -TERM "${1}"
  i=0
  while kill -0 "${1}" 2>/dev/null; do
    if [[ ${i} -ge 30 ]]; then
      echo "resorting to killing..."
      kill -KILL "${1}"
    fi
    sleep 1
    i=$((i + 1))
  done
  echo "bye!"
}
export -f stop

# go to mprime temp dir
MPRIME_DIR="${MPRIME_DIR:-${HOME}/.local/share/mprime}"
mkdir -p "${MPRIME_DIR}"
cd "${MPRIME_DIR}"

# kill mprime at every signal
trap 'stop ${pid}' HUP INT QUIT ABRT TERM

# start mprime and export script
mprime -t 1 &
export pid=${!}

# wait for mprime
wait ${pid}
