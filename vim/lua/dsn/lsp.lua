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

-- vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
-- vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
-- vim.cmd("nnoremap <silent> K :Lspsaga hover_doc<CR>")

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
-- vim.cmd("nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>")
vim.cmd("nnoremap <silent> gf :Format<CR>")

vim.cmd("nnoremap <silent> ca :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> <leader>r :Lspsaga rename<CR>")

-- vim.cmd('nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.cmd("nnoremap <silent> <M-p> :Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> <M-n> :Lspsaga diagnostic_jump_next<CR>")

-- scroll down hover doc or scroll in definition preview
vim.cmd(
  "nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")

-- scroll up hover doc
vim.cmd(
  "nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
vim.cmd(
  'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

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

-- vim.api.nvim_exec([[
--   autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
--   autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
--   autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
-- ]])

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
    DATA_PATH ..
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
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true

      })
  }
}

-- local sumneko_root_path = DATA_PATH .. "/lspinstall/lua"
-- local sumneko_binary = sumneko_root_path .. "/bin/Linux" .. "/lua-language-server"
-- require'lspconfig'.sumneko_lua.setup {
--     cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
--     on_attach = common_on_attach,
--     settings = {
--         Lua = {
--             runtime = {
--                 version = 'LuaJIT',
--                 path = vim.split(package.path, ';')
--             },
--             diagnostics = {
--                 globals = {'vim'}
--             },
--             workspace = {
--                 library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
--                 maxPreload = 10000
--             }
--         }
--     }
-- }

-- npm i -g bash-language-server
require'lspconfig'.bashls.setup{
  cmd = {
    DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
    "start"
  },
  on_attach = common_on_attach,
  filetypes = {"sh", "zsh"}
}

-- npm install -g vscode-css-languageserver-bin
require'lspconfig'.cssls.setup{
  cmd = {
    "node", DATA_PATH ..
      "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
    "--stdio"
  },
  on_attach = common_on_attach
}

-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{
  cmd = {
    DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
    "--stdio"
  },
  on_attach = common_on_attach,
  root_dir = vim.loop.cwd
}

-- npm install -g graphql-language-service-cli
require'lspconfig'.graphql.setup{on_attach = common_on_attach}

-- npm install -g vscode-html-languageserver-bin
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup{
  cmd = {
    "node", DATA_PATH ..
      "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
    "--stdio"
  },
  on_attach = common_on_attach,
  capabilities = capabilities
}

-- npm install -g vscode-json-languageserver
require'lspconfig'.jsonls.setup{
  cmd = {
    "node", DATA_PATH ..
      "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
    "--stdio"
  },
  on_attach = common_on_attach,

  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
      end
    }
  }
}

-- npm install -g vim-language-server
require'lspconfig'.vimls.setup{
  cmd = {
    DATA_PATH .. "/lspinstall/vim/node_modules/.bin/vim-language-server",
    "--stdio"
  },
  on_attach = common_on_attach
}

-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
  cmd = {
    DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
    "--stdio"
  },
  on_attach = common_on_attach
}

is_cfg_present = function(cfg_name)
  -- this returns 1 if it's not present and 0 if it's present
  -- we need to compare it with 1 because both 0 and 1 is `true` in lua
  return vim.fn.empty(vim.fn.glob(vim.loop.cwd() .. cfg_name)) ~= 1
end

local prettier = function()
  if is_cfg_present("/prettier.config.js") then
    return {
      exe = "prettier",
      args = {
        string.format("--stdin-filepath '%s' --config '%s'",
          vim.api.nvim_buf_get_name(0),
          vim.fn.stdpath("config") .. "/prettier.config.js")
      },
      stdin = true
    }
  elseif is_cfg_present("/.prettierrc") then
    return {
      exe = "prettier",
      args = {
        string.format("--stdin-filepath '%s' --config '%s'",
          vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. "/.prettierrc")
      },
      stdin = true
    }
  else
    -- fallback to global config
    return {
      exe = "prettier",
      args = {
        string.format("--stdin-filepath '%s' --config '%s'",
          vim.api.nvim_buf_get_name(0),
          vim.fn.stdpath("config") .. "/.prettierrc")
      },
      stdin = true
    }
  end
end

local luafmt = function()
  return {
    exe = "lua-format",
    args = {"-i", "--config", "~/.config/nvim/.luafmt"},
    stdin = true
  }
end

-- vim.api.nvim_exec([[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost *.js,*.ts,*.tsx,*.lua FormatWrite
-- augroup END
-- ]], true)

require'formatter'.setup{
  logging = false,
  filetype = {
    lua = {luafmt},
    javascript = {prettier},
    typescript = {prettier},
    typescriptreact = {prettier},
    html = {prettier},
    css = {prettier},
    jsonc = {prettier},
    yaml = {prettier},
    markdown = {prettier}
  }
}
