#!/bin/sh

if [ 0 != $(id -u) ]; then echo "This script must be run as root."; exit 1; fi

userhome=$(getent passwd $SUDO_USER | cut -d: -f6)

install() {
	# Hook and git directory
	cp "05snap-check-update" "/etc/apt/apt.conf.d"
	cd ..
	echo $PWD > "${userhome}/.config/snap-check-update-pref"

	# Hook script
	cd "hook-stuff"
	mkdir "/opt/authy-deb-generator"
	cp "check-updates.sh" "/opt/authy-deb-generator"

	# In case the script is not already marked as executable
	chmod +x "/opt/authy-deb-generator/check-updates.sh"
	
	echo "Installed successfully!"
	echo ""
	echo ""
	echo "PLEASE DO NOT DELETE THE AUTHY-DEB-GENERATOR FOLDER! IT IS REQUIRED TO KEEP THE UPDATER SERVICE WORKING!"
	exit 0
}

uninstall() {
	rm "/etc/apt/apt.conf.d/05snap-check-update"
	rm "${userhome}/.config/snap-check-update-pref"
	rm -rf "/opt/authy-deb-generator"
	echo "Removed successfully!"
	exit 0
}

if [ "$(ls -la "/etc/apt/apt.conf.d" | grep 05snap-check-update)" = "" ]; then
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
