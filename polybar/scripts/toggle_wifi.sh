#!/bin/bash

# Detecta la interfaz Wi-Fi activa
WIFI_INTERFACE=$(ip link show | awk '/state UP/ && /wlp|wl/ {print $2}' | tr -d ':')

if [ -n "$WIFI_INTERFACE" ]; then
    # Si la interfaz está activa, apágala
    nmcli radio wifi off
else
    # Si está apagada, enciéndela
    nmcli radio wifi on
fi
