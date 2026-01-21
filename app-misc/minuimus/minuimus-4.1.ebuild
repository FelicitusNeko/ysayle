# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Multipurpose lossless file optimizer"
HOMEPAGE="https://birds-are-nice.me/software/minuimus.html"
SRC_URI="https://birds-are-nice.me/software/minuimus.zip -> ${P}.zip"
S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="extra"
RESTRICT="strip mirror"

RDEPEND="
	app-arch/advancecomp
	app-arch/brotli
	|| ( app-arch/p7zip app-arch/7zip )
	app-arch/unrar
	app-arch/zip
	app-text/mupdf
	app-text/poppler
	app-text/qpdf
	dev-lang/perl
	media-gfx/gif2apng
	media-gfx/gif2png
	media-gfx/gifsicle
	media-gfx/imagemagick
	media-gfx/jpegoptim
	media-gfx/optipng
	media-libs/libwebp
	extra? (
		app-arch/leanify
		app-arch/zpaq
		media-libs/jbigkit
	)
"
#        media-gfx/pngout ← Not in Portage
#        MISSING/tif22pnm ← does not compile, leaving out
#        MISSING/pdfsizeopt ← requires Python 2, leaving out
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/unzip
"

PATCHES=(
	"${FILESDIR}/fix_missing_pdfsizeopt_which.patch"
	"${FILESDIR}/minuimus_leanify_keep_icc.patch"
)

src_prepare() {
	cd "${S}"

	ebegin "Patching Imagemagick commands"
	sed -i -e 's/convert-im6/magick/g' minuimus.pl
	sed -i -e 's/identify-im6/magick identify/g' minuimus.pl
	eend $?

	default
}

src_compile() {
	emake all
}

src_install() {
	dobin cab_analyze
	dobin minuimus.pl
	dobin minuimus_def_helper
	dobin minuimus_woff_helper
	dobin minuimus_swf_helper
	ln -s minuimus.pl "${D}/usr/bin/minuimus"
}
