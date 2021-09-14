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
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
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
    use 'glepnir/lspsaga.nvim' 					                    -- lsp cmds
    use 'kabouzeid/nvim-lspinstall'
    use 'kevinhwang91/nvim-bqf' 				                    -- better quick fix window
    use { 'prettier/vim-prettier', run = 'npm install', branch = 'master' }
    use 'nvim-lua/lsp-status.nvim'                          -- lsp info in statusline
    use 'mhartington/formatter.nvim'
    use 'alvan/vim-closetag'
    use 'tpope/vim-commentary'
    use 'JoosepAlviste/nvim-ts-context-commentstring'       -- handle multiple comment-styles in one file

    -- git
    use 'tpope/vim-fugitive'

    -- telescope
    use 'tami5/sqlite.lua'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use { 'nvim-telescope/telescope-hop.nvim' }             -- easier telescope result navigation
    use "nvim-telescope/telescope-cheat.nvim"
    -- use {
    --   "nvim-telescope/telescope-frecency.nvim",
    --   config = function()
    --     require"telescope".load_extension("frecency")
    --   end,
    --   requires = {"tami5/sqlite.lua"}
    -- }

    -- autocomplete
    use 'hrsh7th/nvim-compe' 					                      -- autocomplete
    use 'hrsh7th/vim-vsnip' 					                      -- snippets
    use 'hrsh7th/vim-vsnip-integ'

    -- icons, colors & themes
    use 'ayu-theme/ayu-vim'
    use 'kyazdani42/nvim-web-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'ryanoasis/vim-devicons'
    use 'sainnhe/sonokai'
    use 'tjdevries/colorbuddy.vim'
    use 'junegunn/limelight.vim'
end)
