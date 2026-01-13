# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="A text-based game creation system."
HOMEPAGE="https://www.digitalmzx.com/"
SRC_URI="https://vault.digitalmzx.com/download.php?latest=src&ver=${PV} -> ${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mikmod modplug +rad -sdl3 -tremor vorbis +xmp"
REQUIRED_USE="?? ( mikmod modplug xmp ) ?? ( tremor vorbis )"

DEPEND="media-libs/libpng:0
		!sdl3? ( media-libs/libsdl2 )
		sdl3? ( media-libs/libsdl3 )
		vorbis? ( media-libs/libvorbis )
		tremor? ( media-libs/tremor )
		mikmod? ( media-libs/libmikmod )"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/mzx$(ver_rs 1-2 '')"

src_configure() {
	local mod_conf
	local ogg_conf

	# Music subsystem
	if ! use xmp ; then
		mod_conf="--disable-xmp "
		if use mikmod ; then
			mod_conf+="--enable-mikmod"
		elif use modplug ; then
			mod_conf+="--enable-modplug"
		fi
	fi

	if ! use rad ; then
		rad_conf="--disable-rad"
	fi

	# Sound subsystem
	if ! use vorbis ; then
		ogg_conf="--disable-vorbis "
	fi
	if use tremor ; then
		ogg_conf+="--enable-tremor"
	fi

	./config.sh --platform unix --prefix /usr --sysconfdir /etc --gamesdir /usr/bin $(use_enable sdl3) ${ogg_conf} ${mod_conf} ${rad_conf} --disable-updater
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
	sed -i "s/Categories=Application;Game;/Categories=Game;/" "${D}"/usr/share/applications/*.desktop
}