if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
    exec dbus-launch --exit-with-session startx
fi
