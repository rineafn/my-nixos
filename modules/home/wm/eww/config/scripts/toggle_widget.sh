#!/usr/bin/env bash
widget="${1}"

if [ -n "$MONITOR" ]; then
    monitor="$MONITOR"
else
    if command -v xdotool >/dev/null 2>&1; then
        eval $(xdotool getmouselocation --shell 2>/dev/null)
        monitor="eDP-1"
        while read -r name width height x_off y_off; do
            x_max=$((x_off + width))
            y_max=$((y_off + height))
            if [ "$X" -ge "$x_off" ] && [ "$X" -lt "$x_max" ] && [ "$Y" -ge "$y_off" ] && [ "$Y" -lt "$y_max" ]; then
                monitor="$name"
                break
            fi
        done < <(xrandr --query | grep " connected" | grep -o -E '[a-zA-Z0-9_-]+ connected [a-z ]*[0-9]+x[0-9]+\+[0-9]+\+[0-9]+' | sed -E 's/([a-zA-Z0-9_-]+) connected (primary )?([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)/\1 \3 \4 \5 \6/')
    else
        monitor="eDP-1"
    fi
fi

eww open --toggle "${widget}_win_${monitor}"

sleep 0.1
if eww active-windows | grep -q "${widget}_win"; then
    if [ "$widget" = "power" ]; then
        i3-msg mode "power_menu"
    else
        i3-msg mode "widget_mode"
    fi
else
    i3-msg mode "default"
fi
