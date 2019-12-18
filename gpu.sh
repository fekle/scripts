#!/usr/bin/env bash
set -euf -o pipefail

watch -tn1 "nvidia-smi"
