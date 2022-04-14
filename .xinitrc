setxkbmap -layout "us,ar" -option "grp:win_space_toggle,grp_led:scroll,caps:super" & 
xwallpaper --zoom ~/.config/wall.jpg &
numlockx &
sudo ntpdate pool.ntp.org &
# /usr/lib/kdeconnectd
dwmblocks &
# kill -40 $(pidof dwmblocks) & kill -41 $(pidof dwmblocks) & 
exec dwm
