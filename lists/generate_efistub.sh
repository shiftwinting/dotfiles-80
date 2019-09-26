#!/usr/bin/env sh

efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux" --loader /EFI/arch/vmlinuz-linux --unicode 'root=UUID=9b2c99d4-d615-48c4-a52e-f20fc7315fa9 rw initrd=\\EFI\\arch\\intel-ucode.img initrd=\\EFI\\arch\\initramfs-linux.img quiet mitigations=off nowatchdog' --verbose
