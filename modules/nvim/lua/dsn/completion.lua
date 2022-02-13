local cmp = require('cmp')
local lspkind = require "lspkind"
lspkind.init()

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
      -- require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<C-y>"] = cmp.mapping( cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }, { "i", "c" }),
      ['<C-Space>'] = cmp.mapping.confirm({ confirm = true}),
  },

  sources = {
    { name = "vsnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    -- { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
    { name = 'cmp_tabnine' },
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
      with_text = true,
      menu = {
        buffer      = "[buf]",
        nvim_lsp    = "[LSP]",
        nvim_lua    = "[api]",
        path        = "[path]",
        -- luasnip  = "[snip]",
        vsnip       = "[vsnip]",
        cmp_tabnine = "[TN]",
      },

    --     path = {kind = "  "},
    --     buffer = {kind = "  "},
    --     calc = {kind = "  "},
    --     vsnip = {kind = "  "},
    --     nvim_lsp = {kind = "  "},
    --     nvim_lua = {kind = "  "},
    --     spell = {kind = "  "},
    --     tags = false,
    --     snippets_nvim = {kind = "  "},
    --     treesitter = {kind = "  "},
    --     emoji = {kind = " ﲃ "}
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


local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
})

vim.cmd([[
    let g:vsnip_snippet_dir="~/.config/nvim/snippets"
]])


