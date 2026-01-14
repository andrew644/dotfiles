-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	use "wbthomason/packer.nvim" -- Have packer manage itself
	--use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim

	-- Autopairs
	--use "windwp/nvim-autopairs"

	-- Treesitter
	--use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '*',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	-- Colorschemes
	--use "NLKNguyen/papercolor-theme" -- Papercolor theme
	--use "rebelot/kanagawa.nvim" -- kanagawa theme
	use "folke/tokyonight.nvim" -- tokyonight theme

	-- LSP
	use "neovim/nvim-lspconfig"
	-- Autocomplete
	--use "hrsh7th/nvim-cmp"
	--use "hrsh7th/cmp-nvim-lsp"
	--use "hrsh7th/cmp-buffer"
	--use "hrsh7th/cmp-path"
	--use "hrsh7th/cmp-cmdline"

	-- Debug
	--use {
	--	'mfussenegger/nvim-dap',
	--	requires = {
	--		{ 'rcarriga/nvim-dap-ui' },
	--		{ 'nvim-neotest/nvim-nio' },
	--		{ 'ldelossa/nvim-dap-projects' },
	--	}
	--}

	-- Comment out lines with gcc and gbc
	--use {
	--	'numToStr/Comment.nvim',
	--	config = function()
	--		require('Comment').setup()
	--	end
	--}

	-- Tree view
	--use {
	--	"nvim-tree/nvim-tree.lua",
	--	requires = { { "nvim-tree/nvim-web-devicons" } }
	--}

	-- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- Terminal
	--use { "akinsho/toggleterm.nvim", tag = '*' }

	-- Which key
	use "folke/which-key.nvim"

	-- Greeter on start
	--use {
	--	'goolord/alpha-nvim',
	--	requires = { { 'echasnovski/mini.icons' } },
	--}

	-- latex
	--use "lervag/vimtex"

	-- Color code highlighter
	--use "norcalli/nvim-colorizer.lua"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
