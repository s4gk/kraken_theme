#!/bin/bash

ICON_WIFI=""
ICON_ETH=""
ICON_OFFLINE=""

ETH_INTERFACE=$(ip link show | awk '/state UP/ && /enp|eth/ {print $2}' | tr -d ':')
WIFI_INTERFACE=$(ip link show | awk '/state UP/ && /wlp|wl/ {print $2}' | tr -d ':')

if [ -n "$ETH_INTERFACE" ]; then
    SPEED=$(ethtool "$ETH_INTERFACE" 2>/dev/null | awk '/Speed:/ {print $2}')
    echo "$ICON_ETH ${SPEED%%Mb*}Mb"
elif [ -n "$WIFI_INTERFACE" ]; then
    SPEED=$(iw dev "$WIFI_INTERFACE" link | awk '/tx bitrate/ {print $3}')
    echo "$ICON_WIFI ${SPEED%%.*}Mb"
else
    echo "$ICON_OFFLINE Offline"
fi
