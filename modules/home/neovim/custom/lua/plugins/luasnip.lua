return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip").setup({
      history = true,
      updatevents = "TextChanged, TextChangedI"
    })

    require("luasnip.loaders.from_lua").load({
      paths = "~/.config/nvim/snippets"
    })
  end
}
