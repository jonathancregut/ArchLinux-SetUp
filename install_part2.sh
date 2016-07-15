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