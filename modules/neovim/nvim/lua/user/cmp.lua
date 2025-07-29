-- https://github.com/hrsh7th/nvim-cmp

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local copilot_cmp = require("copilot_cmp")

require("cmp_nvim_lsp")
require("cmp_luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

copilot_cmp.setup({
  suggestions = {
    enabled = true,
    auto_trigger = true,
    debounce = 100,
  },
})

lspkind.init()

vim.keymap.set(
  "n",
  "<Leader>s",
  '<cmd>:lua require("luasnip.loaders").edit_snippet_files()<CR>',
  { noremap = true, silent = true }
)

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "copilot" },
    { name = "nvim_lua" },
    { name = "path" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      menu = {
        buffer = "[buf]",
        copilot = "[copilot]",
        luasnip = "[snippet]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
      },
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-space>"] = cmp.mapping.complete({}),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
