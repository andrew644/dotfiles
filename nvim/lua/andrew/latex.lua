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
