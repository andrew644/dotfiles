require "andrew.plugins"
require "andrew.lualine"
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
vim.lsp.enable({"rust_analyzer", "vtsls"})
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

--format rust on save
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
