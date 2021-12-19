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
# Установка Git
echo -e "\nY" | pacman -S git
echo -e "\nY" | pacman -S wget
# Установка FireFox
echo -e "\nY" | pacman -S firefox
echo -e "\nY" | pacman -S base-devel
echo -e "\nY" | pacman -S openssh
echo -e "\nY" | pacman -S libreoffice-still
echo -e "\nY" | pacman -S code
echo -e "\nY" | pacman -S maxima
echo -e "\nY" | pacman -S sagemath
echo -e "\nY" | pacman -S notepadqq
# Установка TexLive
cd ~/Desktop
git clone https://aur.archlinux.org/texlive-installer.git
cd texlive-installer
makepkg -si
cd ..
# Установка Anaconda
git clone https://aur.archlinux.org/anaconda.git
cd anaconda
makepkg -si
cd .. 
reboot