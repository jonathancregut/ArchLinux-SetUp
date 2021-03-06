###############################################################################
######					ARCHLINUX INSTALL SCRIPT						 ######
###### Fast Installation of an ArchLinux Distribution by Jonathan Crégut ######
###### Last tested with 07/2016 Live CD - Download me and run me as root ######
###### Contact me => jonathan.cregut@gmail.com							 ######
###### Auto partitionning Disk and Dual Boot for legacy boot not UEFI    ######
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

arch-chroot /mnt sed -i 's/^#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/g' /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
arch-chroot /mnt echo "KEYMAP=fr" > /etc/vconsole.conf

arch-chroot /mnt ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

arch-chroot /mnt pacman -Sy --noconfirm grub
arch-chroot /mnt grub-install --no-floppy --recheck /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

arch-chroot /mnt echo "jct-workstation" > /etc/hostname

arch-chroot /mnt systemctl enable dhcpcd.service

arch-chroot /mnt passwd

wget https://raw.githubusercontent.com/jonathancregut/ArchLinux-SetUp/master/postinstall.sh
cp postinstall.sh /mnt/root/postinstall.sh

echo "after reboot, log in as root and launch postinstall.sh"

umount -R /mnt/boot
umount -R /mnt

reboot