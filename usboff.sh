#!/usr/bin/env bash
set -euf -o pipefail

echo "0" >"/sys/bus/usb/devices/usb1/power/autosuspend_delay_ms"
echo "auto" >"/sys/bus/usb/devices/usb1/power/control"
echo "0" >"/sys/bus/usb/devices/usb1/power/autosuspend_delay_ms"
echo "auto" >"/sys/bus/usb/devices/usb1/power/control"
