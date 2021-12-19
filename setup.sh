# Part 2: setup the Arch Linux
# Установка шрифта с поддержкой русского языка
setfont cyr-sun16
# Создание пользователя fm
useradd -m -g users -G wheel -s /bin/bash fm
# Назначение пользователю fm прав супер-пользователя
sed -i "s/## sudoers file./%wheel ALL=(ALL) ALL/g" /etc/sudoers
echo -e "\033[7mВведите пароль для пользователя fm: \033[0m"
passwd fm
# Установка драйверов
echo -e "\nY\nY\nY\nY\nY" | pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server
# Установка графического окружения
echo -e "\nY\nY\nY" | pacman -S xfce4 lightdm lightdm-gtk-greeter
echo "exec startxfce4" > ~/.xinitrc
systemctl enable lightdm
# Установка менеджера окон
echo "exec i3"  > ~/.xinitrc
echo -e "\nY" | pacman -S i3
startx