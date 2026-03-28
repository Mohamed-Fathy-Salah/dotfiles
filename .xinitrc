xwallpaper --zoom ~/.config/wall.jpg &
copyq --start-server &
./.config/screenlayout/home.sh
pgrep sxhkd || sxhkd &
kdeconnectd &
dwmblocks &
dunst &
xmodmap -e "clear lock" \
        -e "clear mod4" \
        -e "keycode 66 = Super_L" \
        -e "keycode 133 = Caps_Lock" \
        -e "add mod4 = Super_L"
exec dbus-launch --exit-with-session dwm
