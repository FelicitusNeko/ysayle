# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A text-based game creation system."
HOMEPAGE="https://www.digitalmzx.com/"
SRC_URI="https://www.digitalmzx.com/download.php?latest=src&ver=${PV} -> ${P}.tar.xz"

S="${WORKDIR}/mzx$(ver_rs 1-2 '')"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X mikmod modplug +rad sdl3 tremor vorbis +xmp"
REQUIRED_USE="?? ( mikmod modplug xmp ) ?? ( tremor vorbis )"

DEPEND="media-libs/libpng:0
		!sdl3? ( media-libs/libsdl2 )
		sdl3? ( media-libs/libsdl3 )
		vorbis? ( media-libs/libvorbis )
		tremor? ( media-libs/tremor )
		mikmod? ( media-libs/libmikmod )
		X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}"

src_configure() {
	./config.sh \
		--platform unix \
		--prefix "${EPREFIX}"/usr \
		--sysconfdir "${EPREFIX}"/etc \
		--gamesdir "${EPREFIX}"/usr/bin \
		--enable-release \
		$(use_enable X x11) \
		$(use_enable !sdl3 sdl2) \
		$(use_enable sdl3) \
		$(use_enable xmp) \
		$(use_enable mikmod) \
		$(use_enable modplug) \
		$(use_enable rad) \
		$(use_enable vorbis) \
		$(use_enable tremor) \
		--disable-datestamp \
		--disable-mzxrun \
		--disable-updater
}

src_install() {
	emake DESTDIR="${D}" install

	# Rename the documents directory to follow FHS/Gentoo conventions.
	mv "${D}"/usr/share/doc/megazeux "${D}"/usr/share/doc/"${PF}"

	# Un-gzip the documentation so that portage can handle it.
	for f in "${D}"/usr/share/doc/"${PF}"/*.gz; do
		gunzip "${f}"
	done

	# Remove the deprecated "Application" category from the desktop files.
	sed -i "s/Categories=Application;Game;/Categories=Game;/" \
		"${D}"/usr/share/applications/*.desktop
}
