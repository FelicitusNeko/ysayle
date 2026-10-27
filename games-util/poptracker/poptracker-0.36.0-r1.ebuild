# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop meson xdg-utils

URI_PV=$(ver_rs 1-3 '-')

DESCRIPTION="Universal, scriptable randomizer tracking solution"
HOMEPAGE="https://github.com/black-sliver/PopTracker"
SRC_URI="https://github.com/black-sliver/PopTracker/releases/download/v${PV}/${PN}_${URI_PV}_full-source.tar.xz -> ${P}.tgz"

S="${WORKDIR}/PopTracker"

LICENSE="GPL-3"
# third-party licenses
LICENSE+=" MIT Boost-1.0 BSD-2 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

RDEPEND="
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-ttf
	dev-libs/openssl
"
DEPEND="${RDEPEND}"

src_install() {
	meson_src_install

	rm "${D}/usr/share/applications/${PN}.desktop"
	rm "${D}/usr/share/icons/${PN}.png"

	newicon -s 512 "${S}/assets/icon512.png" "${PN}.png"
	newicon -s 64 "${S}/assets/icon.png" "${PN}.png"
	make_desktop_entry --eapi9 \
		"${PN}" \
		-n PopTracker \
		-i "${PN}" \
		-c "Game;Utility" \
		-e "Keywords=randomizer;tracker;"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
