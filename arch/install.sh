#!/bin/bash

USER_DIRS="Desktop Documents Pictures Videos Downloads"

### SETUP SYSTEM
# INSTALL BASE PACKAGES
APPS=$(cat apps.txt | sed ':a;N;$!ba;s/\n/ /g')
pacman -Sy --noconfirm $APPS

# SETUP LANGUAGE
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/America/Fortaleza /etc/localtime
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
echo "localectl set-keymap --no-convert br-abnt2" >> /etc/bash.bashrc

# SETUP GRUB
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -p linux

# SETUP NETWORK
systemctl enable NetworkManager

# SETUP CUPS
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
systemctl enable org.cups.cupsd.socket
systemctl start org.cups.cupsd.socket

### SETUP SYSTEM SETTINGS
# hostname
echo dtb-arch > /etc/hostname

### SETUP USER
# Useradd and user settings
useradd -m -G wheel -s /bin/bash administrador
echo "administrador:$ENV_PASSWORD" | chpasswd
echo "root:$ENV_PASSWORD" | chpasswd
sed -i 's/# %wheel/%wheel/g' /etc/sudoers
sed -i 's#NOPASSWD: ALL#NOPASSWD: /usr/bin/pacman#' /etc/sudoers

# Basic user settings
cp -f /etc/skel/.* /home/administrador/
echo -e "udiskie &\nexec openbox-session" > /home/administrador/.xinitrc
for dir in $USER_DIRS; do
   mkdir /home/administrador/$dir
done
chown -R administrador:administrador /home/administrador/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
