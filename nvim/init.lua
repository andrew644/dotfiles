----------------------------------------------------------------------
--- BOOTSTRAP REGION
----------------------------------------------------------------------
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
----------------------------------------------------------------------
--- SETTINGS REGION
----------------------------------------------------------------------
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--
-- Set space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
----------------------------------------------------------------------
--- PLUGINS REGION
----------------------------------------------------------------------
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
		{ "lervag/vimtex", lazy = false, },
	},
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
----------------------------------------------------------------------
--- COLORSCHEME REGION
----------------------------------------------------------------------
local colorscheme = "tokyonight-moon"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

----------------------------------------------------------------------
--- KEYMAP REGION
----------------------------------------------------------------------
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

----------------------------------------------------------------------
--- LSP REGION
----------------------------------------------------------------------
vim.o.complete = ".,o" -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noselect" -- add 'popup' for docs (sometimes)
vim.o.autocomplete = true
vim.o.pumheight = 7

vim.lsp.enable({ "mylangservers" })

-- use <C-n> to accept / next each completion
-- <C-p> for prev
-- <C-e> for cancel
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
			convert = function(item)
				-- cap field to 30 chars
				local abbr = item.label
				abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
				abbr = abbr:match("[%w_.]+.*") or abbr
				abbr = #abbr > 30 and abbr:sub(1, 29) .. "…" or abbr

				-- Cap return value field to 15 chars
				--local menu = item.detail or ""
				--menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu
				return { abbr = abbr, menu = menu }
			end,
		})
	end,
})

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

----------------------------------------------------------------------
--- LUALINE REGION
----------------------------------------------------------------------
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
----------------------------------------------------------------------
--- LATEX REGION
----------------------------------------------------------------------
-- Use Zathura as the PDF viewer
vim.g.vimtex_view_method = 'zathura'

-- Set the LaTeX flavor to use
vim.g.vimtex_flavor = 'latex'

-- Enable continuous compilation
vim.g.vimtex_compiler_latexmk = {
	build_dir = '',
	callback = 1,
	continuous = 1,
	executable = 'latexmk',
	options = {
		'-verbose',
		'-file-line-error',
		'-synctex=1',
		'-interaction=nonstopmode',
	},
}

-- Enable reverse search from PDF to source
vim.g.vimtex_view_reverse_search_edit_cmd = 'nvr --remote-silent %f -c %l'

vim.api.nvim_set_keymap('n', '<localleader>ll', '<cmd>VimtexCompile<CR>', {noremap = true, silent = true})
