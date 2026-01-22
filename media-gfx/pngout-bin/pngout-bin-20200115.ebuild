# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Lossless PNG compressor"
HOMEPAGE="https://www.jonof.id.au/kenutils"
SRC_URI="https://www.jonof.id.au/files/kenutils/pngout-${PV}-linux.tar.gz"
S="${WORKDIR}/pngout-${PV}-linux"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"
RESTRICT="strip mirror"

src_install() {
	use amd64 && dobin amd64/pngout
	use x86 && dobin i686/pngout
	use arm64 && dobin aarch64/pngout
	use arm && dobin armv7/pngout
}
