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
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
