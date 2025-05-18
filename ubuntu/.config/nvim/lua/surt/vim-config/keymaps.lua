local keymap = vim.keymap

vim.g.mapleader = " "

-- EXIT TO EXPLORER
keymap.set("n", "<leader>q", vim.cmd.Ex, { desc = "Exit to explore window" })
-- SPLITS
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "[S]plit resize [E]qual" })
--keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "Close current split"})
keymap.set("n", "<leader>sq", "<C-w>q", { desc = "[S]plit [Q]uit" })
-- TABS
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab [O]pen" })
keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "[T]ab [Q]uit" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab [P]revious" })
keymap.set("n", "<leader>tb", "<cmd>tabnew %<CR>", { desc = "[T]ab current [B]uffer" })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Exit insert mode with ESC" })

-- when searching, next/previous value is centered
keymap.set("n", "n", "nzzv", { desc = "Next search value found is centered" })
keymap.set("n", "N", "Nzzv", { desc = "Previous search value found is centered" })

--Ctrl + d and Ctrl + u are always centered
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page up is always centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page down is always centered" })
