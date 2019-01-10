#!/bin/bash
#dependencies
#sudo apt-get install gconf-service gconf-service-backend gconf2-common libgconf-2-4 -y > /dev/null

postmanPath="Documentos/packages/"
postmanPackage=$(ls Postman* | grep .tar.gz)
mkdir -p /home/$USER/$postmanPath}
tar -xf $postmanPackage -C /home/$USER/$postmanPath
sudo cp /home/$USER/${postmanPath}/Postman/app/resources/app/assets/icon.png /usr/share/icons/hicolor/48x48/apps/postman.png
sudo cp postman.desktop /usr/share/applications
chmod +x /home/$USER/${postmanPath}Postman/Postman
