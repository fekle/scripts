#!/usr/bin/env bash
set -euf -o pipefail

sudo screen -r serialUSB0 || sudo screen -S serialUSB0 /dev/ttyUSB0 115200 8n1
