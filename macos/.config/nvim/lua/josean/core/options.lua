vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true 
opt.autoindent = true --copy idnent from current line and start new one

opt.wrap = false

opt.ignorecase = true --ignore case on search
opt.smartcase = true -- if mixed case, assumes you want case sensitive search

opt.cursorline = true --highlights the whole line that the cursor is in

opt.termguicolors = true --so colors show properly
opt.background = "dark" --for colorschemes
opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true
