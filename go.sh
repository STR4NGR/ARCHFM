#!/bin/bash
echo -e "Welcome to install ArchLinux by \033[32mFM"

loadkeys ru
setfont cyr-sun16

timedatectl set-ntp true
timedatectl set-timezone Europe/Moscow
timedatectl status

echo -e "n\n\n\n\n+4G\n" | fdisk /dev/sda