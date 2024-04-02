vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.inccommand = "split"
vim.opt.hlsearch = true
vim.opt.undofile = true

vim.o.autoread = true
vim.api.nvim_create_autocmd({
  "BufEnter", "CursorHold", "CursorHoldI", "FocusGained"
},{
  command = "if mode() != 'c' | checktime | endif",
    pattern = {"*"}
  })


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.cmd.Ex, { desc = "Exit to explore window" })
--Ctrl + d and Ctrl + u are always centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- when searching, next/previous value is centered
vim.keymap.set("n", "n", "nzzv")
vim.keymap.set("n", "N", "Nzzv")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- nvim tree config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true
