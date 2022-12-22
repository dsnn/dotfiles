local ls = require("luasnip")
local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local extras = require("luasnip.extras")

return {
	s("todo", t("TOOO: $1")),
  s("date", { extras.partial(os.date, "%Y-%m-%d") }),
  s("lorem", c(1, {
    t("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),

    i(nil, "Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget mauris sed urna lacinia auctor."),

    i(nil, "Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget mauris sed urna lacinia auctor. Mauris pellentesque nisl ut ligula varius condimentum. Maecenas orci enim, aliquam consectetur velit eget, aliquam condimentum arcu. Phasellus sed vehicula mi. Morbi tempor massa vitae urna finibus, eu commodo neque bibendum."),

    i(nil, "Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget mauris sed urna lacinia auctor. Mauris pellentesque nisl ut ligula varius condimentum. Maecenas orci enim, aliquam consectetur velit eget, aliquam condimentum arcu. Phasellus sed vehicula mi. Morbi tempor massa vitae urna finibus, eu commodo neque bibendum. Lorem ipsum dolor sit amet,consectetur adipiscing elit. Nullam dictum elit mollis blandit aliquet. Proin placerat tempor porttitor. Praesent vel bibendum dolor, ut vestibulum tellus. Nam mollis dapibus eros, et pretium lacus porttitor a. Nullam gravida magna mauris, quis vestibulum nisl aliquet tempor. Duis ut elementum leo. Nulla facilisi."),
  }))
}
  -- 1   {
  --   1 ┊ "todo": {
  --   2 ┊ ┊ "prefix": "todo",
  --   3 ┊ ┊ "body": "TODO: $0"
  --   4 ┊ },
  --   5 ┊ "date": {
  --   6 ┊ ┊ "prefix": "date",
  --   7 ┊ ┊ "body": "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE"
  --   8 ┊ },
  --   9 ┊ "time": {
  --  10 ┊ ┊ "prefix": "time",
  --  11 ┊ ┊ "body": "$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND"
  --  12 ┊ },
  --  13 ┊ "datetime": {
  --  14 ┊ ┊ "prefix": "datetime",
  --  15 ┊ ┊ "body": "$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE $CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND"                                                   16 ┊ },
  --  17 ┊ "lorem ipsum 1": {
  --  18 ┊ ┊ "prefix": "lorem1",
  --  19 ┊ ┊ "body": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  --  20 ┊ },
  --  21 ┊ "lorem ipsum 2": {
  --  22 ┊ ┊ "prefix": "lorem2",
  --  23 ┊ ┊ "body": "Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget        _mauris sed urna lacinia auctor."                                                                                                                        24 ┊ },                                                                                                                                                     25 ┊ "lorem ipsum 3": {
  --  26 ┊ ┊ "prefix": "lorem3",
  --  27 ┊ ┊ "body": "Fusce vitae varius purus. Nulla eleifend lorem facilisis sem dictum ornare. Donec at dapibus dui, iaculis viverra ipsum. Phasellus eget        _mauris sed urna lacinia auctor. Mauris pellentesque nisl ut ligula varius condimentum. Maecenas orci enim, aliquam consectetur velit eget, aliquam         _condimentum arcu. Phasellus sed vehicula mi. Morbi tempor massa vitae urna finibus, eu commodo neque bibendum."
