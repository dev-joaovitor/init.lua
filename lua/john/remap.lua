vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- line move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- navigating through
-- search matches
-- but the cursor
-- stays on the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

