#!/usr/bin/env bash
set -euf -o pipefail

watch -tn1 grep . -r /sys/firmware/acpi/interrupts/
