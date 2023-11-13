local wezterm = require 'wezterm';
local xresources = dofile('/home/kylerassweiler/.cache/wal/colors-wezterm.lua')
return {
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		{family="Symbols Nerd Font Mono", scale=1.2},
	 }),
	font_size = 12,
	--color_scheme = "Dracula",
	window_background_opacity = 0.8,
	scrollback_lines = 3500,
	colors = xresources.colors
}
