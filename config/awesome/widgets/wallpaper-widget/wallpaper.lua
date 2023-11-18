local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local HOME = os.getenv("HOME")
local ICON_DIR = HOME .. "/.config/awesome/widgets/wallpaper-widget/icons/"
local SCRIPT_DIR = HOME .. "/.config/awesome/scripts/"

local config = {}
-- Icon widget
config.image = "wallpaper.svg"
config.resize = true
config.forced_height = 18

-- Margin widget
config.fg_normal = "#aaaaaaff"
config.fg_focus = "#aaccccff"
config.bg_normal = "#00000000"
config.bg_focus = "#000000ff"
config.margins = 4

-- Command
config.terminal = "wezterm start --"

local function worker(user_args)
	local args = user_args or {}
	local _config = {}
	for prop, value in pairs(config) do
		_config[prop] = args[prop] or beautiful[prop] or value
	end

	local vm_button = wibox.widget({
		{
			{ -- Create Icon
				image = ICON_DIR .. _config.image,
				resize = _config.resize,
				widget = wibox.widget.imagebox,
			},
			margins = _config.margins,
			widget = wibox.container.margin,
		},
		bg = _config.bg_normal,
		fg = _config.fg_normal,
		widget = wibox.container.background,
	})

	vm_button:connect_signal("mouse::enter", function(c)
		c:set_bg(_config.bg_focus)
		c:set_fg(_config.fg_focus)
	end)
	vm_button:connect_signal("mouse::leave", function(c)
		c:set_bg(_config.bg_normal)
		c:set_fg(_config.fg_normal)
	end)
	vm_button:connect_signal("button::press", function(c, _, _, button)
		if button == 1 then
			c:set_bg(_config.bg_normal)
			c:set_fg(_config.fg_normal)
			awful.spawn.with_shell(SCRIPT_DIR .. "set-wallpaper.sh", {})
		elseif button == 3 then
			c:set_bg(_config.bg_normal)
			c:set_fg(_config.fg_normal)
			awful.spawn.with_shell(SCRIPT_DIR .. "random-wallpaper.sh", {})
		end
	end)

	return vm_button
end

return worker

