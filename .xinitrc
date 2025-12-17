xwallpaper --zoom ~/.config/wall.jpg &
copyq --start-server &
./.screenlayout/home.sh
pgrep sxhkd || sxhkd &
kdeconnectd &
dwmblocks &
exec dbus-launch --exit-with-session dwm
