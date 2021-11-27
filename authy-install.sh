#!/bin/sh

if [ 0 != $(id -u) ]; then echo "This script must be run as root."; exit 1; fi

pkgname=authy
_snapid="H8ZpNgIoPyvmkgxOWw5MSzsXK1wRZiHn"
_snaprev="7"

src="https://api.snapcraft.io/api/v1/snaps/download/${_snapid}_${_snaprev}.snap"
sha256sums="a33f5f40d4bf67ee3800f006aadfa93d396c1150b6d61e416cfad1c1d8215f81  ${_snapid}_${_snaprev}.snap"

prep () {
	echo "Downloading snap"
	echo ""
	echo ""

	wget $src
	appsum=$(sha256sum "${_snapid}_${_snaprev}.snap")

	# Check SHASUMS of downloaded .snap file
	if [ "$sha256sums" = "$appsum" ]; then
		echo "sha256sums identical, continuing"
	else
		echo "sha256sums different, stopping execution"
		echo "Assigned sum: $sha256sums"
		echo "Calculated sum: $appsum"
		exit 1
	fi

	mkdir "unsquashed"
	echo "Unpacking filesystem"
	unsquashfs -f -d "unsquashed" "${_snapid}_${_snaprev}.snap"
}

setup () {
	echo ""
	echo "Beginning setup"

	# Establish directory structure
	mkdir "${pkgname}"
	cd "${pkgname}"
	mkdir "opt"
	mkdir "usr"
	cd "usr"
	mkdir "bin"
	mkdir "share"
	cd "share"
	mkdir "applications"
	mkdir "pixmaps"
	cd "../../opt"
	mkdir "${pkgname}"
	cd "../.."
	
	# Copy package files to proper directories
	cd "unsquashed"
	cp -rf * "../${pkgname}/opt/${pkgname}"
	cp "meta/gui/icon.png" "../${pkgname}/usr/share/pixmaps/authy.png"
	cp "meta/gui/authy.desktop" "../${pkgname}/usr/share/applications"
	cd ..

	# Copy package-manager files and prep for packaging
	cp -rf "./DEBIAN" "./${pkgname}"
	chmod 755 "${pkgname}/DEBIAN/postinst"
	chmod 755 "${pkgname}/DEBIAN/postrm"

	# Remove unused files/directories
	rm -rf "${pkgname}/opt/${pkgname}/data-dir"
	rm -rf "${pkgname}/opt/${pkgname}/gnome-platform"
	rm -rf "${pkgname}/opt/${pkgname}/lib"
	rm -rf "${pkgname}/opt/${pkgname}/meta"
	rm -rf "${pkgname}/opt/${pkgname}/scripts"
	rm -rf "${pkgname}/opt/${pkgname}/usr"
	rm -rf "${pkgname}/opt/${pkgname}/*.sh"
}

package () {
	dpkg-deb --build ${pkgname}

	echo "Cleaning up..."
	rm -rf "unsquashed"
	rm -rf "${pkgname}"
	rm "${_snapid}_${_snaprev}.snap"
}

ask_install() {
	echo "Would you like to run the apt hook installer? (Y/n)"
	read install
	case $install in
		"n")
			exit 0
			;;
		"N")
			exit 0
			;;
		*)
			cd "hook-stuff"
			./install-hook
			;;
	esac
}

prep
setup
package
ask_install
