# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="CLI tracker module player"
HOMEPAGE="https://xmp.sourceforge.net/"
SRC_URI="https://github.com/libxmp/xmp-cli/releases/download/${P}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

RDEPEND="
	media-libs/libxmp
"
DEPEND="${RDEPEND}"
