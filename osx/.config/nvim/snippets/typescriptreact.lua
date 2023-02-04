local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local sn = ls.snippet_node

return {
  -- import thing from 'thing'
  s("import", fmt("import {} from '{}';", { i(1, "module"), rep(1) })),

  -- <export> const <thing> = (<data>:any) => { <empty|return null;>};
  s("const func", fmt([[
  {} {} = ({}:any) => {{
    {}
  }};
  ]], {
      c(1, {
        t("const"),
        t("export const"),
      }),
      i(2, "name"),
      i(3, "data"),
      c(4, {
        t(""),
        t("return null;")
      }),
    }
  )),

  -- if (true) { }
  s("if", fmt([[
if ({}) {{
  {}
}}
  ]], {
      i(1, "exp"),
      i(2),
    })),

  -- const var thing = thing;
  s("const var", fmt("const {} = {};", { i(1), i(2) })),

  -- console.log
  s("log", fmt("console.log(\"result: \", {});", i(1))),

  -- test
  s("test", fmt([[
    test("{}", () => {{
      {}
    }})
  ]], {
      i(1),
      c(2, {
        t(""),
        t("expect(true).toBe(true);"),
      }),
    })),

  -- describe
  s("describe", fmt([[
    describe("{}", () => {{
      test("{}", () => {{
        {}
      }});
    }})
  ]], {
      i(1),
      i(2),
      c(3, {
        t(""),
        t("expect(true).toBe(true);"),
      }),
    })),
}
