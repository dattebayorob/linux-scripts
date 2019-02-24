#!/bin/bash
#Instalação e configuração do Java-8-oracle

SetupAmbient(){
	cpu=$(uname -m)
	if [ ${cpu} == 'x86_64' ]; then
		arch="x64"
	else
		arch="i586"
	fi


	if [ ! -d /usr/lib/jvm ]; then
		mkdir -p /usr/lib/jvm
	else
		rm -rf /usr/lib/jvm/*
	fi
	if [ ! -d $arch ]; then
		mkdir $arch
	fi
}
JdkVersion(){
	if [ -z $(ls $1) ];then
		wget -c -P $1 --no-cookies --no-check-certificate --header \
			"Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;"\
			"https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-${1}.tar.gz"
	fi
	jdk="jdk1."$(ls $1 | awk '{print substr($0,5,1),substr($0,7,3)}' | sed 's/ /.0_/')
}

SetupAmbient
JdkVersion $arch
echo "Instalando: "$jdk
tar -zxf $arch/$(ls ${arch}) -C /usr/lib/jvm
ln -s /usr/lib/jvm/$jdk /usr/lib/jvm/java-8-oracle
update-alternatives --remove-all java
update-alternatives --install "/usr/bin/java" "java" /usr/lib/jvm/java-8-oracle/bin/java 0
update-alternatives --install "/usr/bin/ControlPanel" "ControlPanel" /usr/lib/jvm/java-8-oracle/bin/ControlPanel 0
java -version