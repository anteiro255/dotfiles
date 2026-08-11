#!/bin/bash
SCRIPTS=~/.config/fuzzel/scripts

CHOICE=$(printf "run all\nzen\nzed\nobsidian" | fuzzel --dmenu)

case "$CHOICE" in
    "run all") zen-browser & zeditor & obsidian;;
    "zen") zen-browser & ;;
    "zed") zeditor & ;;
    "obsidian") obsidian & ;;
esac
