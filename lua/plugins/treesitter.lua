local ts_languages = {
	"bash",
	"css",
	"csv",
	"dockerfile",
	"gitignore",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"php",
	"python",
	"scss",
	"sql",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
  "xml",
	"yaml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = ts_languages,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
