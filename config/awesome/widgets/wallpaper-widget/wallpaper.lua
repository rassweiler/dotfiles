-------------------------------------------------
-- Wallpaper widget for Awesome Window Manager
-- @author Kyle Rassweiler
-- @copyright 2023 Kyle Rassweiler
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")


local HOME_DIR = os.getenv("HOME")
local SCRIPT_DIR = HOME_DIR .. '/.config/awesome/scripts/'
local ICON_DIR = HOME_DIR .. '/.config/awesome/widgets/wallpaper-widget/icons/'

local wallpaper_widget = wibox.widget {
	{
		{
			image = ICON_DIR .. 'wallpaper.svg',
			resize = true,
			widget = wibox.widget.imagebox,
		},
		margins = 4,
		layout = wibox.container.margin
	},
	shape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 4)
	end,
	widget = wibox.container.background,
}

local popup = awful.popup {
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		 gears.shape.rounded_rect(cr, width, height, 4)
	end,
	border_width = 1,
	border_color = beautiful.bg_focus,
	maximum_width = 400,
	offset = { y = 5 },
	widget = {}
}

local function worker(user_args)
	local rows = { layout = wibox.layout.fixed.vertical }

	local args = user_args or {}

	local font = args.font or beautiful.font

	local onselect = args.onselect or function () awful.spawn.with_shell(SCRIPT_DIR .. "set-wallpaper.sh", {
		ontop = true,
		floating = true,
		above = true,
		hidden = false
	}) end
	local onrandom = args.onrandom or function() awful.spawn.with_shell(SCRIPT_DIR .. "random-wallpaper.sh", {}) end

	local menu_items = {
		 { name = 'Select Wallpaper', icon_name = 'select.svg', command = onselect },
		 { name = 'Random Wallpaper', icon_name = 'random.svg', command = onrandom },
	}

	for _, item in ipairs(menu_items) do

		 local row = wibox.widget {
			  {
					{
						 {
							  image = ICON_DIR .. item.icon_name,
							  resize = false,
							  widget = wibox.widget.imagebox
						 },
						 {
							  text = item.name,
							  font = font,
							  widget = wibox.widget.textbox
						 },
						 spacing = 12,
						 layout = wibox.layout.fixed.horizontal
					},
					margins = 8,
					layout = wibox.container.margin
			  },
			  bg = beautiful.bg_normal,
			  widget = wibox.container.background
		 }

		 row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)
		 row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)

		 local old_cursor, old_wibox
		 row:connect_signal("mouse::enter", function()
			  local wb = mouse.current_wibox
			  old_cursor, old_wibox = wb.cursor, wb
			  wb.cursor = "hand1"
		 end)
		 row:connect_signal("mouse::leave", function()
			  if old_wibox then
					old_wibox.cursor = old_cursor
					old_wibox = nil
			  end
		 end)

		 row:buttons(awful.util.table.join(awful.button({}, 1, function()
			  popup.visible = not popup.visible
			  item.command()
		 end)))

		 table.insert(rows, row)
	end
	popup:setup(rows)

	wallpaper_widget:buttons(
			  awful.util.table.join(
						 awful.button({}, 1, function()
							  if popup.visible then
									popup.visible = not popup.visible
									wallpaper_widget:set_bg('#00000000')
							  else
									popup:move_next_to(mouse.current_widget_geometry)
									wallpaper_widget:set_bg(beautiful.bg_focus)
							  end
						 end)
			  )
	)

	return wallpaper_widget

end

return worker