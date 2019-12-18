#!/usr/bin/env bash
set -euf -o pipefail

sudo grub-mkconfig -o /boot/grub/grub.cfg
