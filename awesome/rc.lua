pcall(require, "luarocks.loader")

local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

RC = {}
RC.vars = require('main.variables')
modkey = RC.vars.modkey

require("main.error")
require('main.theme')

local main = {
    layouts = require("main.layouts"),
    tags    = require("main.tags"),
    menu    = require("main.menu"),
    rules   = require("main.rules"),
}

local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  clientkeys    = require("binding.clientkeys"),
  bindtotags    = require("binding.bindtotags"),
}

RC.layouts  = main.layouts()
RC.tags     = main.tags()
RC.mainmenu = awful.menu({ items     = main.menu() })
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)

menubar.utils.terminal = RC.vars.terminal

RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

require("deco.statusbar")

awful.rules.rules = main.rules(
    binding.clientkeys(),
    binding.clientbuttons()
)

-- require("main.autostart")
require("main.signals")
