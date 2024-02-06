-- https://github.com/folke/neodev.nvim
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/hrsh7th/nvim-cmp

require("neodev").setup({})
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "<space>.", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<space>fo", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  keymap(bufnr, "n", "<space>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap(bufnr, "n", "<space>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap(bufnr, "n", "<space>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
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
  local vim_capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = cmp_nvim_lsp.default_capabilities(vim_capabilities)

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
  bashls = {},
  cssls = {},
  diagnosticls = {},
  dockerls = {},
  docker_compose_language_service = {},
  graphql = {},
  html = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = { checkThirdParty = false },
        telemetry = { enabled = false },
      },
    },
  },
  nil_ls = {},
  tsserver = {
    settings = {
      experimental = {
        enableProjectDiagnostics = true,
      },
    },
    handlers = {
      ["textDocument/definition"] = function(err, result, method, ...)
        if vim.tbl_islist(result) and #result > 1 then
          local filtered_result = filter(result, filterReactDTS)
          return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
        end

        vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
      end,
    },
  },
  vimls = {},
  yamlls = {},
}

vim.diagnostic.config({
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
})

for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

local default_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}
require("lspconfig.ui.windows").default_options.border = "rounded"

for name, config in pairs(servers) do
  lspconfig[name].setup({
    capabilities = common_capabilities(),
    fileTypes = config.fileTypes,
    handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
    on_attach = on_attach,
    settings = config.settings,
  })
end
