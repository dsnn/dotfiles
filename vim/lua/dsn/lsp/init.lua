local root_pattern = require('lspconfig/util').root_pattern

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>',       opts)
vim.api.nvim_set_keymap('n', 'gI',       '<cmd>lua vim.lsp.buf.implementation()<CR>',   opts)
vim.api.nvim_set_keymap('n', 'gT',       '<cmd>lua vim.lsp.buf.type_definition()<CR>',  opts)
vim.api.nvim_set_keymap('n', 'gD',       '<cmd>lua vim.lsp.buf.declaration()<CR>',      opts)
vim.api.nvim_set_keymap('n', 'gr',       '<cmd>lua vim.lsp.buf.references()<CR>',       opts)
vim.api.nvim_set_keymap('n', 'gh',       "<cmd>lua vim.lsp.buf.hover()<CR>",            opts)
vim.api.nvim_set_keymap('n', '<space>s', "<cmd>lua vim.lsp.buf.signature_help()<CR>",   opts)
vim.api.nvim_set_keymap('n', '<space>r', "<cmd>lua vim.lsp.buf.rename()<CR>",           opts)
vim.api.nvim_set_keymap('n', '<M-p>',    "<cmd>lua vim.diagnostic.goto_prev()<CR>",     opts)
vim.api.nvim_set_keymap('n', '<M-n>',    "<cmd>lua vim.diagnostic.goto_next()<CR>",     opts)
vim.api.nvim_set_keymap('n', 'ca',       "<cmd>lua vim.lsp.buf.code_action()<CR>",      opts)
vim.api.nvim_set_keymap('n', '<space>p', "<cmd>lua vim.lsp.buf.formatting()<CR>",       opts)
vim.api.nvim_set_keymap('n', '<space>ds', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
-- telescope.map("<space>ca", "lsp_code_actions", nil, true)

local function common_on_attach(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

require'lspconfig'.tsserver.setup{
  cmd = {
      vim.fn.stdpath('data') ..
      "/lsp_servers/tsserver/node_modules/.bin/typescript-language-server",
    "--stdio"
  },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "typescript",
    "typescriptreact", "typescript.tsx"
  },
  on_attach = function (client)
    common_on_attach(client)
    client.resolved_capabilities.document_formatting = false
  end,
  root_dir = root_pattern("package.json",
    "tsconfig.json", "jsconfig.json", ".git"),
  settings = { documentFormatting = false },
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = true
      })
  }
}

require'lspconfig'.eslint.setup{
  on_attach = common_on_attach,
  cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/vscode-eslint/node_modules/vscode-langservers-extracted/bin/vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "typescript",
    "typescriptreact", "typescript.tsx"
  },
  settings = {
    codeAction ={
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
}

require'lspconfig'.graphql.setup{
  cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/graphql/node_modules/.bin/graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  root_dir = root_pattern('.git', '.graphqlrc*', '.graphql.config.*')
}

require'lspconfig'.bashls.setup{}

require'lspconfig'.cssls.setup{
  on_attach = common_on_attach,
  cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/cssls/node_modules/vscode-langservers-extracted/bin/vscode-css-language-server", "--stdio" },
  filetypes = {"typescriptreact", "javascriptreact" },
}

require'lspconfig'.jsonls.setup{
  on_attach = common_on_attach,
  cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/jsonls/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server", "--stdio" },
  filetypes = {"json"},
}

require'lspconfig'.html.setup{
  on_attach = common_on_attach,
  cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/html/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server", "--stdio" },
  filetypes = {"typescriptreact", "javascriptreact", "html" },
}

require'lspconfig'.dockerls.setup{
  on_attach = common_on_attach,
  cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/dockerfile/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver", "--stdio" },
}

local runtime_path = vim.split(package.path, ';')
require'lspconfig'.sumneko_lua.setup {
    on_attach = common_on_attach,
    cmd = { vim.fn.getenv 'HOME' ..  "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server", "--stdio" },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}


-- custom lsp diagnostic signs/icons

local function lspDiagnosticSymbol(name, icon)
  vim.fn.sign_define('DiagnosticSign' .. name, { text = icon, numhl = 'DiagnosticDefault' .. name})
end
lspDiagnosticSymbol("Error", "")
lspDiagnosticSymbol("Warning", "")
lspDiagnosticSymbol("Hint", "")
lspDiagnosticSymbol("Information", "")
lspDiagnosticSymbol("Info", "")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "none"
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "none"
})

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ", "   (Method)", "   (Function)", "   (Constructor)",
  " ﴲ  (Field)", "[] (Variable)", "   (Class)", " ﰮ  (Interface)",
  "   (Module)", " 襁 (Property)", "   (Unit)", "   (Value)",
  " 練 (Enum)", "   (Keyword)", " ﬌  (Snippet)", "   (Color)",
  "   (File)", "   (Reference)", "   (Folder)", "   (EnumMember)",
  " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)", "   (Operator)",
  "   (TypeParameter)"
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
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
