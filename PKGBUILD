# Maintainer: Ava Gordon <avagordon01@gmail.com>
pkgname=pacdsync-git
pkgver=r6.9b23d86
pkgrel=1
pkgdesc="declarative pacman scripts"
arch=(any)
url="https://github.com/avagordon01/pacdsync"
license=('GPL')
groups=()
depends=(pacman-contrib pacutils gawk bash pacman libxml2 coreutils)
makedepends=(git)
provides=("${pkgname%-git}")
conflicts=("${pkgname%-git}")
replaces=()
backup=()
options=()
install=
source=("git+$url.git")
noextract=()
sha256sums=('SKIP')

pkgver() {
	cd "$srcdir/${pkgname%-git}"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

prepare() {
	cd "$srcdir/${pkgname%-git}"
}

build() {
	cd "$srcdir/${pkgname%-git}"
}

check() {
	cd "$srcdir/${pkgname%-git}"
}

package() {
	cd "$srcdir/${pkgname%-git}"
	mkdir -p $pkgdir/usr/bin
	cp pacdsync.sh $pkgdir/usr/bin/pacdsync
	cp pacdupgrade.sh $pkgdir/usr/bin/pacdupgrade
}
