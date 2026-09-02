-- Syntax highlighting and text objects with Treesitter
local parsers = {
  "bash",
  "c",
  "c_sharp",
  "css",
  "ecma",
  "html",
  "html_tags",
  "javascript",
  "json",
  "jsx",
  "lua",
  "markdown",
  "markdown_inline",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local filetypes = {
  "cs",
  "css",
  "help",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "lua",
  "markdown",
  "sh",
  "typescript",
  "typescriptreact",
  "vim",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      local installed = {}

      for _, parser in ipairs(treesitter.get_installed()) do
        installed[parser] = true
      end

      local missing = vim.tbl_filter(function(parser)
        return not installed[parser]
      end, parsers)

      if #missing > 0 then
        treesitter.install(missing)
      end

      local group = vim.api.nvim_create_augroup("TreesitterFeatures", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = filetypes,
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end

          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          require("config.incremental_selection").attach(args.buf)
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
      })

      local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
      local function select(capture)
        return function()
          select_textobject(capture, "textobjects")
        end
      end

      vim.keymap.set({ "x", "o" }, "af", select("@function.outer"), { desc = "Outer function" })
      vim.keymap.set({ "x", "o" }, "if", select("@function.inner"), { desc = "Inner function" })
      vim.keymap.set({ "x", "o" }, "ac", select("@class.outer"), { desc = "Outer class" })
      vim.keymap.set({ "x", "o" }, "ic", select("@class.inner"), { desc = "Inner class" })
      vim.keymap.set({ "x", "o" }, "ab", select("@block.outer"), { desc = "Outer block" })
      vim.keymap.set({ "x", "o" }, "ib", select("@block.inner"), { desc = "Inner block" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {
      max_lines = 4,
      min_window_height = 40,
    },
  },

  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },
}
