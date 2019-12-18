#!/usr/bin/env bash
set -euf -o pipefail

echo "idle" >/sys/block/md0/md/sync_action
echo 0 >/proc/sys/dev/raid/speed_limit_max
