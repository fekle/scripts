#!/usr/bin/env bash
set -euf -o pipefail

function timeloop() {
  while true; do
    echo "==="
    echo "LOADTEST: $(date)"
    sensors
    sleep 10
  done
}

timeloop &

mprime -t >/dev/null
