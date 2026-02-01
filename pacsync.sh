#!/usr/bin/env bash

set -o errexit -o pipefail

pkglist=~/.config/pacsync/pkglist.txt

# gawk to ignore comments
pkgs=$(gawk '
$1 !~ /^#/ {
    print $1
}
' $pkglist)
sudo pacman -S --needed $pkgs

to_remove=$(comm -2 -3 \
    <(pacman -Q --explicit --native --unrequired --quiet | sort) \
    <(echo "$pkgs" | sort)
)
if [ ! -z "$to_remove" ]; then
    sudo pacman -R --recursive --nosave $to_remove
fi
