# vars
set -gx EDITOR micro
set -gx GUI_EDITOR zed

set -gx AUR_INSTALLER yay
set -gx BROWSER zen-browser
set -gx FILE_MANAGER nautilus
set -gx IMAGE_VIEWER imv
set -gx MEDIA_PLAYER clapper
set -gx TERMINAL alacritty

if status is-interactive
    # aliases
    # cfg
    alias _niri "$EDITOR ~/.config/niri/config.kdl"
    alias _fish "$EDITOR ~/.config/fish/config.fish"
    
    # one symbol shortcuts
    alias s sudo
    alias g git
    alias z zeditor
    alias m micro
    alias v nvim
    alias h helix
    alias b btop
    alias c clear
    alias y yazi

    # two symbols shortcuts
    alias py python
    alias oc opencode
    alias ff "fastfetch --logo-color-1 blue --logo-color-2 blue --color blue"
    
    # system control
    alias q exit
    alias hypr-logout "niri msg action quit"
    alias off "systemctl poweroff"
    alias suspend "systemctl suspend"
    alias hibernate "systemctl hibernate"

    # shortcuts
    alias pcm "sudo pacman -S --noconfirm --needed"
    alias pcmrm "sudo pacman -Rns --noconfirm"
    alias get "$AUR_INSTALLER -S --noconfirm --needed"
    alias aurrm "$AUR_INSTALLER -Rns --noconfirm"
    alias update_system "$AUR_INSTALLER --noconfirm"
    
    alias smd_restart "sudo systemctl restart smb nmb winbind"
    alias rebuild_kernel "sudo mkinitcpio -P"
    alias fan_manual_on "sudo modprobe -r thinkpad_acpi; sudo modprobe thinkpad_acpi fan_control=1"
    alias fan_manual_off "sudo modprobe -r thinkpad_acpi; sudo modprobe thinkpad_acpi fan_control=0"

    # tclock
    set tclock_args "-c blue"
    alias timer "tclock $tclock_args timer -d"
    alias countdown_to "tclock $tclock_args countdown --time"
    alias stopwatch "tclock $tclock_args stopwatch"
    alias clock "tclock $tclock_args clock"
end

# PATH
set -gx PATH $PATH $HOME/.cargo/bin
set -gx PATH $PATH $HOME/.local/bin
set -gx PATH $PATH $HOME/go/bin
set -gx PATH $PATH $HOME/.local/share/solana/install/active_release/bin

# Greeting
set -g fish_greeting ""
