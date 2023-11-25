#!/bin/fish

# Set Shell
chsh -s /bin/fish

# Wallpaper
wal -i ~/.config/awesome/wallpaper.png
sudo mkdir -p /usr/share/defaults/wallpaper/
sudo cp ~/.config/awesome/wallpaper.png /usr/share/defaults/wallpaper/wallpaper.png

# Paru
rustup toolchain install stable
rustup default stable
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~
paru -Syu

# Packages
paru -S --needed - < packages.txt

# Greeter
sudo cp ~/dotfiles/slick-greeter.conf /etc/lightdm/slick-greeter.conf
sudo systemctl enable lightdm.service

# VM
sudo systemctl enable libvirtd
sudo systemctl enable virtlogd.socket
sudo usermod -aG kvm,libvirt (whoami)

# Theme
gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark-B"
gsettings set org.gnome.desktop.wm.preferences theme "Tokyonight-Dark-B"
gsettings set org.gnome.desktop.interface icon-theme "Tokyonight-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "Qogir-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"