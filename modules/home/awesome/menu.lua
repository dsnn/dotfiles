local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local freedesktop = require("freedesktop")
local beautiful = require("beautiful")

local terminal = RC.vars.terminal
local editor = os.getenv("EDITOR") or "vim"
local editor_cmd = terminal .. " -e " .. editor

local menu = {}

local awesome_menu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local power_menu = {
   { "shutdown", "poweroff"},
   { "reboot",   "shutdown -r 0" },
}

menu = freedesktop.menu.build {
    before = {
        { "Power", power_menu },
        { "Awesome", awesome_menu },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
}

-- menu = {
--    items = {
--       { "power", power_menu },
--       { "awesome", awesome_menu },
--       { "terminal", terminal }
--    }
-- }

return menu
