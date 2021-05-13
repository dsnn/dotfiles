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
  context_commentstring = {
    enable = true,
    config = {
      typescriptreact = {
        __default = '// %s',
        tsx_element = '{/* %s */}',
        tsx_fragment = '{/* %s */}',
        tsx_attribute = '// %s',
        comment = '// %s'
      }
    }
  },
}
