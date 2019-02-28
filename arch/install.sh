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
ln -s /usr/share/zoneinfo/America/Fortaleza > /etc/localtime
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
echo "localectl set-keymap --no-convert br-abnt2" >> /etc/bash.bashrc

# SETUP GRUB
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -p linux

# SETUP NETWORK
systemctl enable wicd.service

### SETUP SYSTEM SETTINGS
# hostname
echo dtb-arch > /etc/hostname
# pt-br key on X11
cp -rf settings/10-evdev.conf /etc/X11/xorg.conf.d/
# settings for touchpad using libinput
cp -rf settings/30-touchpad.conf /etc/X11/xorg.conf.d/
chmod 644 /etx/X11/xorg.conf.d

### SETUP USER
# Useradd and user settings
useradd -m -G wheel -s /bin/bash administrador
echo "administrador:$ENV_PASSWORD" | chpasswd
echo "root:$ENV_PASSWORD" | chpasswd
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Basic user settings
cp -f /etc/skel/.* /home/administrador/
echo exec openbox-session > /home/administrador/.xinitrc
for dir in $USER_DIRS; do
   mkdir /home/administrador/$dir
done
chown -R administrador:administrador /home/administrador/
