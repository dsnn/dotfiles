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
    use 'terrortylor/nvim-comment'

    -- buffer, register, tabs & statusline
    use 'moll/vim-bbye' 					                          -- del buffers without closing windows
    use 'romgrk/barbar.nvim' 					                      -- improved tabline
    use 'tjdevries/express_line.nvim' 				              -- statusline

    -- navigation
    use 'airblade/vim-rooter'  					                    -- cwd to root on open
    use 'andymass/vim-matchup' 					                    -- extend vims matching (%)
    use 'kevinhwang91/rnvimr'
    use 'kyazdani42/nvim-tree.lua'
    use 'unblevable/quick-scope' 				                    -- f-helper: hi unique line chars

    -- lsp & code
    use 'glepnir/lspsaga.nvim' 					                    -- lsp cmds
    use 'kabouzeid/nvim-lspinstall'
    use 'kevinhwang91/nvim-bqf' 				                    -- better quick fix window
    use 'liuchengxu/vista.vim'  				                    -- lsp symbols & tags
    use 'neovim/nvim-lspconfig'
    use 'sheerun/vim-polyglot'					                    -- language pack
    use { 'prettier/vim-prettier', run = 'npm install' }

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- autocomplete
    use 'hrsh7th/nvim-compe' 					                      -- autocomplete
    -- use 'hrsh7th/vim-vsnip' 					                    -- snippets
    use 'windwp/nvim-autopairs' 			                      -- TODO. minimal autopars impl.

    -- icons, colors & themes
    use 'ayu-theme/ayu-vim'
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'kyazdani42/nvim-web-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'ryanoasis/vim-devicons'
    use 'sainnhe/sonokai'
    use 'tjdevries/colorbuddy.vim'
end)
