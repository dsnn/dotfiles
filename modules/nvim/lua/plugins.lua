local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.api.nvim_command('packadd packer.nvim')
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- general
    use 'junegunn/goyo.vim'
    use 'mhinz/vim-startify'
    use 'tpope/vim-surround'
    use 'godlygeek/tabular'

    -- neovim
    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages",                                         -- view messages in quickfix list
        "Verbose",                                          -- view verbose output in preview window.
        "Time",                                             -- measure how long it takes to run some stuff.
      },
    }

    -- buffer, register, tabs & statusline
    use 'moll/vim-bbye' 					                          -- del buffers without closing windows
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'} -- improved tabline
    use 'famiu/feline.nvim'                                 -- statusline

    -- navigation
    use 'andymass/vim-matchup' 					                    -- extend vims matching (%)
    use 'kyazdani42/nvim-tree.lua'
    use 'unblevable/quick-scope' 				                    -- f-helper: hi unique line chars
    use 'folke/lsp-trouble.nvim'

    -- lsp & code
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'kevinhwang91/nvim-bqf' 				                    -- better quick fix window
    use { 'prettier/vim-prettier', run = 'npm install', branch = 'master' }
    use 'nvim-lua/lsp-status.nvim'                          -- lsp info in statusline
    use 'mhartington/formatter.nvim'
    use 'alvan/vim-closetag'
    -- use { 'numToStr/Comment.nvim'}
    use 'tpope/vim-commentary'
    use 'JoosepAlviste/nvim-ts-context-commentstring'       -- handle multiple comment-styles in one file
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

    -- git
    use 'tpope/vim-fugitive'
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
    }

    -- telescope
    use 'tami5/sqlite.lua'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use { 'nvim-telescope/telescope-hop.nvim' }             -- easier telescope result navigation
    use "nvim-telescope/telescope-cheat.nvim"

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-refactor'

    -- autocomplete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/nvim-cmp'
    -- vsnip
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- icons, colors & themes
    use 'kyazdani42/nvim-web-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'ryanoasis/vim-devicons'
    use 'tjdevries/colorbuddy.vim'
    use 'sainnhe/sonokai'
    use 'ayu-theme/ayu-vim'
    use 'morhetz/gruvbox'
    use 'altercation/vim-colors-solarized'
    use 'joshdick/onedark.vim'
    use 'arcticicestudio/nord-vim'
    use "projekt0n/github-nvim-theme"
    use "onsails/lspkind-nvim"
    use "rcarriga/nvim-notify"
end)
