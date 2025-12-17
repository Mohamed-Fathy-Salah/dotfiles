#!/bin/zsh

get_language(){
    case "$(xset -q|grep LED| awk '{ print $10 }')" in
        "00000000") echo -ne "E " ;;
        "00001004") echo -ne "ض ";;
        *) echo -ne "⚠ " ;;
    esac
}

get_volume() {
    curStatus=$(pactl get-sink-mute 0)
    volume=$(pactl get-sink-volume 0 | tail -n 2 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' | head -n 1)

    if [ "${curStatus}" = 'Mute: yes' ]
    then
        echo -ne " $volume%"
    else
        echo -ne " $volume%"
    fi
}


while true
do
    DATE_TIME=$(date "+ %a %d %b  ▎   %I:%M %p")
    MEM=$(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}')
    CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' )
    TEMP=$(sensors|grep 'Core 0'|awk '{print $3}' )
    NET=$( awk '/wlan0/ {i++; rx[i]=$2; tx[i]=$10}; END{printf "▼ %.1f KB ː %.1f KB ▲" ,(rx[2]-rx[1])/1024 , (tx[2]-tx[1])/1024 }' <(cat /proc/net/dev; sleep 1; cat /proc/net/dev))
    BAT=$(cat /sys/class/power_supply/BAT0/capacity)

    xsetroot -name "$DATE_TIME  ▎ $(get_volume)  ▎   $MEM  ▎    $CPU%  ▎   $TEMP  ▎ $(get_language) ▎  $NET  ▎ $BAT% "

    sleep 2
done &
