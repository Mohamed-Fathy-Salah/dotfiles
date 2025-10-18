sudo dd if=manjaro-xfce-25.0.8-250902-linux612.iso of=/dev/sdb bs=4M status=progress conv=fsync && sudo sync && sudo cmp manjaro-xfce-25.0.8-250902-linux612.iso /dev/sdb
