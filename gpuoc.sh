#!/usr/bin/env bash
set -euf -o pipefail

if [[ $(hostname) == "pc" ]]; then
  nvidia-settings -l
  nvidia-settings -c "${DISPLAY}" -a '[gpu:0]/GPUMemoryTransferRateOffset[3]=300'
  nvidia-settings -c "${DISPLAY}" -a '[gpu:0]/GPUGraphicsClockOffset[3]=75'
else
  echo "no oc configured for this device."
fi
