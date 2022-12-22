local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.api.nvim_command('packadd packer.nvim')
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- general
  use 'junegunn/goyo.vim'
  use 'mhinz/vim-startify'
  use 'tpope/vim-surround'
  use 'godlygeek/tabular'

  -- neovim
  use {
    "tpope/vim-scriptease",
    cmd = {
      "Messages", -- view messages in quickfix list
      "Verbose", -- view verbose output in preview window.
      "Time", -- measure how long it takes to run some stuff.
    },
  }

  -- buffer, register, tabs & statusline
  use 'moll/vim-bbye' -- del buffers without closing windows
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons' } -- improved tabline
  use 'nvim-lualine/lualine.nvim' -- statusline

  -- navigation
  use 'andymass/vim-matchup' -- extend vims matching (%)
  use 'kyazdani42/nvim-tree.lua'
  use 'unblevable/quick-scope' -- f-helper: hi unique line chars
  use 'folke/lsp-trouble.nvim'

  -- lsp & code
  use 'williamboman/nvim-lsp-installer'
  use 'kevinhwang91/nvim-bqf' -- better quick fix window
  use { 'prettier/vim-prettier', run = 'npm install', branch = 'master' }
  use 'nvim-lua/lsp-status.nvim' -- lsp info in statusline
  use 'mhartington/formatter.nvim'
  use 'alvan/vim-closetag'
  use { 'numToStr/Comment.nvim' }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- handle multiple comment-styles in one file
  use {
    'David-Kunz/cmp-npm',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'f3fora/cmp-spell'
  use 'LnL7/vim-nix'
  use 'ThePrimeagen/harpoon'
  use 'tpope/vim-repeat'
  use 'hashivim/vim-terraform'

  -- git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-hop.nvim' -- easier telescope result navigation
  use "nvim-telescope/telescope-cheat.nvim"
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'stevearc/dressing.nvim'
  use 'tami5/sqlite.lua'
  use 'nvim-lua/popup.nvim'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }


  -- autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua'
    },
  }

  -- icons, colors & themes
  use 'kyazdani42/nvim-web-devicons'
  use 'norcalli/nvim-colorizer.lua'
  use 'ryanoasis/vim-devicons'
  use 'tjdevries/colorbuddy.vim'
  use 'morhetz/gruvbox'
  use 'joshdick/onedark.vim'
  use "onsails/lspkind-nvim"

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
