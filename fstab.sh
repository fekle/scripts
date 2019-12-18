#!/usr/bin/env bash
set -euf -o pipefail

genfstab -U / | grep -v '\(/run/\|/sys/\|overlay\|#\|^$\)' | grep -v '#' | sort -d | uniq
