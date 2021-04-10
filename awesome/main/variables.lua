local home = os.getenv('HOME')
local editor = os.getenv("EDITOR") or "vim"

local _M = {
    terminal = "kitty",
    modkey = "Mod4",
    editor,
    -- editor_cmd = terminal .. " -e " .. editor,
    editor_cmd = "",
    -- wallpaper = home .. "/.config/wall.jpg"
}

return _M
