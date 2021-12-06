#!/bin/bash
#TODO Сделать выбор таблицы разметки диска
#TODO Спросить про имя компьютера
#TODO Работа со своп файлом
echo -e "Welcome to install ArchLinux by \033[32mFM \033[0m"
_SWAP_CAP="+4G"
_ROOT_CAP="+100G"
_PC_NAME="fmlab-12"

#Добавление русской раскладки клавиатуры
loadkeys ru
#Установка шрифта с поддержкой русского языка
setfont UniCyr_8x16
#Установка обновления времени через интернет
timedatectl set-ntp true
#Установка часового пояса
timedatectl set-timezone Europe/Moscow

#Удаление всех существующих разделов
echo -e "o\n w\n" | fdisk /dev/sda
#Создание разделов на жестком диске
echo -e "n\n\n\n\n${_SWAP_CAP}\nt\n82\nn\n\n\n\n${_ROOT_CAP}\nn\n\n\n\n\nw" | fdisk /dev/sda

#Форматирование раздела swap
echo y | mkfs.ext4 /dev/sda1
#Форматирование раздела root
echo y | mkfs.ext4 /dev/sda2
#Форматирование раздела home
echo y | mkfs.ext4 /dev/sda3

#Монтируем папку root и создаем папку home
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home

#Установка системы
echo -e "Y" | pacstrap -i /mnt base

#Генерация файла fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

#Изменение корневого каталога
arch-chroot /mnt

#Установка часового пояса
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

#Установка времени BIOS
hwclock --systohc

#Настройка языка
echo "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=ru_RU.UTF-8" > /etc/locale.conf

#Настройка компьютера
echo ${_PC_NAME} > /etc/hostname
echo "127.0.1.1 localhost.localdomain ${_PC_NAME}" | sed 'a\# See hosts(5) for details'
echo "fm_11_mk" | passwd

pacman -S grub
pacman -S os-prober

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -R /mnt
reboot