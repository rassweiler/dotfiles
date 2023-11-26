#!/bin/bash

# Wallpaper
read -r -p "Setup Wallpaper? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	wal -i ~/.config/awesome/wallpaper.png
	sudo mkdir -p /usr/share/defaults/wallpaper/
	sudo cp ~/.config/awesome/wallpaper.png /usr/share/defaults/wallpaper/wallpaper.png
fi

# Paru
read -r -p "Install Rust and Paru? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	rustup toolchain install stable
	rustup default stable
	cd /tmp
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
	cd ~
	paru -Syu
fi

# Packages
read -r -p "Install packages? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	paru -S --needed - <packages.txt
fi

# Greeter
read -r -p "Setup Lightdm? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sudo cp ~/dotfiles/slick-greeter.conf /etc/lightdm/slick-greeter.conf
	sudo systemctl enable lightdm.service
fi

# VM
read -r -p "Setup VM? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	sudo systemctl enable libvirtd
	sudo systemctl enable virtlogd.socket
	sudo usermod -aG kvm,libvirt $(whoami)
fi

# Theme
read -r -p "Setup GTK Theme? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark-B"
	gsettings set org.gnome.desktop.wm.preferences theme "Tokyonight-Dark-B"
	gsettings set org.gnome.desktop.interface icon-theme "Tokyonight-Dark"
	gsettings set org.gnome.desktop.interface cursor-theme "Qogir-dark"
	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
fi

# Set Shell
read -r -p "Change user shell to Fish? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
	chsh -s /bin/fish
fi

