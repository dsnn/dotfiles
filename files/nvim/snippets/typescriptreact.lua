local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node

return {
  s("ec", {
    t("export const "),
    i(1, "name"),
    t(" = ("),
    i(2, "data:any"),
    t({ ") => {", "\treturn null;", "};" }),
  }),

  -- console.log
  s("log", fmt("console.log(\"result: \", {});", i(1))),
}
