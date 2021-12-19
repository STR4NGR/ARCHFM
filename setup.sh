# Part 2: setup the Arch Linux
# Установка шрифта с поддержкой русского языка
setfont cyr-sun16
useradd -m -g users -G wheel -s /bin/bash fm
echo -e "\033[7mВведите пароль пользователя: \033[0m"
passwd fm
#systemctl enable dhcpcd.service
#systemctl start dhcpcd.service   