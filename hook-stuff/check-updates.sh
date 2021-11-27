#!/bin/sh

if [ 0 != $(id -u) ]; then echo "This script must be run as root."; exit 1; fi

dir=$(<"~/.config/snap-check-update-pref")

cd "$dir"

git fetch

out1=$(git log origin/main -n 1)
out2=$(git log -n 1)

if [ "$out1" = "$out2" ]; then
	echo "Snap package up to date!"
else
	git pull
	echo "Snap package not up to date. Download update now? (Y/n)"
	read update
	case $update in
		"n")
			exit 0
			;;
		"N")
			exit 0
			;;
		*)
			./authy-install.sh
			echo "Install snap package update now? (Y/n)"
			read install
			case $install in
				"n")
					exit 0
					;;
				"N")
					exit 0
					;;
				*)
					apt install ./authy.deb
					;;
			esac
			;;
	esac
fi

exit 0
