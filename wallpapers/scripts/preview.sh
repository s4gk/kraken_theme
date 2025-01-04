#!/usr/bin/env zsh

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

SELECTED_WALLPAPER=$(for a in "$WALLPAPER_DIR"/*.png; do
    echo -en "$(basename "$a")\0icon\x1f$a\n"
done | rofi -dmenu -theme /usr/share/rofi/themes/wallpaper_selector.rasi -show-icons)

if [ -n "$SELECTED_WALLPAPER" ]; then

    WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED_WALLPAPER"

    # Archivos de temas
    THEME_FILE_LAUNCHER="$HOME/rofi/launcher.rasi"
    THEME_FILE_POWERMENU="$HOME/rofi/powermenu.rasi"

    BSPWMRC="$HOME/.config/bspwm/bspwmrc"

    # Reemplazar la ruta en launcher.rasi con 'height'
    sed -i "s|background-image: *url(\"~\/Pictures\/Wallpapers\/\([^,]*\),.*|background-image: url(\"~\/Pictures\/Wallpapers\/$SELECTED_WALLPAPER\", height);|" "$THEME_FILE_LAUNCHER"

    # Reemplazar la ruta en powermenu.rasi con 'width'
    sed -i "s|background-image: *url(\"~\/Pictures\/Wallpapers\/\([^,]*\),.*|background-image: url(\"~\/Pictures\/Wallpapers\/$SELECTED_WALLPAPER\", width);|" "$THEME_FILE_POWERMENU"

    # Reemplazar la línea en bspwmrc
    sed -i "s|feh --bg-fill .*|feh --bg-fill \"$WALLPAPER_PATH\"|" "$BSPWMRC"

    # Reiniciar bspwm para aplicar cambios
    bspc wm -r

    echo "Wallpapers actualizados y bspwm reiniciado."
else
    echo "No seleccionó wallpaper."
fi
