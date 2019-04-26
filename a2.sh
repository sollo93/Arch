#!/bin/bash
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo '3.4 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf
mkinitcpio -p linux
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S dialog wpa_supplicant --noconfirm 
useradd -m -g users -G wheel -s /bin/bash $username
passwd
echo 'Устанавливаем пароль пользователя'
passwd $username
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy
pacman -S xorg-server xorg-drivers xorg-xinit
pacman -S xfce4 xfce4-goodies --noconfirm
pacman -S lxdm --noconfirm
systemctl enable lxdm
pacman -S ttf-liberation ttf-dejavu --noconfirm 
pacman -S networkmanager network-manager-applet ppp --noconfirm
systemctl enable NetworkManager

exit
