-- Colorscheme: Catppuccin with transparent background
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          cmp = true,
          dap = true,
          dap_ui = true,
          neotree = true,
          treesitter = true,
          which_key = true,
          trouble = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
