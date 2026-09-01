-- Colorscheme: Catppuccin with transparent background
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          cmp = true,
          neotree = true,
          treesitter = true,
          which_key = true,
          lualine = true,
          trouble = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
