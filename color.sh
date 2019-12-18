#!/usr/bin/env bash
set -euf -o pipefail

s hasdisplay || exit 0

displaycal-apply-profiles --silent --verify || true
