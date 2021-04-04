-- vim.api.nvim_set_keymap('n', 'gd',  	  "<cmd>:lua vim.lsp.buf.definition()<CR>", 	  	silent_no)
-- vim.api.nvim_set_keymap('n', 'gD',        "<cmd>:lua vim.lsp.buf.declaration()<CR>",    	silent_no)
-- vim.api.nvim_set_keymap('n', 'gr',        "<cmd>:lua vim.lsp.buf.references()<CR>", 	  	silent_no)
-- vim.api.nvim_set_keymap('n', 'gi',   	  "<cmd>:lua vim.lsp.buf.implementation()<CR>", 	silent_no)
-- vim.api.nvim_set_keymap('n', 'ca',        ":Lspsaga code_action<CR>", 				silent_no)
--vim.api.nvim_set_keymap('n', 'K',         ":Lspsaga hover_doc<CR>", 				silent_no)
-- vim.api.nvim_set_keymap('n', 'gh',        ":Lspsaga lsp_finder<CR>", 				silent_no)
-- vim.api.nvim_set_keymap('n', '<M-p>',     ":Lspsaga diagnostic_jump_prev<CR>", 			silent_no)
-- vim.api.nvim_set_keymap('n', '<M-n>',     ":Lspsaga diagnostic_jump_next<CR>", 			silent_no)
-- vim.api.nvim_set_keymap('n', '<leader>r', ":Lspsaga rename<CR>", 				silent_no)

-- -- vim.cmd('nnoremap <silent> <C-f> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
-- vim.cmd('nnoremap <silent> <C-b> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>')
-- vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')
--
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', 	   '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', 	   '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gr', 	   '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', 	   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', 	   '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>e',  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap('n', 'ca', 	   ':Lspsaga code_action<CR>', opts)
  buf_set_keymap('n', 'gh',   	   ':Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap('n', '<M-p>',     ":Lspsaga diagnostic_jump_prev<CR>", opts)
  buf_set_keymap('n', '<M-n>',     ":Lspsaga diagnostic_jump_next<CR>", opts)
  buf_set_keymap('n', '<leader>r', ":Lspsaga rename<CR>", opts)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   vim.api.nvim_exec([[
  --     hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
  --     hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
  --     hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
  --     augroup lsp_document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]], false)
  -- end
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = false,
      update_in_insert = false, }
  )

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local function setup_servers()
  require'lspinstall'.setup()

  local servers = require'lspinstall'.installed_servers()
  local to_install = {
    "bash",
    "css",
    "dockerfile",
    "graphql",
    "html",
    "json",
    "lua",
    "typescript",
    "vim",
    "yaml"
-- "latex",
-- "python"
  }

  for _, server in ipairs(to_install) do
    table.insert(servers, server)
  end

  for _, server in ipairs(servers) do
    -- print(server)
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "typescript" then
      config.filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
      };
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

