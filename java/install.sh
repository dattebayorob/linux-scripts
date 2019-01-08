#!/bin/bash
#Instalação e configuração do Java-8-oracle
cpu=$(uname -m)
if [ ${cpu} == 'x86_64' ]; then
	arch="x64"
	#arch='amd64'
else
	#cpu='i586'
	arch="i586"
fi
if [ ! -d /usr/lib/jvm ]; then
	mkdir -p /usr/lib/jvm
else
	rm -rf /usr/lib/jvm/*
fi

JdkVersion(){
	if [ -z $(ls $1) ];then
		wget -c -P $1 --no-cookies --no-check-certificate --header \
			"Cookie: gpw_e24=http%3a%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk8-downloads-2133151.html; oraclelicense=accept-securebackup-cookie;"\
			"https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-${1}.tar.gz"
	fi
	jdk="jdk1."$(ls $1 | awk '{print substr($0,5,1),substr($0,7,3)}' | sed 's/ /.0_/')
}
JdkVersion $arch
echo "Instalando: "$jdk
apt-get remove sun-java6*
tar -zxf $arch/$(ls ${arch}) -C /usr/lib/jvm
ln -s /usr/lib/jvm/$jdk /usr/lib/jvm/java-8-oracle
update-alternatives --remove-all java
update-alternatives --install "/usr/bin/java" "java" /usr/lib/jvm/java-8-oracle/bin/java 0
update-alternatives --install "/usr/bin/ControlPanel" "ControlPanel" /usr/lib/jvm/java-8-oracle/bin/ControlPanel 0
java -version