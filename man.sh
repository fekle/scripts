#!/usr/bin/env bash
set -euf -o pipefail

sudo -v

mandb -u

sudo mandb
