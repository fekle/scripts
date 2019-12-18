#!/usr/bin/env bash
set -euf -o pipefail

exec sudo netstat -tlpn
