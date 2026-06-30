local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s("cx", {
    t("<"), i(1, "div"), t(' className={cx(classNames.'), i(2), t(")}>"),
    t({ "", "\t" }), i(3),
    t({ "", "</" }), f(function(args) return args[1][1] end, { 1 }), t(">"),
  }),
}
