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
    use 'ntpeters/vim-better-whitespace'
    use 'tpope/vim-surround'
    use 'voldikss/vim-floaterm'
    use 'bfredl/nvim-luadev'

    -- buffer, register, tabs & statusline
    use 'gennaro-tedesco/nvim-peekup' 				-- peek on registers
    use 'glepnir/galaxyline.nvim'
    use 'moll/vim-bbye'
    use 'romgrk/barbar.nvim'

    -- navigation
    use 'airblade/vim-rooter'  					-- cwd to root on open
    use 'andymass/vim-matchup'
    use 'kevinhwang91/rnvimr'
    use 'kyazdani42/nvim-tree.lua'
    use 'liuchengxu/vim-which-key'
    use 'unblevable/quick-scope'

    -- icons, colors & themes
    use 'ayu-theme/ayu-vim'
    use 'chriskempson/base16-vim'
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'kyazdani42/nvim-web-devicons'
    use 'norcalli/nvim-colorizer.lua'
    use 'ryanoasis/vim-devicons'
    use 'sainnhe/sonokai'
    use 'tjdevries/colorbuddy.vim'

    -- lsp & code
    use 'glepnir/lspsaga.nvim'
    use 'kabouzeid/nvim-lspinstall'
    use 'kevinhwang91/nvim-bqf' 				-- better quick fix window
    use 'kosayoda/nvim-lightbulb'
    use 'liuchengxu/vista.vim'  				-- lsp symbols & tags
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'sheerun/vim-polyglot'					-- language pack

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- autocomplete
    use 'dsznajder/vscode-es7-javascript-react-snippets'
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'windwp/nvim-autopairs'
    use 'xabikos/vscode-javascript'
end)
