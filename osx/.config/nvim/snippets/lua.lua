local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local i = ls.insert_node
local s = ls.snippet

return {
  -- local thing = require("thing")
  s("req", fmt("local {} = require('{}')", { i(1, "module"), rep(1) })),
}
