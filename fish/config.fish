# vars
set -gx EDITOR helix
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
    alias o open
    alias g git
    alias m micro
    alias h helix
    alias c clear

    # two symbols shortcuts
    alias py python
    alias oc opencode
    alias ff "fastfetch --logo-color-1 blue --logo-color-2 blue --color blue"

    # shortcuts
    alias get_pcm "sudo pacman -S --noconfirm --needed"
    alias del_pcm "sudo pacman -Rns --noconfirm"
    alias get "$AUR_INSTALLER -S --noconfirm --needed"
    alias del "$AUR_INSTALLER -Rns --noconfirm"
    alias update_system "$AUR_INSTALLER --noconfirm"

    alias smd_restart "sudo systemctl restart smb nmb winbind"
    alias rebuild_kernel "sudo mkinitcpio -P"
    alias fan_manual_on "sudo modprobe -r thinkpad_acpi; sudo modprobe thinkpad_acpi fan_control=1"
    alias fan_manual_off "sudo modprobe -r thinkpad_acpi; sudo modprobe thinkpad_acpi fan_control=0"
    alias vnc_on "sudo modprobe vkms; wayvnc -r -o Virtual-1 0.0.0.0 5900 &"

    # tclock
    set tclock_args "-c blue"
    alias timer "tclock $tclock_args timer -d"
    alias countdown_to "tclock $tclock_args countdown --time"
    alias stopwatch "tclock $tclock_args stopwatch"
    alias clock "tclock $tclock_args clock"
end

# functions
function off_in
    sleep $argv[1] && shutdown now
end
function vnc_on
    sudo modprobe vkms
    sleep 0.5
    wayvnc -r -o Virtual-1 0.0.0.0 5900 >/dev/null 2>&1 &
    niri msg output Virtual-1 on
    disown
end
function vnc_off
    niri msg output Virtual-1 off
    pkill wayvnc
    sudo modprobe -r vkms
end

function y # yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
function gt # stands for Get To
    mkdir -p -- $argv[1]; and cd -- $argv[1]
end
set -gx PATH $PATH $HOME/.cargo/bin
set -gx PATH $PATH $HOME/.local/bin
set -gx PATH $PATH $HOME/go/bin
set -gx PATH $PATH $HOME/.local/share/solana/install/active_release/bin

# Greeting
set -g fish_greeting ""
