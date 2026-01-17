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

#IUSE="mtdev"
RESTRICT="strip mirror"

# RDEPEND="
#     dev-python/certifi
#     dev-python/colorama
#     dev-python/cymem
#     dev-python/cython
#     dev-python/Kivy
#     dev-python/jellyfish
#     dev-python/jinja2
#     dev-python/orjson
#     dev-python/platformdirs
#     dev-python/pyyaml
#     dev-python/schema
#     dev-python/typing-extensions
#     dev-python/websockets
#     dev-util/bsdiff
#     x11-misc/xclip
#     x11-misc/xsel
#     mtdev? ( sys-libs/mtdev )
# "
# DEPEND="${RDEPEND}"

MY_DEST=/opt/archipelago

src_install() {
    insinto "${MY_DEST}"
    find "${S}" -maxdepth 1 -type f -exec doins {} \;
    find "${S}" -maxdepth 1 -type d -exec doins -r {} \;

    # this section taken from the PKGBUILD in the AUR
    ebegin "creating shims"
    mkdir -p "${D}/usr/bin"
    while IFS= read -r -d '' i; do
        file="${i##*/}"
        cat <<EOF >"${D}/usr/bin/${file}"
#!/bin/bash
cd /opt/Archipelago
./${file} "\$@"
EOF
        chmod +x "${D}/usr/bin/${file}"
    done < <(find "${S}" -maxdepth 1 -type f -name "Archipelago*" -executable -print0)
    eend $?

    newicon -s 512 data/icon.png archipelagomw.png
    make_desktop_entry --eapi9 \
        /opt/archipelago/ArchipelagoLauncher \
        -n "Archipelago Launcher" \
        -i /usr/share/icons/hicolor/512x512/archipelagomw.png \
        -c "Game;" \
        -e "Keywords=multi-game;randomizer" \
        -e "Path=/opt/archipelago/"
}