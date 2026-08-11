#!/bin/bash
SCRIPTS=~/.config/fuzzel/scripts
CHOICE=$(echo -e "on\noff" | fuzzel --dmenu)
case "$CHOICE" in
	"off") pkill swayidle ;;
	"on")  ~/.config/niri/scripts/idle_inhibitor_on.sh ;;
esac
