local saga = require('lspsaga')
local telescope = require ("dsn.telescope")

vim.fn.sign_define("LspDiagnosticsSignError", {
  texthl = "LspDiagnosticsSignError",
  text = "",
  numhl = "LspDiagnosticsSignError"
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
  texthl = "LspDiagnosticsSignWarning",
  text = "",
  numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
  texthl = "LspDiagnosticsSignHint",
  text = "",
  numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
  texthl = "LspDiagnosticsSignInformation",
  text = "",
  numhl = "LspDiagnosticsSignInformation"
})


local noremap = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>',                                 noremap)
vim.api.nvim_set_keymap('n', 'gT',       '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            noremap)
vim.api.nvim_set_keymap('n', 'gD',       '<cmd>lua vim.lsp.buf.declaration()<CR>',                                noremap)
vim.api.nvim_set_keymap('n', 'gr',       '<cmd>lua vim.lsp.buf.references()<CR>',                                 noremap)
vim.api.nvim_set_keymap('n', 'gh',       "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",              noremap)
vim.api.nvim_set_keymap('i', '<space>s', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>",        noremap)
vim.api.nvim_set_keymap('n', '<space>r', "<cmd>lua require('lspsaga.rename').rename()<CR>",                       noremap)
vim.api.nvim_set_keymap('n', '<M-p>',    "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>", noremap)
vim.api.nvim_set_keymap('n', '<M-n>',    "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>", noremap)
vim.api.nvim_set_keymap('n', 'ca',       "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",              noremap)
vim.api.nvim_set_keymap('n', '<C-p>',    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",      noremap)
vim.api.nvim_set_keymap('n', '<C-n>',    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",     noremap)

-- telescope.map("<space>ca", "lsp_code_actions", nil, true)

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

local function tsserver_on_attach(client)
  common_on_attach(client)
  client.resolved_capabilities.document_formatting = false
end

require'lspconfig'.tsserver.setup{
  cmd = {
      vim.fn.stdpath('data') ..
      "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
    "--stdio"
  },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "typescript",
    "typescriptreact", "typescript.tsx"
  },
  on_attach = tsserver_on_attach,
  root_dir = require('lspconfig/util').root_pattern("package.json",
    "tsconfig.json", "jsconfig.json", ".git"),
  settings = {documentFormatting = false},
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local luafmt = function()
  return {
    exe = "lua-format",
    args = {"-i", "--config", "~/.config/nvim/.luafmt"},
    stdin = true
  }
end


require'formatter'.setup{
  logging = false,
  filetype = {
    lua = {luafmt},
  }
}
