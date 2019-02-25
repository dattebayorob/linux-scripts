#!/bin/bash

#INSTALL PACKAGES, RUN AS NORMAL USER
PACKAGES=$(cat packages/packages.txt | sed ':a;N;$!ba;s/\n/ /g')
for pkg in $PACKAGES; do
	pkg=visual-studio-code-bin
	pkgGit=https://aur.archlinux.org/${pkg}.git
	git clone $pkgGit packages/$pkg
	cd packages/$pkg
	makepkg -Acs
	echo $ENV_PASSWORD | sudo -S pacman -U --noconfirm ${pkg}*pkg.tar.xz
	cd ../../
	echo $ENV_PASSWORD | sudo -S rm -r packages/$pkg
done