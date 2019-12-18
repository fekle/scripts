#!/usr/bin/env bash
set -euf -o pipefail

sudo dtermclear
sudo dterm 115200 8 n 1 /dev/ttyUSB0
