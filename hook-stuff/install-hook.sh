#!/bin/sh

if [ 0 != $(id -u) ]; then echo "This script must be run as root."; exit 1; fi

install() {
	cp 05snap-check-update.sh /etc/apt/apt.conf.d
	cd ..
	echo $PWD > ~/.config/snap-check-update-pref
	echo "Installed successfully!"
	echo ""
	echo ""
	echo "PLEASE DO NOT DELETE THE AUTHY-DEB-GENERATOR FOLDER! IT IS REQUIRED TO KEEP THE UPDATER SERVICE WORKING!"
	exit 0
}

uninstall() {
	rm /etc/apt/apt.conf.d/05snap-check-update.sh
	rm ~/.config/snap-check-update-pref
	echo "Removed successfully!"
	exit 0
}

if [ "$(ls -la "/etc/apt/apt.conf.d" | grep snap-update)" = "" ]; then
	echo "Install the apt hook to check for updates? (y/N)"
	read update
	case $update in
		"y")
			install
			;;
		"Y")
			install
			;;
		*)
			exit 0
			;;
	esac
else
	echo "Uninstall the apt hook to check for updates? (y/N)"
	read update
	case $update in
		"y")
			uninstall
			;;
		"Y")
			uninstall
			;;
		*)
			exit 0
			;;
	esac
fi
