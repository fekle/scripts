#!/bin/bash
set -euf

sudo fwupdmgr refresh --force
sudo fwupdmgr update
