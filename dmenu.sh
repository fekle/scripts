#!/usr/bin/env bash
set -euf -o pipefail

exec j4-dmenu-desktop --dmenu="dmenu -i -fn 'Iosevka:size=14' -nf '#ffffff' -nb '#000000' -sf '#000000' -sb '#ffffff' -l 8"
