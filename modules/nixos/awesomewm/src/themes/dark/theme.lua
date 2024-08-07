local awful         = require("awful")
awful.util          = require("awful.util")
local theme_assets  = require("beautiful.theme_assets")
local colors        = require("themes.dark.colors")

-- module
local theme         = {}

-- paths
theme.dir   = os.getenv("HOME") .. "/.config/awesome/themes/dark"

-- wallpaper
theme.wallpaper     = os.getenv("HOME") .. "/.config/wall.jpg"

-- font
theme.font          = "Roboto Mono Nerd Font Complete 8"

-- colors
theme.bg_normal     = colors.color['grey800'] .. "cc"
theme.bg_focus      = colors.color['grey800'] .. "cc"
theme.bg_urgent     = colors.color['orange900'] .. "cc"
theme.bg_minimize   = colors.color['grey700'] .. "cc"
theme.bg_systray    = colors.color['grey800'] .. "cc"

theme.fg_normal     = colors.color['white']
theme.fg_focus      = colors.color['white']
theme.fg_urgent     = colors.color['white']
theme.fg_minimize   = colors.color['white']

-- border & gaps
theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)

-- border colors
theme.border_normal = colors.color['grey800'] .. "cc"
theme.border_focus  = colors.color['grey800'] .. "cc"
theme.border_marked = colors.color['red900'] .. "cc"

-- taglist
theme.taglist_font  = "Roboto Mono Nerd Font Complete 8"

local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, colors.color['black']
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, colors.color['white']
)

--- right click menu
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(140)

--- titlebar
theme.titlebar_close_button_normal              = theme.dir .. "/icons/close.png"
theme.titlebar_close_button_focus               = theme.dir .. "/icons/close.png"
theme.titlebar_minimize_button_normal           = theme.dir .. "/icons/minimize.png"
theme.titlebar_minimize_button_focus            = theme.dir .. "/icons/minimize.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/maximize.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/maximize.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/maximize.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/maximize.png"

-- Layouts
theme.layout_floating   = theme.dir .. "/icons/floating.png"
theme.layout_tile       = theme.dir .. "/icons/tile.png"

theme.icon_theme = nil

return theme
