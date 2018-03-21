#### Postinstall Arch
##TODO : Desktop Env

# Create user 
useradd -m -G wheel -s /bin/bash jonathan
echo "Entrer le mot de passe pour ne nouvel utilisateur"
passwd jonathan

# Get Yaourt for AUR
echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
pacman -Sy

pacman -S --noconfirm yaourt

# Gnome
pacman -Syu --noconfirm gnome gnome-extra gdm deepin deepin-extra
systemctl enable gdm

# Workspace
yaourt -S --noconfirm evolution filezilla docker chromium code evince libcups cups ghostscript phpstorm libreoffice-fresh libreoffice-fresh-fr ttf-dejavu artwiz-fonts hunspell hunspell-fr mythes libmythes mythes-fr
usermode -a -G docker jonathan
systemctl enable org.cups.cupsd.service
systemctl enable docker.service
##TO INSTALL intellij-idea-ce-eap android-studio vivaldi sublime-text-dev visual-studio-code