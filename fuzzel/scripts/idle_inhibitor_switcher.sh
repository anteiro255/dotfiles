#!/bin/bash
SCRIPTS=~/.config/fuzzel/scripts
CHOICE=$(echo -e "on\noff" | fuzzel --dmenu)
case "$CHOICE" in
	"off") pkill hypridle ;;
	"on")  hypridle & ;;
esac
