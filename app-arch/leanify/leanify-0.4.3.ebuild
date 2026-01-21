# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="lightweight lossless file minifier/optimizer"
HOMEPAGE="https://github.com/JayXon/Leanify"
SRC_URI="https://github.com/JayXon/Leanify/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Leanify-${PV}"
LICENSE="MIT"
# third-party licenses
LICENSE+=" || ( IJG BSD ) public-domain Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip mirror"

src_install() {
	dobin "${S}/leanify"
}
