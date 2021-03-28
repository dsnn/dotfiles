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
    use 'terrortylor/nvim-comment'
    use 'voldikss/vim-floaterm'
    -- use 'bfredl/nvim-miniyank'

    -- buffer, register, tabs & statusline
    use 'moll/vim-bbye'
    use 'glepnir/galaxyline.nvim'
    use 'romgrk/barbar.nvim'
    use 'gennaro-tedesco/nvim-peekup' 				-- peek on registers

    -- navigation
    use 'airblade/vim-rooter'  					-- cwd to root on open 
    use 'kevinhwang91/rnvimr'
    use 'kyazdani42/nvim-tree.lua'
    use 'liuchengxu/vim-which-key'
    use 'unblevable/quick-scope'
    use 'andymass/vim-matchup'

    -- icons, colors & themes
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'tjdevries/colorbuddy.vim'
    use 'christianchiarulli/nvcode-color-schemes.vim' 
    use 'sainnhe/sonokai'

    -- lsp & code 
    use 'glepnir/lspsaga.nvim'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb' 
    use 'sheerun/vim-polyglot'					-- language pack
    use 'liuchengxu/vista.vim'  				-- lsp symbols & tags
    use 'kevinhwang91/nvim-bqf' 				-- better quick fix window

    -- telescope
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- autocomplete
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'dsznajder/vscode-es7-javascript-react-snippets'
    use 'xabikos/vscode-javascript'
    use 'windwp/nvim-autopairs'
    -- use 'christianchiarulli/emmet-vim'
end)
