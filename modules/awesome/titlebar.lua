local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

client.connect_signal("request::titlebars", function(c)

    -- buttons
    local moveButton = awful.button({ }, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end)

    local resizeButton = awful.button({ }, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end)

    local buttons = gears.table.join(moveButton, resizeButton)

    local minimizeButton = {
      awful.titlebar.widget.minimizebutton (c),
      right = 8,
      layout = wibox.container.margin
    }

    local maximizeButton = {
      awful.titlebar.widget.maximizedbutton(c),
      right = 8,
      layout = wibox.container.margin()
    }

    local closeButton = {
      awful.titlebar.widget.closebutton(c),
      right = 8,
      layout = wibox.container.margin()
    }

    -- titlebar
    awful.titlebar(c) : setup {
        {
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        {
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        {
          {
            minimizeButton,
            maximizeButton,
            closeButton,
            layout = wibox.layout.fixed.horizontal(),
          },
          top    = 4,
          bottom = 4,
          layout = wibox.container.margin()
        },
        layout = wibox.layout.align.horizontal
    }
end)
