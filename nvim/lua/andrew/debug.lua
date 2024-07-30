local dap = require("dap")
local dapui = require("dapui")
local dap_projects = require("nvim-dap-projects")

dapui.setup()

dap.adapters.lldb = {
	type = 'executable',
	command = 'lldb-dap',
	name = 'lldb'
}

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dap.configurations.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap_projects.search_project_config()

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<F5>', ":lua require'dap'.continue()<CR>", opts)
keymap('n', '<F10>', ":lua require'dap'.step_over()<CR>", opts)
keymap('n', '<F11>', ":lua require'dap'.step_into()<CR>", opts)
keymap('n', '<F9>', ":lua require'dap'.toggle_breakpoint()<CR>", opts)
