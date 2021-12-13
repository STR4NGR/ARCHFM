#!/bin/bash
#TODO Сделать выбор таблицы разметки диска
#TODO Спросить про имя компьютера
#TODO Работа со своп файлом
echo -e "Welcome to install ArchLinux by \033[32mFM \033[0m"
_SWAP_CAP="+4G"
_ROOT_CAP="+100G"
#_PC_NAME="fmlab-12"

#Добавление русской раскладки клавиатуры
loadkeys ru                             
#Установка шрифта с поддержкой русского языка
setfont cyr-sun16
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
pacstrap /mnt base linux linux-firmware sudo nano

#Генерация файла fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

#Установка часового пояса
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime  

#Установка времени BIOS
arch-chroot /mnt hwclock --systohc

#Настройка языка
arch-chroot /mnt echo "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" > /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt touch /etc/locale.conf
arch-chroot /mnt echo "LANG=ru_RU.UTF-8" > /etc/locale.conf

#Настройка компьютера
echo -e "\033[32mВведите пароль root пользователя: \033[0m"
arch-chroot /mnt passwd
echo -e  "\033[32mВведите имя компьютера: \033[0m"
read _PC_NAME
arch-chroot /mnt touch /etc/hostname
arch-chroot /mnt echo "${_PC_NAME}" >> /mnt/etc/hostname
arch-chroot /mnt sed -i "s/# See hosts(5) for details/127.0.0.1 localhost\n::1 localhost\n127.0.0.1 ${_PC_NAME}.localdomain ${_PC_NAME}/g" /etc/hosts

#arch-chroot /mnt echo "$_ROOT_PASS" | passwd --stdin
#arch-chroot /mnt echo fm:${_ROOT_PASS} | chpasswd

#Нужно сделать TODO
#Установка и настройка GRUB загрузчика
pacstrap /mnt grub
arch-chroot /mnt grub-install /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg 
arch-chroot /mnt sed -i "s/# GRUB boot loader configuration/GRUB_DISABLE_OS_PROBER=false/g" /etc/default/grub
umount -R /mnt
