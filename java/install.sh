#!/bin/bash
#Instalação e configuração do Java-8-oracle

SetupAmbient(){
	cpu=$(uname -m)
	if [ ${cpu} == 'x86_64' ]; then
		arch="x64"
	else
		arch="i586"
	fi
}
JdkVersion(){
	if [ -z jdk8 ];then
		git clone https://aur.archlinux.org/jdk8.git
	fi
}

SetupAmbient
JdkVersion
cd jdk8
makepkg -Acs
cd ..
sudo pacman -U jdk8/jdk8-8u202-1-$cpu.pkg.tar.xz
java -version