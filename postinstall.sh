#### Postinstall Arch
##TODO : Desktop Env

# Get Yaourt for AUR
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

# Gnome
pacman -Syu gnome gnome-extra gdm
systemctl enable gdm

