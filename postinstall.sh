#### Postinstall Arch
##TODO : Desktop Env

# Create user 
useradd -m -G wheel -s /bin/bash jonathan
echo "Entrer le mot de passe pour ne nouvel utilisateur"
passwd jonathan

# Get Yaourt for AUR
echo "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
pacman -Sy

pacman -S --noconfirm yaourt

# Gnome
pacman -Syu --noconfirm gnome gnome-extra gdm
systemctl enable gdm

# Workspace
pacman -S --noconfirm thunderbird filezilla netbeans virtualbox
yaourt -S --noconfirm intellij-idea-ce-eap android-studio vivaldi sublime-text-dev visual-studio-code