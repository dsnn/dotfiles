return {
  "sainnhe/gruvbox-material",
  -- "morhetz/gruvbox",
  lazy = false,
  priority = 999,
  config = function()
    vim.o.background = "dark"
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_better_performance = 1

    vim.cmd("colorscheme gruvbox-material")
  end
}
