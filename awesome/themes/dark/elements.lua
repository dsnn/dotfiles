local colors = require("themes.dark.colors")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

theme.font          = "Roboto Mono Nerd Font Complete 10"
theme.taglist_font  = "Roboto Mono Nerd Font Complete 10"

theme.bg_normal     = colors.color['grey900']    .. "cc"
theme.bg_focus      = colors.color['grey900']    .. "cc"
theme.bg_urgent     = colors.color['orange900']  .. "cc"
theme.bg_minimize   = colors.color['grey700']    .. "cc"
theme.bg_systray    = colors.color['grey900']    .. "cc"

theme.fg_normal     = colors.color['grey700']
theme.fg_focus      = colors.color['white']
theme.fg_urgent     = colors.color['white']
theme.fg_minimize   = colors.color['white']

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)

theme.border_normal = colors.color['black']   .. "cc"
theme.border_focus  = colors.color['grey800']    .. "cc"
theme.border_marked = colors.color['red900'] .. "cc"

theme.taglist_bg_focus = colors.color['red500'] .. "cc"
theme.taglist_fg_focus = colors.color['white']

theme.tasklist_bg_normal = colors.color['white']    .. "88"
theme.tasklist_bg_focus  = colors.color['red300']   .. "88"
theme.tasklist_fg_focus  = colors.color['black']

theme.titlebar_bg_normal = colors.color['white']   .. "cc"
theme.titlebar_bg_focus  = colors.color['white']   .. "cc"
theme.titlebar_fg_focus  = colors.color['black']   .. "cc"

local taglist_square_size = dpi(4)

theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, colors.color['black']
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, colors.color['white']
)

theme.taglist_squares_sel      = theme_path .. "taglist/square_sel.png"
theme.taglist_squares_unsel    = theme_path .. "taglist/square_unsel.png"

theme.menu_submenu_icon = themes_path .. "submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(140)

theme.menu_bg_normal = colors.color['white']  .. "cc"
theme.menu_bg_focus  = colors.color['red300'] .. "cc"
theme.menu_fg_focus  = colors.color['black']

theme.menu_border_color = colors.color['blue500'] .. "cc"
theme.menu_border_width = 1
