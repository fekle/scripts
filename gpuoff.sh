#!/usr/bin/env bash

sudo -v

sudo rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia 2>/dev/null
sudo tee /proc/acpi/bbswitch <<<OFF
sudo cat /proc/acpi/bbswitch
