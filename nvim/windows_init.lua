----------------------------
-- START OF LAZY CONFIG
----------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
		{ "folke/which-key.nvim" },
		{
			'nvim-telescope/telescope.nvim', version = '*',
			dependencies = {
				'nvim-lua/plenary.nvim',
			}
		},
		{ "neovim/nvim-lspconfig" },
		{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
----------------------------
-- START OF LUALINE CONFIG
----------------------------
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
------------------------------------------------------------------------------------------------
-- START OF CONFIG
------------------------------------------------------------------------------------------------

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Set space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Colorscheme
local colorscheme = "tokyonight-moon"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

-- Set options
local options = {
	clipboard = "unnamedplus",
	completeopt = { "menuone", "noselect", "popup" },
	fileencoding = "utf-8",
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showtabline = 0,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	timeoutlen = 300,
	undofile = true,
	writebackup = false,
	expandtab = false,
	shiftwidth = 4,
	tabstop = 4,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",
	scrolloff = 8,
	sidescrolloff = 8,
	termguicolors = true,
	winborder = "single",
}
for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Set whitespace characters that show with F2
vim.opt.listchars = {
	tab = '▸-',         -- Character for tab
	eol = '↲',          -- Character for end of line
	trail = '•',        -- Character for trailing spaces
	extends = '»',      -- Character for lines that extend beyond the window
	precedes = '«',     -- Character for lines that precede the window
	nbsp = '¬'          -- Character for non-breaking spaces
}

-- Disable Q
keymap("n", "Q", "<nop>", opts)
keymap("n", "q", "<nop>", opts)

-- move up and down through word wrapped lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Keep cursor in place when using J (join line below)
keymap("n", "J", "mzJ`z", opts)

-- Stay in indent mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Don't overwrite buffer when put is called
keymap("v", "p", '"_dP', opts)

-- Replace current word
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Toggle show spell check
keymap("n", "<F1>", ":set spell!<CR>", opts)

-- Toggle show whitespace
keymap("n", "<F2>", ":set list!<CR>", opts)

-- Toggle light/dark mode
keymap("n", "<F3>", ":let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>", opts)

-- Telescope file finder and grep
keymap("n", "<leader>p", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)

-- LSP
vim.lsp.enable({"rust_analyzer", "vtsls", "ols"})
vim.lsp.config('rust_analyzer', {
	settings = {
		['rust-analyzer'] = {
			completion = {
				callable = {
					snippets = "add_parentheses",
				},
			},
		},
	},
})
keymap("i", "<C-Space>", "<C-x><C-o>", opts) -- keymap for omni complete

-- format rust on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({
			async = false,
			filter = function(client)
				return client.name == "rust_analyzer"
			end,
		})
	end,
})

-- format odin on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.odin",
	callback = function()
		local file = vim.api.nvim_buf_get_name(0)
		vim.fn.system({ "odinfmt", "-w", file })
		vim.cmd("edit!") -- reload buffer
	end,
})
