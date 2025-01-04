#!/bin/bash

# Verifica si hay actualizaciones pendientes
UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing" | wc -l)

# Acción para clic izquierdo: Actualiza los paquetes
if [ "$1" == "left" ]; then
    sudo apt update && sudo apt upgrade -y
    exit 0
fi

# Acción para clic derecho: Muestra los paquetes pendientes de actualización
if [ "$1" == "right" ]; then
    PACKAGES=$(apt list --upgradable 2>/dev/null | grep -v "Listing")
    if [ -z "$PACKAGES" ]; then
        echo "No updates"
    else
        echo "$PACKAGES"
    fi
    exit 0
fi

# Si no hay actualizaciones, muestra "0"
if [ "$UPDATES" -gt 0 ]; then
    echo "$UPDATES"
else
    echo "0"
fi
