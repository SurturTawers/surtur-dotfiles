local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "surt.plugins" },
	{ import = "surt.plugins.lsp" },
}, {
	-- lazy applies this timeout to build steps too; avante's `make` now compiles
	-- a large Rust workspace from source and needs well over the default 120s
	git = { timeout = 900 },
})
