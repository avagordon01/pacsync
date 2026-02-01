#!/usr/bin/env bash

set -o errexit -o pipefail

pkglist=~/.config/pacsync/pkglist.txt

if ! ./pacsync.sh "$@" &> /dev/null; then
    echo "warning: run pacsync before pacupgrade"
    exit 1
fi

xmllint --xpath '//rss/channel/item[position() <= 5]/title[text()]' <(curl https://archlinux.org/feeds/news/)
echo https://archlinux.org/news/
read -p "I have read all relevant arch news notices (press enter to continue or ctrl-c to abort)"

sudo pacman -Sy

# gawk to apply replacements (%R)
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
