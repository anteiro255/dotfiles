#!/bin/bash
SCRIPTS=~/.config/fuzzel/scripts
CHOICE=$(echo -e "audio (pulsemixer)\nbluetooth (bluetui)\nwifi (wifitui)\nidle inhibitor" | fuzzel --dmenu)
case "$CHOICE" in
	"audio (pulsemixer)") $TERMINAL -e pulsemixer ;;
	"bluetooth (bluetui)") $TERMINAL -e bluetui ;;
	"wifi (wifitui)") $TERMINAL -e wifitui ;;
	"idle inhibitor") $SCRIPTS/idle_inhibitor_switcher.sh  ;;
esac
