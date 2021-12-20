# Part 2: setup the Arch Linux
# Установка шрифта с поддержкой русского языка
setfont cyr-sun16
# Создание пользователя fm
useradd -m -g users -G wheel -s /bin/bash fm
# Создание пользователя student
useradd -m student
# Назначение пользователю fm прав супер-пользователя
sed -i "s/## sudoers file./%wheel ALL=(ALL) ALL/g" /etc/sudoers
echo -e "\033[7mВведите пароль для пользователя fm: \033[0m"
passwd fm
if [[ "$USER" == "root" ]];
then
    echo -e "\033[7mДля продолжения нужно залогиниться под пользователем fm\033[0m"
    exit 1
else
# Установка драйверов
    echo -e "\nY\nY\nY\nY\nY" | pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server
# Установка графического окружения
    echo -e "\nY\nY\nY" | pacman -S xfce4 lightdm lightdm-gtk-greeter
    echo "exec startxfce4" > ~/.xinitrc
    systemctl enable lightdm
# Установка Git
    echo -e "\nY" | pacman -S git
    echo -e "\nY" | pacman -S wget
# Установка FireFox
    echo -e "\nY" | pacman -S firefox
    echo -e "\nY" | pacman -S base-devel
    echo -e "\nY" | pacman -S openssh
    echo -e "\nY" | pacman -S libreoffice-still
    echo -e "\nY" | pacman -S code
# Установка Maxima
    echo -e "\nY" | pacman -S maxima-share 
    echo -e "\nY" | pacman -S gnuplot-x11 
    echo -e "\nY" | pacman -S xmaxima 
    echo -e "\nY" | pacman -S wxmaxima 
    echo -e "\nY" | pacman -S gnuplot-doc 
    echo -e "\nY" | pacman -S ttf-jsmath
# Установка Sage
    echo -e "\nY" | pacman -S sagemath
    echo -e "\nY" | pacman -S notepadqq
# Установка TexLive
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
fi