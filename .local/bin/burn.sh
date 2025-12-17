sudo dd if=archlinux-x86_64.iso of=/dev/sdb bs=4M status=progress conv=fsync && sudo sync && sudo cmp archlinux-x86_64.iso /dev/sdb
