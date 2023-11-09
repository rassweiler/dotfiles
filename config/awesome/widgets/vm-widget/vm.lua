local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local HOME = os.getenv('HOME')
local ICON_DIR = HOME .. '/.config/awesome/widgets/vm-widget/icons/'
local SCRIPT_DIR = HOME .. '/.config/awesome/scripts/'

local config = {}
-- Icon widget
config.image = 'windows.svg'
config.resize = true
config.forced_height = 20

-- Margin widget
config.color = "#aaaaaaff"
config.bg_normal = "#00000000"
config.bg_focus = "#000000ff"
config.margins = 4

-- Command
config.terminal = 'wezterm start --'
config.script = 'vm_windows.sh'

local function worker(user_args)
	local args = user_args or {}
	local _config = {}
	for prop, value in pairs(config) do
		_config[prop] = args[prop] or beautiful[prop] or value
	end

	local vm_button = wibox.widget{
		{
			{ -- Create Icon
				image = ICON_DIR .. _config.image,
				resize = _config.resize,
				color = _config.color,
				forced_height = _config.forced_height,
				widget = wibox.widget.imagebox
			},
			margins = _config.margins,
			widget = wibox.container.margin
		},
		bg = _config.bg_normal,
		widget = wibox.container.background
	}

	vm_button:connect_signal("mouse::enter", function(c) c:set_bg(_config.bg_focus) end)
	vm_button:connect_signal("mouse::leave", function(c) c:set_bg(_config.bg_normal) end)
	vm_button:connect_signal("button::press", function(c, _, _, button) 
		if button == 1 then
			c:set_bg(_config.bg_normal)
			awful.spawn.with_shell(SCRIPT_DIR .. _config.script, {})
		end
	end)

	return vm_button
end

return worker