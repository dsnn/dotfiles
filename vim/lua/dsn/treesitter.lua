require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "graphql",
      "html",
      "bash",
      "python",
      "json",
      "latex",
      "lua",
      "c_sharp",
      "typescript",
      "javascript",
      "yaml",
      "comment",
      "css",
      "jsdoc",
      "regex",
      "jsonc"
  },
  highlight = { enable = true },
}
