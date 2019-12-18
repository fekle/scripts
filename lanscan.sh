#!/usr/bin/env bash
set -euf -o pipefail

sudo arp-scan --localnet
