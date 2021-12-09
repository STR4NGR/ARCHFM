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
#!/bin/bash
arch-chroot