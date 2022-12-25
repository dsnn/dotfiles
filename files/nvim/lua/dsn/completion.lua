local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require "lspkind"

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/dsn/snippets" })

lspkind.init()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    -- ['<C-n>'] = cmp.mapping(function()
    --   if luasnip.choice_active() then
    --     luasnip.change_choice(1)
    --   end
    -- end),
    -- ['<C-p>'] = cmp.mapping(function()
    --   if luasnip.choice_active() then
    --     luasnip.change_choice(-1)
    --   end
    -- end),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.confirm { select = true },
    ['<TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-TAB>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = "buffer", keyword_length = 3 },
    { name = "nvim_lua" },
    { name = "path" },
    { name = 'npm', keyword_length = 4 },
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
        buffer   = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path     = "[path]",
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
