#!/bin/bash
SCRIPTS=~/.config/fuzzel/scripts

CHOICE=$(printf "power\nmain apps\nemoji\nwallpapers\ncontrol\napps" | fuzzel --dmenu)

case "$CHOICE" in
    "power") $SCRIPTS/power-menu.sh ;;
    "main apps") $SCRIPTS/main_apps.sh ;;
    "emoji") bemoji ;;
    "wallpapers") $SCRIPTS/wallpapers-selector.sh ;;
    "control") $SCRIPTS/control.sh ;;
    "apps") fuzzel ;;
esac
