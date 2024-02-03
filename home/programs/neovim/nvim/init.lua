vim.g.mapleader = ","
vim.g.maplocalleader = " "

require("user.globals")
require("user.options")
require("user.mappings")
require("user.autocommands")
require("user.cmp")
require("user.colorscheme")
require("user.copilot")
require("user.diffview")
require("user.formatters")
require("user.lspconfig")
require("user.mini")
require("user.neotree")
require("user.telescope")
require("user.treesitter")
require("user.trouble")

-- return {
--   "f3fora/cmp-spell",
--   "godlygeek/tabular",
--   "j-hui/fidget.nvim",
--   "mhinz/vim-startify",
--   "nvim-lua/lsp-status.nvim",
--   "nvim-lualine/lualine.nvim",
--   "onsails/lspkind-nvim",
--   "rcarriga/nvim-dap-ui",
--   "tpope/vim-fugitive",
--   "tpope/vim-repeat",
--   "tpope/vim-surround",
--   "unblevable/quick-scope",
-- }
