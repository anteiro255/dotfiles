
#!/bin/bash

CHOICE=$(echo -e "poweroff\nreboot\nsuspend\nhibernate\nlock\nlogout" | fuzzel --dmenu)

case "$CHOICE" in
    "poweroff") systemctl poweroff ;;
    "reboot") systemctl reboot ;;
    "suspend") systemctl suspend ;;
    "hibernate") systemctl hibernate;;
    "lock") hyprlock ;;
    "logout") niri msg action quit ;;
esac
