#!/usr/bin/env bash
set -euf -o pipefail

if s device pc; then
  exec watch -tcn1 's aquaero; s msensors'
else
  exec watch -tcn1 sensors
fi
