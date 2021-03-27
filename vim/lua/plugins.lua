local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.api.nvim_command('packadd packer.nvim')
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'
    use 'TimUntersberger/neogit'
    use 'airblade/vim-rooter'
    use 'andymass/vim-matchup'
    -- use 'bfredl/nvim-miniyank'
    -- use 'christianchiarulli/emmet-vim'
    use 'christianchiarulli/nvcode-color-schemes.vim' 
    use 'dsznajder/vscode-es7-javascript-react-snippets'
    -- use 'gennaro-tedesco/nvim-peekup'
    use 'glepnir/galaxyline.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'junegunn/goyo.vim'
    use 'kevinhwang91/nvim-bqf'
    use 'kevinhwang91/rnvimr'
    use 'kosayoda/nvim-lightbulb'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'liuchengxu/vim-which-key'
    use 'liuchengxu/vista.vim'
    use 'mhinz/vim-startify'
    use 'moll/vim-bbye'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'norcalli/nvim-colorizer.lua'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'onsails/lspkind-nvim'
    use 'romgrk/barbar.nvim'
    use 'ryanoasis/vim-devicons'
    use 'sainnhe/sonokai'
    use 'sheerun/vim-polyglot'	
    use 'terrortylor/nvim-comment'
    use 'tjdevries/colorbuddy.vim'
    use 'tpope/vim-fugitive'
    use 'unblevable/quick-scope'
    use 'voldikss/vim-floaterm'
    use 'windwp/nvim-autopairs'
    use 'xabikos/vscode-javascript'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
end)
