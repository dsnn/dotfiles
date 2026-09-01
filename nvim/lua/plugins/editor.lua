-- Editor improvements: comment, surround, bufremove, formatting, linting
return {
  -- Mini collection: bufremove, comment, surround
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.bufremove").setup()
      require("mini.comment").setup({
        mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
          textobject = "gc",
        },
      })
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
          suffix_last = "l",
          suffix_next = "n",
        },
      })
    end,
  },

  -- Code formatting (optional, disabled by default)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    keys = {
      {
        "<space>fo",
        function()
          require("conform").format({ async = true })
        end,
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          bash = { "shfmt" },
          sh = { "shfmt" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          -- Add more as needed
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        notify_on_error = false,
      })
    end,
    enabled = false,
  },

  -- Linting (optional, disabled by default)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- javascript = { "eslint_d" },
        -- typescript = { "eslint_d" },
        -- json = { "jsonlint" },
        -- markdown = { "markdownlint" },
        -- yaml = { "yamllint" },
      }
    end,
    enabled = false,
  },
}
