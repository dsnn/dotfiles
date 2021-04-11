local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local menu = {}
local M = {}

local terminal = RC.vars.terminal
local editor = os.getenv("EDITOR") or "vim"
local editor_cmd = terminal .. " -e " .. editor

menu.awesome = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

menu.power = {
   { "shutdown", "poweroff"},
   { "reboot",   "shutdown -r 0" },
}

function M.get()
  local menu_items = {
    { "power", menu.power },
    { "awesome", menu.awesome },
    { "terminal", terminal }
  }
  return menu_items
end

return setmetatable({}, {
    __call = function(_, ...)
        return M.get(...)
    end
})
