local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "<space>i", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<space>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap(bufnr, "n", "<space>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format<CR>", opts)
  keymap(bufnr, "n", "<space>r", "<cmd>lua vim.lsp.buf.rename<CR>", opts)
  keymap(bufnr, "n", "ca", "<cmd>vim.lsp.buf.code_action<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>Telescope diagnostics<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
end

local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)

  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

local function common_capabilities()
  local capabilities =
    vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.targetUri, "%.d.ts") == nil
end

local servers = {
  "bashls",
  "jsonls",
  "tsserver",
  "lua_ls",
  "nil_ls",
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
  underline = false,
  severity_sort = true,
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

-- rounded borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
require("lspconfig.ui.windows").default_options.border = "rounded"

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = common_capabilities(),
  }

  if server == "lua_ls" then
    require("neodev").setup({})
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = common_capabilities(),
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end

  if server == "tsserver" then
    require("lspconfig").tsserver.setup({
      on_attach = on_attach,
      capabilities = common_capabilities(),
      handlers = {
        ["textDocument/definition"] = function(err, result, method, ...)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = filter(result, filterReactDTS)
            return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
          end

          vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
        end,
      },
    })
  end

  lspconfig[server].setup(opts)
end
