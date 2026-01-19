# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Converts gif to apng"
HOMEPAGE="https://sourceforge.net/projects/gif2apng/"
SRC_URI="http://sourceforge.net/projects/$PN/files/${PV}/${P}-src.zip"

S="${WORKDIR}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

RDEPEND="
    media-libs/libpng
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/unzip
"

PATCHES=(
    "${FILESDIR}/10-7z.patch"
    "${FILESDIR}/CVE-2021-45909.patch"
    "${FILESDIR}/CVE-2021-45910.patch"
    "${FILESDIR}/CVE-2021-45911.patch"
)

src_prepare() {
	# strip CR from source file to allow patches to run
	sed 's/\r$//' "${S}/gif2apng.cpp" >"${S}/gif2apng.lf.cpp"
	mv -f "${S}/gif2apng.lf.cpp" "${S}/gif2apng.cpp"

	default
}

src_install() {
	exeinto /usr/bin
	doexe "${S}/gif2apng"
}
