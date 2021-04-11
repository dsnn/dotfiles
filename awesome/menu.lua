local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

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

menu = {
   items = {
      { "power", power_menu },
      { "awesome", awesome_menu },
      { "terminal", terminal }
   }
}

return menu
