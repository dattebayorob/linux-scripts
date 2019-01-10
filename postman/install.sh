#!/bin/bash
source '../utils/checkUser.sh'

checkUser $1

## dependencies
apt-get install gconf-service gconf-service-backend gconf2-common libgconf-2-4 -y > /dev/null

## constants
postmanPath="/home/${1}/Documentos/packages/"
postmanPackage=$(ls Postman* | grep .tar.gz)
mkdir -p $postmanPath
tar -xf $postmanPackage -C $postmanPath
cp ${postmanPath}Postman/app/resources/app/assets/icon.png /usr/share/icons/hicolor/48x48/apps/postman.png
cp postman.desktop /usr/share/applications
chown -R $1:$1 ${postmanPath}
chmod +x ${postmanPath}Postman/Postman