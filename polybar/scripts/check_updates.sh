#!/bin/bash

# Verifica si hay actualizaciones pendientes
UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing" | wc -l)

# Si hay actualizaciones, muestra el número de paquetes
if [ "$UPDATES" -gt 0 ]; then
    echo "$UPDATES"
else
    echo "0"
fi
