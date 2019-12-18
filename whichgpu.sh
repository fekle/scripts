#!/usr/bin/env bash
set -euf -o pipefail

echo "PCI VGA devices:"
lspci | grep -i VGA
echo ""
echo "currently used renderer:"
glxinfo | egrep "OpenGL vendor|OpenGL renderer"
