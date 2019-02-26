#!/bin/bash

#Run this from ../packagesInstall.sh
packageInstall(){
	pkg=$1
	dir="packages/"
	pkgGit=https://aur.archlinux.org/${pkg}.git
	if echo "Cloning git repository from ${pkgGit}" && git clone $pkgGit ${dir}${pkg} > /dev/null 2>&1; then
		cd ${dir}${pkg}
		makepkg -Acs
		echo $ENV_PASSWORD | sudo -S pacman -U --noconfirm ${pkg}*pkg.tar.xz
		cd ../../
		echo $ENV_PASSWORD | sudo -S rm -r packages/$pkg
	else
		echo "The git repository cant be reached"
	fi
}