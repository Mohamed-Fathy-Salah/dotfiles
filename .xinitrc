xwallpaper --zoom ~/.config/wall.jpg &
numlockx &
sudo ntpdate pool.ntp.org &
# /usr/lib/kdeconnectd
pgrep sxhkd || sxhkd &
dwmblocks &
exec dwm
