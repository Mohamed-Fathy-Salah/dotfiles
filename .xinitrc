xwallpaper --zoom ~/.config/wall.jpg &
numlockx &
sudo ntpdate pool.ntp.org &
/usr/lib/kdeconnectd &
pgrep sxhkd || sxhkd &
dwmblocks &
dunst &
# optimus-manager --switch nvidia &
exec dwm & 
sleep 1
# xrandr --output DP-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off --output LVDS-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VGA-1-1 --off
wait
