local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local home = os.getenv("HOME")
local gfs = require("gears.filesystem")

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

