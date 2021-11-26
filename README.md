# authy-deb-generator

Generates a .deb file from the current snap version of Authy.

Based on the AUR PKGBUILD with the same purpose.

I'll try to keep this repo up to date but it's really only for personal purposes.
If an update comes out and I don't see it please make a PR and I should accept as soon as I see the email.

### NOTE
This requires the following commands to be able to run: `unsquashfs`, `sha256sum`, `wget`, and `dpkg-deb`.
Also, this was designed to run on distros based on Ubuntu, so it may or may not work on stock Debian, modify the dependencies in DEBIAN/control as you need to make it work.

Please make sure you can run these before running the script.
