#!/usr/bin/env sh
set -e

sudo pacman -S --asdeps --needed efibootmgr

boot_disk="sda"
boot_partition=1
root_partition="sda2"
kernel_name="linux"
cpu_vendor="intel"
esp="boot"
extra_kernel_params=""
label="Arch Linux"

lsblk
printf "Boot disk (without /dev/ part): " && read -r boot_disk
printf "Boot partition number : " && read -r boot_partition
printf "Root partition (e.g. sda2) : " && read -r root_partition
printf "Kernel name (e.g. linux) : " && read -r kernel_name
printf "CPU vendor (intel/amd) : " && read -r cpu_vendor
printf "ESP (boot/efi) : " && read -r esp
printf "extra kernel parameters: " && read -r extra_kernel_params
printf "label: " && read -r label

rel_path=""
rel_path2=""
if [ "$esp" = "efi" ]; then
    rel_path="\\EFI\\arch"
    rel_path2="/EFI/arch"
fi

unicode_arg="root=/dev/$root_partition rw initrd=$rel_path\\$cpu_vendor-ucode.img initrd=$rel_path\\initramfs-$kernel_name.img quiet mitigations=off nowatchdog $extra_kernel_params"
unicode_arg_fallback="root=/dev/$root_partition rw initrd=$rel_path\\$cpu_vendor-ucode.img initrd=$rel_path\\initramfs-$kernel_name-fallback.img quiet mitigations=off nowatchdog $extra_kernel_params"

echo
echo
echo "$unicode_arg"
echo
echo
echo sudo efibootmgr --disk /dev/"$boot_disk" --part "$boot_partition" --create --label "$label" --loader "$rel_path2"/vmlinuz-"$kernel_name" --unicode "$unicode_arg" --verbose
echo sudo efibootmgr --disk /dev/"$boot_disk" --part "$boot_partition" --create --label "$label-fallback" --loader "$rel_path2"/vmlinuz-"$kernel_name" --unicode "$unicode_arg_fallback" --verbose
echo
echo
sudo efibootmgr --disk /dev/"$boot_disk" --part "$boot_partition" --create --label "$label" --loader "$rel_path2"/vmlinuz-"$kernel_name" --unicode "$unicode_arg" --verbose
sudo efibootmgr --disk /dev/"$boot_disk" --part "$boot_partition" --create --label "$label-fallback" --loader "$rel_path2"/vmlinuz-"$kernel_name" --unicode "$unicode_arg_fallback" --verbose
