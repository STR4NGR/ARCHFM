# Part 2: setup the Arch Linux
# Установка шрифта с поддержкой русского языка
setfont cyr-sun16
if [[ "$USER" == "root" ]]; then
# Создание пользователя fm
    useradd -m -g users -G wheel -s /bin/bash fm
# Создание пользователя student
    useradd -m student
# Назначение пользователю fm прав супер-пользователя
    sed -i "s/## sudoers file./%wheel ALL=(ALL) ALL/g" /etc/sudoers
    echo -e "\033[7mВведите пароль для пользователя fm: \033[0m"
    passwd fm
# Установка драйверов
    echo -e "\nY\nY\nY\nY\nY" | pacman -S pulseaudio pulseaudio-alsa xorg xorg-xinit xorg-server
# Настройка языка
    echo -e "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" > /etc/locale.gen
    locale-gen
    touch /etc/locale.conf
    echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
#Настройка раскладки клавиатуры
    echo -e 'Section "InputClass"\nIdentifier "system-keyboard"\nMatchIsKeyboard "on"\nOption "XkbLayout" "us,ru"\nOption "XkbModel" "pc104"\nOption "XkbOptions" "grp:ctrl_shift_toggle"\nEndSection' >> /etc/X11/xorg.conf.d/10-keyborad.conf    
# Установка графического окружения
    echo -e "\nY\nY\nY" | pacman -S xfce4 lightdm lightdm-gtk-greeter
    echo "exec startxfce4" > ~/.xinitrc
    systemctl enable lightdm
    echo -e "\nY" | pacman -S wget
# Установка FireFox
    echo -e "\nY" | pacman -S firefox-i18n-ru
    echo -e "\nY" | pacman -S --needed git base-devel
    echo -e "\nY" | pacman -S openssh
    echo -e "\nY" | pacman -S libreoffice-still-ru
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
# Установка Jupyter
    echo -e "\nY" | pacman -S jupyterlab
# Установка PyCharm
    echo -e "\nY" | pacman -S pycharm-community-edition
# Установка TexLive
    echo -e "\nY" | pacman -S texlive-core
    echo -e "\nY" | pacman -S texlive-bin
    echo -e "\nY" | pacman -S texlive-latexextra
    echo -e "\nY" | pacman -S texlive-lang
    echo -e "\nY" | pacman -S texlive-bibtexextra
    echo -e "\nY" | pacman -S texlive-fontsextra
    echo -e "\nY" | pacman -S biber
# Установка TexStudio
    echo -e "\nY" | pacman -S texstudio
    echo -e "\033[7mДля продолжения нужно залогиниться под пользователем fm\033[0m"
    exit 1
elif [[ "$USER" == "fm" ]]; then
# Установка Yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
# Установка Файлового Менеджера
    yay -S xfe
# Установка Visual Studio Code
    yay -S visual-studio-code-bin
    yay -S python-ptvsd
# Установка Anaconda
    cd ~/Downloads
    curl -OL https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
    sh Anaconda3-2021.11-Linux-x86_64.sh
    reboot
fi