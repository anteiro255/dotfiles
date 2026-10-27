read -p "Do you wanna install base packages? [y/n] " is_base
if [[ "$is_base" != "y" && "$is_base" != "n" ]]; then exit 1; fi
read -p "Do you have bluetooth? [y/n] " is_bluetooth
if [[ "$is_bluetooth" != "y" && "$is_bluetooth" != "n" ]]; then exit 1; fi
read -p "Do you have audio? [y/n] " is_audio
if [[ "$is_audio" != "y" && "$is_audio" != "n" ]]; then exit 1; fi
read -p "Do you have wifi? [y/n] " is_wifi
if [[ "$is_wifi" != "y" && "$is_wifi" != "n" ]]; then exit 1; fi
read -p "Do you have gps? [y/n] " is_gps
if [[ "$is_gps" != "y" && "$is_gps" != "n" ]]; then exit 1; fi
read -p "Do you have a fingerprint scanner? [y/n] " is_finger_print
if [[ "$is_finger_print" != "y" && "$is_finger_print" != "n" ]]; then exit 1; fi
read -p "Do you have an infrared camera? [y/n] " is_infrared_camera
if [[ "$is_infrared_camera" != "y" && "$is_infrared_camera" != "n" ]]; then exit 1; fi
read -p "Do you wanna install additional packages? [y/n] " is_additional
if [[ "$is_additional" != "y" && "$is_additional" != "n" ]]; then exit 1; fi
read -p "Do you wanna add multilib to pacman? [y/n] " is_add_multilib
if [[ "$is_add_multilib" != "y" && "$is_add_multilib" != "n" ]]; then exit 1; fi
read -p "Do you wanna install programming languages? [y/n] " is_prog_lang
if [[ "$is_prog_lang" != "y" && "$is_prog_lang" != "n" ]]; then exit 1; fi

install_command="sudo pacman -S --noconfirm --needed --ask 4"
install_aur_command="yay -S --needed --answerdiff None --answerclean None --removemake"

if [[ "$is_add_multilib" == "y" ]]; then
	echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
fi
sudo pacman -Syu --noconfirm --needed

if ! command -v yay &> /dev/null; then
	git clone https://aur.archlinux.org/yay.git yay_tmp
	cd yay_tmp || exit 1
	makepkg -si --noconfirm || exit 1
	cd ..
	rm -rf yay_tmp
fi

if [[ "$is_base" == "y" ]]; then
	$install_command base-devel git # base
	$install_command niri waybar fuzzel mako nautilus fish # main
	$install_command wl-clipboard wl-clip-persist cliphist # clipboard
	$install_command ttf-jetbrains-mono-nerd noto-fonts-emoji # fonts
	$install_command libnotify polkit xdg-desktop-portal xdg-desktop-portal-gnome gnome-keyring qt5ct qt6ct qt5-base qt6-base qt5-wayland qt6-wayland libxcb xcb-util-cursor libxcb-cursor0 xorg-xwayland xwayland-satellite # libs
	$install_command chafa yazi brightnessctl micro helix termdown # cli useful
	$install_command zed # main GUI apps
	$install_command clapper imv # gui useful
	$install_command swaybg swayosd hypridle hyprlock grim playerctl # additional
	$install_command 7zip file-roller # archieves

	$install_aur_command zen-browser # browser
	$install_aur_command bemoji soteria-bin # emoji chooser, polkit
	$install_aur_command tokyonight-gtk-theme-git # theme
	$install_aur_command bibata-cursor-theme-bin # cursor

	sudo groupadd video
	sudo usermod -aG video $USER
	sudo groupadd audio
	sudo usermod -aG audio $USER
	sudo groupadd network
	sudo usermod -aG network $USER
	sudo groupadd input
	sudo usermod -aG input $USER
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo groupadd sudo
	sudo usermod -aG sudo $USER


	git config --global credential.helper store
	sudo chsh -s /usr/bin/fish "$USER"
fi
if [[ "$is_bluetooth" == "y" ]]; then
	$install_command bluez
	$install_aur_command bluetui
fi
if [[ "$is_audio" == "y" ]]; then
	$install_command pipewire pipewire-pulse wireplumber alsa-utils pulsemixer
	$install_aur_command trix-player
	$install_command gst-libav gst-plugins-bad gst-plugins-ugly # decoders for audio and music
fi
if [[ "$is_wifi" == "y" ]]; then
	$install_command networkmanager
	$install_aur_command wifitui
fi
if [[ "$is_gps" == "y" ]]; then
	$install_command gpsd geoclue
fi
if [[ "$is_finger_print" == "y" ]]; then
	$install_command fprintd	
fi
if [[ "$is_infrared_camera" == "y" ]]; then
	$install_aur_command howdy-bin	
fi
if [[ "$is_additional" == "y" ]]; then
	sudo pacman -S --needed fastfetch
	sudo pacman -S --needed transmission-gtk
	sudo pacman -S --needed telegram-desktop
	sudo pacman -S --needed nwg-look
	sudo pacman -S --needed nirimod
	sudo pacman -S --needed steam
	sudo pacman -S --needed obsidian
	sudo pacman -S --needed syncthing
	sudo pacman -S --needed fd-find # modern find
	sudo pacman -S --needed ripgrep # modern grep
	sudo pacman -S --needed imagemagick # image converter

	yay -S --needed clock-tui-bin
	yay -S --needed xdgctl
	yay -S --needed localsend-bin
fi
if [[ "$is_prog_lang" == "y" ]]; then
	# go
	$install_command go
	go install golang.org/x/tools/gopls@latest # LTS
	go install github.com/go-delve/delve/cmd/dlv@latest # debugger

	# rust
	$install_command rustup
	rustup default stable
	rustup component add rustfmt # formatter
	rustup component add rust-analyzer # lsp
	rustup component add clippy # advicer for code

	# JS and TS
	$install_command nodejs npm
	sudo npm install -g typescript typescript-language-server # LSP for JS and TS
	sudo npm install -g prettier # formatter

	# python
	$install_command python uv
	uv tool install ruff
	uv tool install pyright
	uv tool install pytest
fi

systemctl --user daemon-reload
systemctl --user enable --now swayidle.service
