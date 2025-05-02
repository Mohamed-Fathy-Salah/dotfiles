xwallpaper --zoom ~/.config/wall.jpg &
copyq --start-server &
./.screenlayout/home.sh
pgrep sxhkd || sxhkd &
kdeconnectd &
dwmblocks &
exec dwm
