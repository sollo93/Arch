#!/bin/bash

loadkeys ru
setfont cyr-sun16
echo 'Синхронизация часов'
timedatectl set-ntp true
echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4  /dev/sdb1 -L home

echo '2.4.3 Монтирование дисков'
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda3
mount /dev/sdb1 /mnt/home
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel
echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

