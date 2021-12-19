# Part 2: setup the Arch Linux
useradd -m -g users -G wheel -s /bin/bash fm
echo -e "\033[7mВведите пароль пользователя: \033[0m"
passwd
systemctl enable dhcpcd.service
systemctl start dhcpcd.service   