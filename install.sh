###############################################################################
######					ARCHLINUX INSTALL SCRIPT						 ######
###### Fast Installation of an ArchLinux Distribution by Jonathan Crégut ######
###### Last tested with 07/2016 Live CD - Download me and run me as root ######
###### Contact me => jonathan.cregut@gmail.com							 ######
###### Auto partitionning Disk and Dual Boot + UEFI options coming soon  ######
###############################################################################
## http://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ######
###############################################################################

#### French + Time
loadkeys fr
timedatectl set-ntp true

#### Partitionning 
echo "Create your partition layout \n"
echo "/dev/sda1 will be for /boot (1G recommended)\n"
echo "/dev/sda2 will be for SWAP (2*RAM Size recommended)\n"
echo "/dev/sda will be for / \n"

cfdisk /dev/sda

## Formatting 
mkfs.ext2 -F /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 -F /dev/sda3

mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

## Installation 
pacstrap /mnt base base-devel

## Config
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash
sed -i 's/^#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "KEYMAP=fr" > /etc/vconsole.conf

ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

pacman -Sy grub
grub-install --no-floppy --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "jct-workstation" > /etc/hostname

systemctl enable dhcpcd.service

passwd

exit

umount -R /mnt/boot
umount -R /mnt

reboot