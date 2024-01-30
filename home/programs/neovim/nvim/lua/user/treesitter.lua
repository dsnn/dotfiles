local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "bash",
      "css",
      "graphql",
      "html",
      "javascript",
      "json",
      "lua",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
