# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
LUA_COMPAT=( lua5-{3..5} )
inherit python-single-r1 lua-single flag-o-matic

DESCRIPTION="Fork of TinyFugue, terminal MUD client"
HOMEPAGE="https://github.com/ingwarsw/tinyfugue"
SRC_URI="https://github.com/ingwarsw/tinyfugue/archive/refs/tags/${PV}.tar.gz -> ${P}.tgz"

S="${WORKDIR}/tinyfugue-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+atcp doc +gmcp ipv6 +option102 ssl python lua"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
	lua? ( ${LUA_REQUIRED_USE} )
"
RESTRICT="mirror"

RDEPEND="
	!games-mud/tf
	dev-libs/libpcre2
	sys-libs/ncurses:=
	ssl? ( dev-libs/openssl:0= )
	python? ( ${PYTHON_DEPS} )
	lua? ( ${LUA_DEPS} )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PV}-gcc15.patch"
)

src_configure() {
	append-flags -D_GNU_SOURCE \
		-Wno-error=return-mismatch \
		-Wno-error=implicit-function-declaration \
		-Wno-error=int-conversion \
		-Wno-error=incompatible-pointer-types
	STRIP=: econf \
		$(use_enable atcp) \
		$(use_enable gmcp) \
		$(use_enable option102) \
		$(use_enable ssl) \
		$(use_enable ipv6 inet6) \
		$(use_enable python) \
		$(use_enable lua) \
		--enable-termcap=ncurses
}

src_install() {
	dobin src/tf
	newman src/tf.1.nroffman tf.1

	use doc && HTML_DOCS=( htmldoc/{*.html,commands,topics} )
	einstalldocs

	insinto /usr/share/tf-lib
	# the application looks for this file here if /changes is called.
	# see comments on bug #23274
	doins CHANGES

	insopts -m0755
	doins -r lib/tf/.
	use python && doins -r lib/py/.
	use lua && doins -r lib/lua/.
}
