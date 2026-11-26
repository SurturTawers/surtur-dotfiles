-- Catppuccin Mocha, matching Ghostty, tmux and oh-my-posh (see README > THEME)
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.15,
			},
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
			},
			integrations = {
				aerial = true,
				alpha = true,
				cmp = true,
				dap = true,
				dap_ui = true,
				diffview = true,
				gitsigns = true,
				indent_blankline = { enabled = true },
				lsp_trouble = false,
				mason = true,
				native_lsp = { enabled = true },
				nvimtree = true,
				telescope = { enabled = true },
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
