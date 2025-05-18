local ts_languages = {
	"bash",
	"css",
	"csv",
	"dart",
	"dockerfile",
	"gitignore",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
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
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = ts_languages,
		})
	end,
}
