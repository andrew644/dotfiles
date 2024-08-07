local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- See mappings with :map
-- Also
-- :nmap
-- :vmap
-- :imap
-- :help map for more

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- move up and down through word wrapped lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Keep cursor in place when using J
keymap("n", "J", "mzJ`z", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- Don't overwrite buffer when put is called
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Disable Q
keymap("n", "Q", "<nop>", opts)

-- Replace current word
keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Toggle show spell check
keymap("n", "<F1>", ":set spell!<CR>", opts)

-- Toggle show whitespace
keymap("n", "<F2>", ":set list!<CR>", opts)

-- Toggle light/dark mode
keymap("n", "<F3>", ":let &background = ( &background == 'dark' ? 'light' : 'dark' )<CR>", opts)
