# authy-deb-generator

Generates a .deb file from the current snap version of Authy.

Based on the AUR PKGBUILD with the same purpose.

I'll try to keep this repo up to date but it's really only for personal purposes.
If an update comes out and I don't see it please make a PR and I should accept as soon as I see the email.

### Temporary Important Message
Due to an incompatibility with `libc` I have modified the .desktop to run with the `--no-sandbox` flag as a temporary workaround. If you aren't comfortable with running a secure program in an unsecure environment, feel free to remove this flag before running the install script, though keep in mind you may have errors. As soon as the binary is updated to fix this issue I will remove it from the shortcut.

See discussion [here](https://aur.archlinux.org/packages/authy) for updates from anyone who keeps up with this on the AUR.

### NOTE
This requires the following commands to be able to run: `unsquashfs`, `sha256sum`, `wget`, and `dpkg-deb`.

Also - this was designed to run on distros based on Ubuntu, so it may or may not work on stock Debian, modify the dependencies in `DEBIAN/control` as you need to make it work.

Please make sure you can run these before running the script.

I've tested this on the following distros:
- Ubuntu 20.04 LTS
- Ubuntu 18.04 LTS
- Debian 10 (buster) on ChromeOS x86_64
- Pop!\_OS 21.04

## `apt update` Hook
Should you choose to install the `apt update` hook, `hook-stuff/install-hook.sh` will handle all installation and uninstallation. Make sure you ***do not*** move or remove the `authy-deb-generator` repository without first uninstalling the hook, as this could (and will) leave files stranded in your `apt.conf.d` and `/opt` folders.

Installing and uninstalling take less than a second and if you have to dig around that's on you.

<hr>

I am not involved with the development of Authy or with Twilio in any way, nor is this project. This does not edit the application in any way.
