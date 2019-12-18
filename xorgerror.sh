#!/usr/bin/env bash
set -euf -o pipefail

cat /var/log/Xorg.0.log | grep -E '\((WW|EE|\?\?|NI)\)'
