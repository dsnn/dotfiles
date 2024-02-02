local treesitter = require("nvim-treesitter.configs")

vim.g.skip_ts_context_comment_string_module = true

treesitter.setup({
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
        enable = true,
	lookahead = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
        },
    },
    swap = {
        enable = true,
        swap_next = {
            ["psn"] = "@parameter.inner",
        },
        swap_previous = {
            ["psp"] = "@parameter.inner",
        },
    },
  },
})


--- local M = {
---   "nvim-treesitter/nvim-treesitter",
---   event = { "BufReadPost", "BufNewFile" },
---   build = ":TSUpdate",
--- }
--- 
--- function M.config()
---   require("nvim-treesitter.configs").setup {
---     ensure_installed = {
---       "bash",
---       "css",
---       "graphql",
---       "html",
---       "javascript",
---       "json",
---       "lua",
---       "tsx",
---       "typescript",
---       "vim",
---       "yaml",
---     },
---     highlight = { enable = true },
---     indent = { enable = true },
---     textobjects = {
---       select = {
---           enable = true,
---           keymaps = {
---               ["af"] = "@function.outer",
---               ["if"] = "@function.inner",
---               ["ac"] = "@class.outer",
---               ["ic"] = "@class.inner",
---               ["ab"] = "@block.outer",
---               ["ib"] = "@block.inner",
---               ["aa"] = "@parameter.outer",
---               ["ia"] = "@parameter.inner",
---           },
---       },
---       swap = {
---           enable = true,
---           swap_next = {
---               ["psn"] = "@parameter.inner",
---           },
---           swap_previous = {
---               ["psp"] = "@parameter.inner",
---           },
---       },
---     },
---   }
--- end
--- 
--- return M
