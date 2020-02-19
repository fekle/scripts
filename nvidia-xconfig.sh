#!/usr/bin/env bash
set -euf -o pipefail

#input="/etc/X11/base-xorg.conf"
output="/etc/X11/xorg.conf"

# sudo mv -fv "${output}" "${output}.nvidia-xconfig.bak"
sudo nvidia-xconfig -o "${output}" \
  --cool-bits=28 --color-space=RGB --color-range=FULL -d 24 \
  --composite --prime  \
  --force-composition-pipeline=FORCE-COMPOSITION-PIPELINE \
  --force-full-composition-pipeline=FORCE-FULL-COMPOSITION-PIPELINE
