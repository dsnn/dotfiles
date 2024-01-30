vim.g.mapleader = ","
vim.g.maplocalleader = " "

require("user.globals")
require("user.options")
require("user.mappings")
require("user.autocommands")

spec("user.telescope");
spec("user.colorscheme");
spec("user.neotree");
spec("user.treesitter");
spec("user.mason");
spec("user.lspconfig");

-- return {
--   "David-Kunz/cmp-npm",
--   "JoosepAlviste/nvim-ts-context-commentstring",
--   "MunifTanjim/nui.nvim",
--   "ThePrimeagen/harpoon",
--   "f3fora/cmp-spell",
--   "folke/lsp-trouble.nvim",
--   "godlygeek/tabular",
--   "j-hui/fidget.nvim",
--   "mfussenegger/nvim-dap",
--   "mhinz/vim-startify",
--   "moll/vim-bbye",
--   "morhetz/gruvbox",
--   "nvim-lua/lsp-status.nvim",
--   "nvim-lua/plenary.nvim",
--   "nvim-lualine/lualine.nvim",
--   "nvim-tree/nvim-web-devicons",
--   "onsails/lspkind-nvim",
--   "rcarriga/nvim-dap-ui",
--   "tami5/sqlite.lua",
--   "tpope/vim-fugitive",
--   "tpope/vim-repeat",
--   "tpope/vim-surround",
--   "unblevable/quick-scope",
--   "williamboman/mason-lspconfig.nvim",
--   "williamboman/nvim-lsp-installer",
--   {
--     "nvim-telescope/telescope-file-browser.nvim",
--     version = "0.1.0"
--   },
--   "nvim-telescope/telescope-fzy-native.nvim",
--   "nvim-telescope/telescope-cheat.nvim",
-- }

require("user.lazy")
