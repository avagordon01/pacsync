#!/usr/bin/env bash

set -o errexit -o pipefail

pkglist=~/.config/pacsync/pkglist.txt

if ! ./pacsync.sh "$@" &> /dev/null; then
    echo "warning: run pacsync before pacupgrade"
    exit 1
fi

# TODO check arch news
# https://wiki.archlinux.org/title/System_maintenance#Read_before_upgrading_the_system

sudo pacman -Sy

# file 1 is a list of replacements (%R)
# file 2 is the pkglist
tmp=$(mktemp)
gawk '
FILENAME == ARGV[1] {
    if (NF == 2) {
        replaces[$2] = $1;
    }
}
FILENAME == ARGV[2] {
    line = $0;
    if ($1 in replaces) {
        sub($1, replaces[$1], line);
    }
    print line;
}
' \
    <(sudo pacman -Su --print --print-format "%n %R") \
    $pkglist \
    > $tmp
mv $tmp $pkglist

sudo pacman -Su
