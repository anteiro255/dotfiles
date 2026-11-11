#!/bin/bash
SCRIPTS=~/.config/fuzzel/scripts

CHOICE=$(printf "power\nmain apps\nemoji\ncontrol\nget text from the screen\nscan QRcode\nwallpapers\napps" | fuzzel --dmenu)

case "$CHOICE" in
    "power") $SCRIPTS/power-menu.sh ;;
    "main apps") $SCRIPTS/main_apps.sh ;;
    "emoji") bemoji ;;
    "control") $SCRIPTS/control.sh ;;
    "get text from the screen") grim -g "$(slurp)" - | tesseract stdin stdout -l eng+rus | wl-copy ;;
    "scan QRcode") qrx ;;
    "wallpapers") $SCRIPTS/wallpapers-selector.sh ;;
    "apps") fuzzel ;;
esac
