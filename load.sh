#!/usr/bin/env bash

set -euf -o pipefail

exec sudo nice -n -19 ionice -c 1 -n 0 openssl speed -multi 128
