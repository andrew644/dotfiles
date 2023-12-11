local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<leader>z]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local Terminal  = require('toggleterm.terminal').Terminal
local zigrun = Terminal:new({ cmd = "zig build run", hidden = true, close_on_exit = false })

function _Zigrun_toggle()
  zigrun:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua _Zigrun_toggle()<CR>", {noremap = true, silent = true})
