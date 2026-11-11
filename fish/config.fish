# Environment variables
set -gx EDITOR helix
set -gx GUI_EDITOR zed

set -gx AUR_INSTALLER yay
set -gx BROWSER zen-browser
set -gx FILE_MANAGER nautilus
set -gx IMAGE_VIEWER imv
set -gx MEDIA_PLAYER clapper
set -gx TERMINAL alacritty

# PATH
fish_add_path \
    ~/.local/bin \
    ~/.local/bin/my_scripts \
    ~/.cargo/bin \
    ~/.opencode/bin \
    ~/go/bin \
    ~/.local/share/solana/install/active_release/bin

# Functions
function off_in
    sleep $argv[1]; and shutdown now
end

function vnc_on
    sudo modprobe vkms
    or return 1

    sleep 0.5
    niri msg output Virtual-1 on
    wayvnc -r -o Virtual-1 0.0.0.0 5900 >/dev/null 2>&1 &
    disown
end

function vnc_off
    niri msg output Virtual-1 off
    pkill wayvnc
    sudo modprobe -r vkms
end

function y --description "Yazi file manager with cwd integration"
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")

    command yazi $argv --cwd-file="$tmp"

    if read -z cwd <"$tmp"; and test -d "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end

    command rm -f -- "$tmp"
end

function gt --description "Create directory and enter it"
    if test (count $argv) -eq 0
        echo "Usage: gt <directory>"
        return 1
    end

    mkdir -p -- $argv[1]; and cd -- $argv[1]
end

# Interactive configuration
if status is-interactive
    # Editor shortcuts
    alias _niri "$EDITOR ~/.config/niri/config.kdl"
    alias _fish "$EDITOR ~/.config/fish/config.fish"

    # One-character shortcuts
    alias s sudo
    alias o open
    alias g git
    alias m micro
    alias h helix
    alias c clear

    # Two-character shortcuts
    alias py python
    alias oc opencode
    alias ff "fastfetch --logo-color-1 blue --logo-color-2 blue --color blue"

    # Package management
    alias get_pcm "sudo pacman -S --noconfirm --needed"
    alias del_pcm "sudo pacman -Rns --noconfirm"
    alias get "$AUR_INSTALLER -S --noconfirm --needed"
    alias del "$AUR_INSTALLER -Rns --noconfirm"
    alias update_system "$AUR_INSTALLER --noconfirm"

    # System management
    alias smd_restart "sudo systemctl restart smb nmb winbind"
    alias rebuild_kernel "sudo mkinitcpio -P"

    alias fan_manual_on "sudo modprobe -r thinkpad_acpi; sudo modprobe thinkpad_acpi fan_control=1"
    alias fan_manual_off "sudo modprobe -r thinkpad_acpi; sudo modprobe thinkpad_acpi fan_control=0"

    # TClock
    set -l tclock_args -c blue

    alias timer "tclock -c blue timer -d"
    alias countdown_to "tclock -c blue countdown --time"
    alias stopwatch "tclock -c blue stopwatch"
    alias clock "tclock -c blue clock"

    # Greeting
    set -g fish_greeting ""
end
