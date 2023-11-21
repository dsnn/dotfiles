local awful = require("awful")
awful.util  = require("awful.util")

local vars = {
    terminal  = "kitty",
    modkey    = "Mod4",
    wallpaper = "~/.config/wall.jpg"
    -- editor = os.getenv("EDITOR") or "vim",
    -- editor_cmd = terminal .. " -e " .. editor
}

return vars
