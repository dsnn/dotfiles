local ls = require("luasnip")
local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local extras = require("luasnip.extras")

return {
	s("todo", t("TOOO: "), i("text")), -- TOOO: fix contextual comment 

  s("date", c(1, {
    extras.partial(os.date, "%Y-%m-%d"),
    extras.partial(os.date, "%Y-%m-%d %H:%M:%S")
  })),

	s("time", extras.partial(os.date, "%H:%M:%S")),

  s("lorem", c(1, {
    t("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),

    t("Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget mauris sed urna lacinia auctor."),

    t("Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget mauris sed urna lacinia auctor. Mauris pellentesque nisl ut ligula varius condimentum. Maecenas orci enim, aliquam consectetur velit eget, aliquam condimentum arcu. Phasellus sed vehicula mi. Morbi tempor massa vitae urna finibus, eu commodo neque bibendum."),

    t("Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget mauris sed urna lacinia auctor. Mauris pellentesque nisl ut ligula varius condimentum. Maecenas orci enim, aliquam consectetur velit eget, aliquam condimentum arcu. Phasellus sed vehicula mi. Morbi tempor massa vitae urna finibus, eu commodo neque bibendum. Lorem ipsum dolor sit amet,consectetur adipiscing elit. Nullam dictum elit mollis blandit aliquet. Proin placerat tempor porttitor. Praesent vel bibendum dolor, ut vestibulum tellus. Nam mollis dapibus eros, et pretium lacus porttitor a. Nullam gravida magna mauris, quis vestibulum nisl aliquet tempor. Duis ut elementum leo. Nulla facilisi."),
  }))
}
