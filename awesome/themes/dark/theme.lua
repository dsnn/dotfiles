local awful         = require("awful")
awful.util          = require("awful.util")
local theme_assets  = require("beautiful.theme_assets")
local gfs           = require("gears.filesystem")
local themes_path   = gfs.get_themes_dir()
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi
local cs            = require("themes.dark.colors")

local theme         = {}

theme.wallpaper     = awful.util.getdir("config") .. "wall.jpg"

theme.font          = "Roboto Mono Nerd Font Complete 10"
theme.taglist_font  = "Roboto Mono Nerd Font Complete 10"

theme.bg_normal     = cs.color['grey900']    .. "cc"
theme.bg_focus      = cs.color['grey900']    .. "cc"
theme.bg_urgent     = cs.color['orange900']  .. "cc"
theme.bg_minimize   = cs.color['grey700']    .. "cc"
theme.bg_systray    = cs.color['grey900']    .. "cc"

theme.fg_normal     = cs.color['grey700']
theme.fg_focus      = cs.color['white']
theme.fg_urgent     = cs.color['white']
theme.fg_minimize   = cs.color['white']

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)

theme.border_normal = cs.color['black']   .. "cc"
theme.border_focus  = cs.color['grey800']    .. "cc"
theme.border_marked = cs.color['red900'] .. "cc"

local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, cs.color['black']
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, cs.color['white']
)

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(140)

local titlebar_path                             = themes_path .. "default/titlebar/"
theme.titlebar_close_button_normal              = titlebar_path.."close_normal.png"
theme.titlebar_close_button_focus               = titlebar_path.."close_focus.png"
theme.titlebar_minimize_button_normal           = titlebar_path.."minimize_normal.png"
theme.titlebar_minimize_button_focus            = titlebar_path.."minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = titlebar_path.."ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = titlebar_path.."ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = titlebar_path.."ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = titlebar_path.."ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = titlebar_path.."sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = titlebar_path.."sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = titlebar_path.."sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = titlebar_path.."sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = titlebar_path.."floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = titlebar_path.."floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = titlebar_path.."floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = titlebar_path.."floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = titlebar_path.."maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_path.."maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = titlebar_path.."maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = titlebar_path.."maximized_focus_active.png"

local layouts_path      = themes_path .. "default/layouts/"
theme.layout_fairh      = layouts_path.."fairhw.png"
theme.layout_fairv      = layouts_path.."fairvw.png"
theme.layout_floating   = layouts_path.."floatingw.png"
theme.layout_magnifier  = layouts_path.."magnifierw.png"
theme.layout_max        = layouts_path.."maxw.png"
theme.layout_fullscreen = layouts_path.."fullscreenw.png"
theme.layout_tilebottom = layouts_path.."tilebottomw.png"
theme.layout_tileleft   = layouts_path.."tileleftw.png"
theme.layout_tile       = layouts_path.."tilew.png"
theme.layout_tiletop    = layouts_path.."tiletopw.png"
theme.layout_spiral     = layouts_path.."spiralw.png"
theme.layout_dwindle    = layouts_path.."dwindlew.png"
theme.layout_cornernw   = layouts_path.."cornernww.png"
theme.layout_cornerne   = layouts_path.."cornernew.png"
theme.layout_cornersw   = layouts_path.."cornersww.png"
theme.layout_cornerse   = layouts_path.."cornersew.png"

theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.icon_theme = nil

return theme
