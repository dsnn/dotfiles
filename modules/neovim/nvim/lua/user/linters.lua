-- https://github.com/mfussenegger/nvim-lint

require("lint").linters_by_ft = {
  markdown = { "markdownlint", "proselint" },
  json = { "jsonlint" },
  jsonc = { "jsonlint" },
  yaml = { "yamllint", "ansible_lint" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  sh = { "shellcheck" },
  nix = { "statix" },
  gitcommit = { "commitlint" },
  css = { "stylelint" },
}

vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
  callback = function()
    local lint_status, lint = pcall(require, "lint")
    if lint_status then
      lint.try_lint()
    end
  end,
})

-- formatters_by_ft = {
--   bash = { "shfmt" },
--   css = { { "prettierd", "prettier" } },
--   graphql = { { "prettierd", "prettier" } },
--   html = { { "prettierd", "prettier" } },
--   javascript = { { "prettierd", "prettier" } },
--   javascriptreact = { { "prettierd", "prettier" } },
--   json = { { "prettierd", "prettier" } },
--   jsonc = { { "prettierd", "prettier" } },
--   less = { { "prettierd", "prettier" } },
--   lua = { "stylua" },
--   markdown = { { "prettierd", "prettier" } },
--   nix = { "nixfmt" },
--   scss = { { "prettierd", "prettier" } },
--   sh = { "shfmt" },
--   typescript = { { "prettierd", "prettier" } },
--   typescriptreact = { { "prettierd", "prettier" } },
--   yaml = { { "prettierd", "prettier" } },
-- },

-- local null_ls = require("null-ls")
-- local code_actions = null_ls.builtins.code_actions
-- local diagnostics = null_ls.builtins.diagnostics
-- local formatting = null_ls.builtins.formatting
-- local hover = null_ls.builtins.hover
-- local completion = null_ls.builtins.completion

-- null_ls.builtins.diagnostics.eslint,
-- null_ls.builtins.diagnostics.yamllint,
-- null_ls.builtins.formatting.yamlfmt,
-- null_ls.builtins.formatting.eslint,
-- null_ls.builtins.formatting.packer,
-- null_ls.builtins.formatting.prettier,
-- null_ls.builtins.formatting.prettierd,
-- null_ls.builtins.formatting.shfmt,

-- null_ls.setup({
--   sources = {
--     code_actions.eslint_d,
--     code_actions.proselint,
--     code_actions.refactoring,
--     code_actions.shellcheck,
--     code_actions.statix,
--     code_actions.ts_node_action,
--     completion.spell,
--     diagnostics.ansiblelint,
--     diagnostics.commitlint,
--     diagnostics.eslint_d,
--     diagnostics.jsonlint,
--     diagnostics.luacheck,
--     diagnostics.markdownlint,
--     diagnostics.proselint,
--     diagnostics.shellcheck,
--     diagnostics.statix,
--     diagnostics.stylelint,
--     diagnostics.tsc,
--     diagnostics.zsh,
--     formatting.eslint_d,
--     formatting.jq,
--     formatting.markdownlint,
--     formatting.stylua,
--     formatting.sqlfmt,
--   },
-- })
