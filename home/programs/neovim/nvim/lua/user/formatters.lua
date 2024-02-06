-- https://github.com/stevearc/conform.nvim

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    bash = { "shfmt" },
    css = { { "prettierd", "prettier" } },
    graphql = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    jsonc = { { "prettierd", "prettier" } },
    less = { { "prettierd", "prettier" } },
    lua = { "stylua" },
    markdown = { { "prettierd", "prettier" } },
    nix = { "nixfmt" },
    scss = { { "prettierd", "prettier" } },
    sh = { "shfmt" },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
  },
})
