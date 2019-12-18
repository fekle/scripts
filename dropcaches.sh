#!/usr/bin/env bash
set -euf -o pipefail

sudo -v

sudo sync
sudo su -c 'echo 3 > /proc/sys/vm/drop_caches'
