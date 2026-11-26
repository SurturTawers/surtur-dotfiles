vim.cmd("set softtabstop=2")

local options = vim.opt
local global = vim.g

-- nvim tree config
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

options.number = true
options.showmode = false

options.tabstop = 2
options.shiftwidth = 2
options.expandtab = true
options.breakindent = true
options.autoindent = true

options.ignorecase = true --ignore case on search
options.smartcase = true -- if mixed case, assumes you want case sensitive search

options.splitright = true
options.splitbelow = true

options.mouse = "a"
options.cursorline = true
options.hlsearch = true
options.inccommand = "split"
options.undofile = true

options.background = "dark" --for colorschemes
options.signcolumn = "yes"

-- optionally enable 24-bit colour
options.termguicolors = true

vim.o.autoread = true

-- Diffs (diffview, gitsigns :diffthis, nvim -d): histogram aligns moved/edited code better,
-- linematch pairs up changed lines inside a hunk, inline:char highlights the changed characters
options.diffopt = "internal,filler,closeoff,indent-heuristic,algorithm:histogram,linematch:60,inline:char"
options.fillchars:append({ diff = "╱" })
