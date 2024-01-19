local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
  s("chore", { t("chore("), i(1, "text"), t("): "), i(2, "desc"), }),
  s("feat", { t("feat("), i(1, "text"), t("): "), i(2, "desc"), }),
  s("fix", { t("fix("), i(1, "text"), t("): "), i(2, "desc"), }),
  s("refactor", { t("refactor("), i(1, "text"), t("): "), i(2, "desc"), }),
  s("docs", { t("docs("), i(1, "text"), t("): "), i(2, "desc"), }),
  s("style", { t("style("), i(1, "text"), t("): "), i(2, "desc"), }),
  s("test", { t("test("), i(1, "text"), t("): "), i(2, "desc"), }),
}
