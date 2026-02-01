#!/usr/bin/env bash

set -o errexit -o pipefail

pkglist=~/.config/pacsync/pkglist.txt

if ! ./pacsync.sh "$@" &> /dev/null; then
    echo "warning: run pacsync before pacupgrade"
    exit 1
fi

# TODO check arch news
# https://wiki.archlinux.org/title/System_maintenance#Read_before_upgrading_the_system

sudo pacman -Syu
comm -1 \
    <(pacman -Q --explicit --native --quiet | sort) \
    <(cat $pkglist | sort) \
    | sed 's/^\s*//' \
    > $pkglist
