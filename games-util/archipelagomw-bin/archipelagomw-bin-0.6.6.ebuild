# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="Multi-game multiworld randomizer engine and server/client"
HOMEPAGE="https://archipelago.gg/"
SRC_URI="amd64? ( https://github.com/ArchipelagoMW/Archipelago/releases/download/${PV}/Archipelago_${PV}_linux-x86_64.tar.gz )"
S="${WORKDIR}/Archipelago"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="strip mirror"

MY_DEST=/opt/archipelago

src_install() {
	ebegin "copying to /opt"
	insinto "${MY_DEST}"
	find "${S}/" -mindepth 1 -maxdepth 1 -type f -not -executable -exec doins {} \;
	find "${S}/" -mindepth 1 -maxdepth 1 -type d -exec doins -r {} \;
	exeinto "${MY_DEST}"
	find "${S}/" -mindepth 1 -maxdepth 1 -type f -executable -exec doexe {} \;
	eend $?

	# this section taken from the PKGBUILD in the AUR
	ebegin "creating shims"
	mkdir -p "${D}/usr/bin"
	while IFS= read -r -d '' i; do
		file="${i##*/}"
		cat <<EOF >"${D}/usr/bin/${file}"
#!/bin/bash
cd /opt/archipelago
./${file} "\$@"
EOF
		chmod +x "${D}/usr/bin/${file}"
	done < <(find "${S}" -maxdepth 1 -type f -name "Archipelago*" -executable -print0)
	eend $?

	ebegin "creating desktop entry"
	newicon -s 512 data/icon.png archipelagomw.png
	make_desktop_entry --eapi9 \
		/opt/archipelago/ArchipelagoLauncher \
		-n "Archipelago Launcher" \
		-i archipelagomw \
		-c "Game;" \
		-e "Keywords=multi-game;randomizer" \
		-e "Path=/opt/archipelago/"
	eend $?
}
