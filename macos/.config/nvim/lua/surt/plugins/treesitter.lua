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
        -- 1. Setup Autotag (independent from Treesitter setup)
        require('nvim-ts-autotag').setup()

        -- 2. Configure Parser Management
        -- In 1.0.0, we manage parsers via the install module
        local install = require('nvim-treesitter.install')
        install.prefer_git = false
        
        -- Trigger installation of missing parsers
        -- This replaces the old ensure_installed table in setup()
        require('nvim-treesitter').install(ts_languages)

        -- 3. Highlighting (New Pattern)
        -- Highlighting is now handled by Neovim core. 
        -- We use an autocmd to ensure it's enabled for supported filetypes.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
                if lang then
                    pcall(vim.treesitter.start)
                end
            end
        })
    end,
}
