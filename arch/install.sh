#!/bin/bash

# INSTALL BASE PACKAGES
APPS=$(cat apps.txt | sed ':a;N;$!ba;s/\n/ /g')
sudo pacman -Sy --noconfirm $APPS

# SETUP hostname
echo dtb-arch > /etc/hostname

# SETUP LANGUAGE
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
ln -sf /usr/share/zoneinfo/America/Fortaleza > /etc/localtime

# SETUP USERS
useradd -m -G wheel -s /bin/bash administrador
echo $ENV_PASSWORD | passwd administrador --stdin
echo $ENV_PASSWORD | passwd root --stdin
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# SETUP GRUB
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -p linux

# SETUP NETWORK
systemctl enable wicd.service

# SETUP BASIC USER SETTINGS
cp -rf /etc/skel/.* /home/administrador/
echo exec openbox-session > /home/administrador/.xinitrc
chown -R administrador:administrador /home/administrador/