#!/bin/bash
echo -e "Welcome to install ArchLinux by \033[32mFM \033[0m"
_SWAP_CAP="+4G"
_ROOT_CAP="+25G"

loadkeys ru
setfont cyr-sun16

timedatectl set-ntp true
timedatectl set-timezone Europe/Moscow
timedatectl status

echo -e "n\n\n\n\n${_SWAP_CAP}\nt\n82\nn\n\n\n\n${_ROOT_CAP}\nn\n\n\n\n\nw" | fdisk /dev/sda