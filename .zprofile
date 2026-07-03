if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
    exec dbus-launch --exit-with-session startx
fi


# Added by Antigravity CLI installer
export PATH="/home/mofasa/.local/bin:$PATH"
