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
    -- version = "v0.9.2", -- REMOVED: using main branch
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- 1. Manage parsers
        local ts = require("nvim-treesitter")
        -- Note: v1.0.0 handles ensure_installed differently, 
        -- often via the install module or auto-install.
        
        -- 2. Setup Autotag (now setup independently)
        require('nvim-ts-autotag').setup()

        -- 3. Highlighting is handled by Neovim core automatically 
        -- for any buffer where a parser is available.
    end,
}
