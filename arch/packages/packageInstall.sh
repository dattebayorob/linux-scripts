#!/bin/bash

#Run this from ../packagesInstall.sh
packageInstall(){
	pkg=$1
	dir="packages/"
	pkgGit=https://aur.archlinux.org/${pkg}.git
	if echo "Cloning git repository from ${pkgGit}" && git clone $pkgGit ${dir}${pkg} > /dev/null 2>&1; then
		cd ${dir}${pkg}
		yes | makepkg -Acs
		sudo pacman -U --noconfirm ${pkg}*pkg.tar.xz
		cd ../../
		rm -rf packages/$pkg
	else
		echo "The git repository cant be reached"
	fi
}