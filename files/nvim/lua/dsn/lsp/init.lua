local util = require('lspconfig/util')

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ", "   (Method)", "   (Function)", "   (Constructor)",
  " ﴲ  (Field)", "[] (Variable)", "   (Class)", " ﰮ  (Interface)",
  "   (Module)", " 襁 (Property)", "   (Unit)", "   (Value)",
  " 練 (Enum)", "   (Keyword)", "   (Snippet)", "   (Color)",
  "   (File)", "   (Reference)", "   (Folder)", "   (EnumMember)",
  " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)", "   (Operator)",
  "   (TypeParameter)"
}

local function lspDiagnosticSymbol(name, icon)
  vim.fn.sign_define('DiagnosticSign' .. name, { text = icon, numhl = 'DiagnosticDefault' .. name })
end

lspDiagnosticSymbol("Error", "")
lspDiagnosticSymbol("Warning", "")
lspDiagnosticSymbol("Hint", "")
lspDiagnosticSymbol("Information", "")
lspDiagnosticSymbol("Info", "")

vim.diagnostic.config({
  float = {
    focusable = false,
    border = border,
    scope = "cursor",
    prefix = function(diagnostic, i, total)
      local icon, highlight
      if diagnostic.severity == 1 then
        icon = ""
        highlight = "DiagnosticError"
      elseif diagnostic.severity == 2 then
        icon = ""
        highlight = "DiagnosticWarn"
      elseif diagnostic.severity == 3 then
        icon = ""
        highlight = "DiagnosticInfo"
      elseif diagnostic.severity == 4 then
        icon = ""
        highlight = "DiagnosticHint"
      end
      return i .. "/" .. total .. " " .. icon .. "  ", highlight
    end,
  },
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
})

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gT', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gh', vim.lsp.buf.hover, '[G]oto [H]over Documentation')
  nmap('<space>s', vim.lsp.buf.signature_help, '[S]ignature Documentation')
  nmap('<space>r', vim.lsp.buf.rename, '[R]ename')
  nmap('<space>f', vim.lsp.buf.format, '[F]ormat')
  nmap('<M-n>', vim.diagnostic.goto_next, 'Goto [N]ext diagnostic')
  nmap('<M-p>', vim.diagnostic.goto_prev, 'Goto [P]revious diagnostic')
  nmap('ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<space>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  tsserver = {},
  eslint = {
    settings = {
      codeAction = {
        showDocumentation = {
          enable = false
        }
      },
      codeActionOnSave = {
        enable = false,
      },
      format = true,
      packageManager = "npm",
      quite = false,
      validate = "off",
    }
  },
  graphql = {},
  cssls = {},
  jsonls = {},
  html = {},
  dockerls = {},
  terraformls = {},
  bashls = {},
  vimls = {},

  sumneko_lua = {
    Lua = {
      telemetry = {
        enable = false
      },
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

require('neodev').setup()
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

require('fidget').setup()
