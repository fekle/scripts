#!/usr/bin/env bash
set -euf -o pipefail

if s device pc; then
  exec watch -tcn0.1 s msensors
else
  exec watch -tcn0.1 sensors
fi
