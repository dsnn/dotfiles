require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
  },
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
