local cmp_present, cmp = pcall(require, 'cmp')

if not cmp_present then
  return
end

local lspkind_present, lspkind = pcall(require, "lspkind")

if not lspkind_present then
  return
else
  lspkind.init()
end

local function replace_keys(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if vim.call('vsnip#available', 1) ~= 0 then
          vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'), '')
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if vim.call('vsnip#available', -1) ~= 0 then
          vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-prev)'), '')
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
  },

  sources = {
    { name = "vsnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    -- { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
    { name = 'npm', keyword_length = 4},
  -- cmp-spell
  -- cmp-nvim-lsp-signature-help
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      maxwidth = 50,
      menu = {
        buffer      = "[buf]",
        nvim_lsp    = "[LSP]",
        nvim_lua    = "[api]",
        path        = "[path]",
        vsnip       = "[vsnip]",
      },
    },
  },

  view = {
    entries = "native"
  },

  experimental = {
    ghost_text = true,
  }
}

cmp.setup.cmdline("/", {
  completion = {
    autocomplete = false,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
  }),
})

cmp.setup.cmdline(":", {
  completion = {
    autocomplete = false,
  },

  sources = cmp.config.sources({
    {
      name = "path",
    },
  }, {
    {
      name = "cmdline",
      max_item_count = 20,
      keyword_length = 4,
    },
  }),
})

vim.cmd([[
    let g:vsnip_snippet_dir="~/.config/nvim/snippets"
]])


