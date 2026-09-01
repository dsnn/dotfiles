-- Syntax highlighting and text objects with Treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "latex", "markdown" },
        },
        indent = {
          enable = true,
        },
        folding = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },

  -- Treesitter text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              af = "@function.outer",
              ["if"] = "@function.inner",
              ac = "@class.outer",
              ic = "@class.inner",
              ab = "@block.outer",
              ib = "@block.inner",
            },
          },
        },
      })
    end,
  },

  -- Show context of current position
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup({
        max_lines = 4,
        min_window_height = 40,
      })
    end,
  },

  -- Automatic indentation detection
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Mini AI text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
    end,
  },
}
