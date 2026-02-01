#!/usr/bin/env bash

set -o errexit -o pipefail

pkglist=~/.config/pacsync/pkglist.txt

sudo pacman -S --needed $(cat $pkglist)

to_remove=$(comm -2 -3 \
    <(pacman -Q --explicit --native --unrequired --quiet | sort) \
    <(cat $pkglist | sort)
)
if [ ! -z "$to_remove" ]; then
    sudo pacman -R --recursive --nosave $to_remove
fi
