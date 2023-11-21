return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    lspkind.init()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end),
        ['<C-p>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            luasnip.change_choice(-1)
          end
        end),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-space>'] = cmp.mapping.complete({}),
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
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = "buffer", keyword_length = 3 },
        { name = "nvim_lua" },
        { name = "path" },
        { name = 'npm', keyword_length = 4 },
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
          menu = {
            buffer   = "[buf]",
            nvim_lsp = "[LSP]",
            luasnip  = "[snippet]",
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
    })

    -- completions for / search based on current buffer
    -- cmp.setup.cmdline("/", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = "buffer" },
    --   }),
    -- })

    -- completions for command mode
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --     {
    --       name = "cmdline",
    --       option = {
    --         ignore_cmds = { 'Man', '!' }
    --       }
    --     },
    --   }),
    -- })
  end
}
