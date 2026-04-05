# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 desktop

EGIT_REPO_URI="https://github.com/black-sliver/PopTracker.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=( '*' '-examples/template_pack' )

DESCRIPTION="Universal, scriptable randomizer tracking solution"
HOMEPAGE="https://github.com/black-sliver/PopTracker"

LICENSE="GPL-3"
# third-party licenses
LICENSE+=" MIT Boost-1.0 BSD-2 ZLIB"
SLOT="0"
RESTRICT="mirror strip"

RDEPEND="
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-ttf
	dev-libs/openssl
"
DEPEND="${RDEPEND}"

src_install() {
	dobin "${S}/build/linux-x86_64/${PN}"
	insinto "/usr/share/${PN}"
	doins -r "${S}/api"
	doins -r "${S}/assets"
	doins -r "${S}/key"
	doins -r "${S}/schema"

	newicon -s 512 "${S}/assets/icon512.png" "${PN}.png"
	newicon -s 64 "${S}/assets/icon.png" "${PN}.png"
	make_desktop_entry --eapi9 \
		"/usr/bin/${PN}" \
		-n PopTracker \
		-i ${PN} \
		-c Game \
		-e "Keywords=randomizer;tracker;" \
		-e "Path=/usr/share/${PN}"
}
