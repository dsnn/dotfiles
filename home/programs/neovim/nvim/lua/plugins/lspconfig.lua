return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["nil_ls"] = {
        mason = false,
      },
    },
  },
  setup = {
    ["nil_ls"] = function(_, opts)
      require("nil_ls").setup({ server = opts })
      return true
    end,
  },
}
