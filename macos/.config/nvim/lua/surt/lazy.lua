local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
	-- lazy applies this timeout to build steps too (codesnap compiles Rust on `make`)
	git = { timeout = 300 },
	ui = { border = "rounded" },
	change_detection = { notify = false },
	performance = {
		rtp = {
			-- built-in runtime plugins this config never uses
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin", "netrwPlugin" },
		},
	},
})
