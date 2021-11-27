#!/bin/sh

install() {
	cp 05snap-check-update.sh /etc/apt/apt.conf.d
	echo "Copied successfully!"
	exit 0
}

uninstall() {
	rm /etc/apt/apt.conf.d/05snap-check-update.sh
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
