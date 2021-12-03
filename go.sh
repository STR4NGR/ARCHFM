#!/bin/bash
echo -e "Welcome to install ArchLinux by \033[32mFM \033[0m"
_SWAP_CAP="+4G"
_ROOT_CAP="+100G"

#Добавление русской раскладки клавиатуры
loadkeys ru
#Установка шрифта с поддержкой русского языка
setfont cyr-sun16
#Установка обновления времени через интернет
timedatectl set-ntp true
#Установка часового пояса
timedatectl set-timezone Europe/Moscow

#Удаление всех существующих разделов
echo -e "d\n 1\n d\n 2\n d\n w\n" | fdisk /dev/sda
#Создание разделов на жестком диске
echo -e "n\n\n\n\n${_SWAP_CAP}\nt\n82\nn\n\n\n\n${_ROOT_CAP}\nn\n\n\n\n\nw" | fdisk /dev/sda