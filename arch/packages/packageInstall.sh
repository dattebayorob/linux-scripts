#!/bin/bash

#Run this from ../packagesInstall.sh
pkgInstall(){
	git clone $pkgGit $pkgPath
	cd $pkgPath
	yes | makepkg -Acs
	sudo pacman -U $pkgInstaller --noconfirm
	cd ../../
}
packageInstall(){
	pkg=$1
	dir="packages/"
	pkgGit=https://aur.archlinux.org/${pkg}.git
	pkgPath=${dir}${pkg}
	pkgInstaller=${pkg}*pkg.tar.xz
	if [ -d ${dir}${pkg} ]; then
		if [ -f $pkgPath/$pkgInstaller ];then
			sudo pacman -U $pkgPath/$pkgInstaller --noconfirm
		else
			cd ${dir}${pkg}
			if ! yes | makepkg -Acs;then
				cd ../../
				rm -rf $pkgPath
				pkgInstall
			else
				cd ../../
				sudo pacman -U $pkgPath/$pkgInstaller --noconfirm
			fi
		fi
	else
		pkgInstall
	fi
}