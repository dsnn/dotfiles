pcall(require, "luarocks.loader")

local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local menubar   = require("menubar")


require("awful.autofocus")
require("awful.hotkeys_popup.keys")

-- global variables
dpi = beautiful.xresources.apply_dpi
user = {
    terminal     = "kitty -1",
    browser      = "firefox",
    file_manager = "thunar",
    editor       = "kitty -1 --class editor -e nvim",
    email_client = "kitty -1 --class email -e neomutt",

    web_search_cmd = "xdg-open https://google.com/?q=",

    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Documents/Screenshots",
    },

    battery_threshold_low = 20,
    battery_threshold_critical = 5,

    openweathermap_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    openweathermap_city_id = "yyyyyy",
    weather_units = "metric",
}

-- TODO: replace with global user obj
RC      = {}
RC.vars = require('variables')
modkey  = RC.vars.modkey

-- error handler
require("error")

-- theme
beautiful.init(os.getenv("HOME").. "/.config/awesome/themes/dark/theme.lua")

-- wallpaper
if (RC.vars.wallpaper) then
    local wallpaper = RC.vars.wallpaper
    if awful.util.file_readable(wallpaper) then theme.wallpaper = wallpaper end
end

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- layouts
RC.layouts = { awful.layout.suit.floating, awful.layout.suit.tile }
awful.layout.layouts = RC.layouts
awful.screen.connect_for_each_screen(function(s)
    awful.tag( { "1", "2", "3", "4", "5" }, s, RC.layouts[1])
end)

RC.mainmenu = require('menu')
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)

menubar.utils.terminal = RC.vars.terminal

-- key bindings
local keys = require('keys')
mykeyboardlayout = awful.widget.keyboardlayout()

local rules = require('rules')
awful.rules.rules = rules(keys.clientkeys, keys.clientbuttons)

-- statusbar
require("statusbar")

-- titlebar
require("titlebar")

-- rounded corners
-- client.connect_signal("property::geometry", function (c)
--   delayed_call(function()
--     gears.surface.apply_shape_bounding(c, gears.shape.rounded_rect, 15)
--   end)
-- end)

-- no offscreen
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- border color on (un)focus
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
