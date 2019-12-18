#!/usr/bin/env bash
set -euf -o pipefail

s sync
systemctl hibernate
