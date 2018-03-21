# Helper d'installation

Liste des commandes à effectuer pour une nouvelle installation si volontée de ne pas utiliser les scripts ci-présents.


## Installation

Dans le cas de besoin d'un proxy : 

```shell
export http_proxy=http://10.203.0.1:5187/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
```


### Partitionnement GPT 
Dans la suite du guide, on part du principe que le partitionnement a été effectué en GPT pour un boot UEFI

Pour la suite nous ferons :
* /dev/sda1 pour le /boot/efi
* /dev/sda2 pour la swap
* /dev/sda3 pour le /

Formattage des partitions

```shell
mkfs.vfat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
```

Montage des partitions

```shell
mount /dev/sda3 /mnt
swapon /dev/sda2
mkdir -p /mnt/boot/efi && mount -t vfat /dev/sda1 /mnt/boot/efi
```

Le swapon est nécessaire pour le genfstab plus tard.


Installation de la base 

```shell
pacstrap /mnt base base-devel
```

Construction du fstab 

```shell
genfstab -U -p /mnt >> /mnt/etc/fstab
```

Chroot

```shell
arch-chroot /mnt
```

Configuration de base : 
```shell
echo jonathanPC > /etc/hostname
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
```
Editer le /etc/locale.gen

```shell
locale-gen
echo LANG="fr_FR.UTF-8" > /etc/locale.conf
echo KEYMAP=fr > /etc/vconsole.conf
mkinitcpio -p linux

passwd
```


Installation de grub


```shell
pacman -S grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg
```


Démonter le tout :

```shell
umount -R /mnt
```



## Post installation

Création de l'utilisateur 

```shell
useradd -m -G wheel -s /bin/bash jonathan
passwd jonathan
```

Ajout du dépot pour yaourt

```shell
echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
```

Installation yaourt 

```shell
pacman -Syu yaourt
```

Installation environnements bureau 
```shell
yaourt -Syu gnome deepin deepin-extra gdm
systemctl enable gdm
```

Docker 
```shell
yaourt -S docker
usermod -a -G docker jonathan
systemctl enable docker
```




