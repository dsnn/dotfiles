local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim"
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gh",        "<cmd>lua vim.lsp.buf.hover()<CR>",                     opts)
  keymap(bufnr, "n", "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>",                opts)
  keymap(bufnr, "n", "gr",        "<cmd>require('telescope.builtin').lsp_references<CR>", opts)
  keymap(bufnr, "n", "<space>r",  "<cmd>vim.lsp.buf.rename<CR>",                          opts)
  keymap(bufnr, "n", "<space>f",  "<cmd>vim.lsp.buf.format<CR>",                          opts)
  keymap(bufnr, "n", "<M-n>",     "<cmd>vim.diagnostic.goto_next<CR>",                    opts)
  keymap(bufnr, "n", "<M-p>",     "<cmd>vim.diagnostic.goto_prev<CR>",                    opts)
  keymap(bufnr, "n", "ca",        "<cmd>vim.lsp.buf.code_action<CR>",                     opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local lspconfig = require("lspconfig")

  local servers = {
    "bashls",
    "jsonls",
    "tsserver",
  }

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    update_in_insert = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = { 
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(), 
    }

    if server == "lua_ls" then
      require("neodev").setup {}
    end

    if server == "tsserver" then
      require'lspconfig'.tsserver.setup({
        cmd = {
          "typescript-language-server",
          "--stdio",
          "--tsserver-path",
          "/nix/store/ri4pxc1r6lv3q0r07dima2zbczl1kzam-typescript-5.2.2/lib/node_modules/typescript/lib",
        }
      })
    end

    lspconfig[server].setup(opts)
  end

end

return M
