sed -i 's/^#fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
echo "KEYMAP=fr" > /etc/vconsole.conf

ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

pacman -Sy --noconfirm grub
grub-install --no-floppy --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "jct-workstation" > /etc/hostname

systemctl enable dhcpcd.service

passwd

exit

wget https://raw.githubusercontent.com/jonathancregut/ArchLinux-SetUp/master/postinstall.sh
cp postinstall.sh /mnt/root/postinstall.sh

echo "after reboot, log in as root and launch postinstall.sh"

umount -R /mnt/boot
umount -R /mnt

reboot