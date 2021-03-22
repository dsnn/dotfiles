local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'
	-- lsp
	use 'neovim/nvim-lspconfig'
	use 'glepnir/lspsaga.nvim'
	use 'onsails/lspkind-nvim'
	use 'kosayoda/nvim-lightbulb'
	-- autocomplete
	use 'hrsh7th/nvim-compe'
	use 'christianchiarulli/emmet-vim'
	use 'hrsh7th/vim-vsnip'
	use 'xabikos/vscode-javascript'
	use 'dsznajder/vscode-es7-javascript-react-snippets'
	-- treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'nvim-treesitter/nvim-treesitter-refactor'
	-- icons
	use 'kyazdani42/nvim-web-devicons'
	use 'ryanoasis/vim-devicons'
	-- status
	use 'glepnir/galaxyline.nvim'
	use 'romgrk/barbar.nvim'
	-- telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-media-files.nvim'
	-- explorer
    use 'kyazdani42/nvim-tree.lua'
	-- color
	use 'norcalli/nvim-colorizer.lua'
   	use 'christianchiarulli/nvcode-color-schemes.vim' 
	-- use 'tjdevries/colorbuddy.vim'
	-- use 'sainnhe/sonokai'
	-- git
	use 'tpope/vim-fugitive'
	use 'TimUntersberger/neogit'
    -- registers
    use 'gennaro-tedesco/nvim-peekup'
	-- autopairs
	use 'windwp/nvim-autopairs'
	-- better quickfix window
	use 'kevinhwang91/nvim-bqf'
	-- easier line navigation
	use 'unblevable/quick-scope'
	-- change root to current 
    use 'airblade/vim-rooter'
	-- ranger
    use 'kevinhwang91/rnvimr'
	-- start page
    use 'mhinz/vim-startify'
	-- smooth scrolling
	use 'psliwka/vim-smoothie'
	-- fix bd  
	use 'moll/vim-bbye'
	-- shortcuts 
	use 'liuchengxu/vim-which-key'
	-- floating terminal window
    use 'voldikss/vim-floaterm'
	-- symbol view
	use 'liuchengxu/vista.vim'
	-- comments
    use 'terrortylor/nvim-comment'
	-- yank viewer
    use 'bfredl/nvim-miniyank'
	-- focus
    use 'junegunn/goyo.vim'
	-- improve matching 
    use 'andymass/vim-matchup'
	-- lang pack
	use 'sheerun/vim-polyglot'	
end)
