#!/bin/bash

i3p="$HOME/dotfiles/config/i3/themes"
i3t="$HOME/dotfiles/config/i3/theme.conf"
ptconf="$HOME/dotfiles/config/polybar/themes/configs"
pconf="$HOME/dotfiles/config/polybar/config"
ptcoolor="$HOME/dotfiles/config/polybar/themes/colors"
pcolor="$HOME/dotfiles/config/polybar/themes/theme.ini"
mods="$HOME/dotfiles/config/polybar/themes/modules"
pmods="$HOME/dotfiles/config/polybar/themes/modules/modules.ini"
alconf="$HOME/dotfiles/config/alacritty/alacritty.yml"
wzconf="$HOME/dotfiles/config/weztyerm/wezterm.lua"

declare -a options=(
	'Dracula'
	'nord'
)

choice=$(printf '%s\n' "${options[@]}" | rofi -demu -i -l 20 -p 'themes')

cp $i3p/$choice.conf $i3t && cp $ptconf/$choice $pconf && cp $mods/$choice.ini $pmods && cp $ptcolor/$choice.ini $pcolor && i3-msg restart

#sed -i "/colors:/c\colors: *$choice" $alconf
wezterm -- config color_scheme=$choice