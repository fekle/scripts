#!/usr/bin/env bash
set -euf -o pipefail

#input="/etc/X11/base-xorg.conf"
output="/etc/X11/xorg.conf"

NV_PRIME=""

if s device felix-xps; then
  NV_PRIME="--prime"
fi

sudo nvidia-xconfig -o "${output}" \
  --cool-bits=28 --color-space=RGB --color-range=FULL -d 24 \
  --composite ${NV_PRIME} \
  --force-composition-pipeline=FORCE-COMPOSITION-PIPELINE \
  --force-full-composition-pipeline=FORCE-FULL-COMPOSITION-PIPELINE
