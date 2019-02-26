#!/bin/bash
source 'packages/packageInstall.sh'

#INSTALL PACKAGES, RUN AS NORMAL USER
if [ -z $1 ]; then
	PACKAGES=$(cat packages/packages.txt | sed ':a;N;$!ba;s/\n/ /g')
else
	PACKAGES=$1
fi
for pkg in $PACKAGES; do
	packageInstall $pkg "packages"
done