-- see descriptions with :help options
local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 0,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	timeout = true,
	timeoutlen = 300,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = false,
	shiftwidth = 4,
	tabstop = 4,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = true,
	scrolloff = 8,
	sidescrolloff = 8,
	termguicolors = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append "c"

vim.opt.listchars = {
	tab = '▸-',         -- Character for tab
	eol = '↲',          -- Character for end of line
	trail = '•',        -- Character for trailing spaces
	extends = '»',      -- Character for lines that extend beyond the window
	precedes = '«',     -- Character for lines that precede the window
	nbsp = '¬'          -- Character for non-breaking spaces
}
