pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local gears = require("gears")
local home = os.getenv("HOME")
local gfs = require("gears.filesystem")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

RC = {}
RC.vars = require('variables')
modkey = RC.vars.modkey

require("error")

beautiful.init(home .. "/.config/awesome/themes/dark/theme.lua")
-- beautiful.init(gfs.get_themes_dir() .. "default/theme.lua")

if (RC.vars.wallpaper) then
    local wallpaper = RC.vars.wallpaper
    if awful.util.file_readable(wallpaper) then theme.wallpaper = wallpaper end
end

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

local bindings = require('bindings')

RC.layouts  = {
    awful.layout.suit.floating,
    awful.layout.suit.tile
}
awful.layout.layouts = RC.layouts

awful.screen.connect_for_each_screen(function(s)
    awful.tag( { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, RC.layouts[1])
end)

RC.mainmenu = require('menu')
-- RC.mainmenu = awful.menu({ items = menu.items })
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)

menubar.utils.terminal = RC.vars.terminal

RC.globalkeys = bindings.bindtotags(bindings.globalkeys)

root.buttons(bindings.globalbuttons)
root.keys(RC.globalkeys)

mykeyboardlayout = awful.widget.keyboardlayout()

require("statusbar")

local rules = require('rules')

awful.rules.rules = rules(
    bindings.clientkeys,
    bindings.clientbuttons
)

require("titlebar")

-- rounded corners
-- client.connect_signal("property::geometry", function (c)
--   delayed_call(function()
--     gears.surface.apply_shape_bounding(c, gears.shape.rounded_rect, 15)
--   end)
-- end)

client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
