#!/usr/bin/env bash
set -euf -o pipefail

if [[ -z ${1:-} ]]; then
  echo >&2 "no file specified"
  exit 1
fi

user=$(whoami)

# transcode to h264
sudo nice -n 10 ionice -c 2 -n 5 su ${user} -c "ffmpeg -i '${@}' -c:v libx264 -preset ultrafast -crf 18 '${@}_transcoded.mkv'"
