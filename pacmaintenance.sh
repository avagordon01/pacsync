#!/usr/bin/env bash

set -o errexit -o pipefail

sudo pacman -R --recursive --nosave $(pacman -Q --unrequired --deps --quiet)
pacman -D --check
paccache -r
paccheck --quiet --recursive --depends --db-files
pacdiff
