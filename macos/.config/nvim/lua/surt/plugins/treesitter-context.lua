-- Keeps the enclosing function/class signature pinned at the top while reading long code.
--   [x  jump up to the context line     <leader>uc  toggle
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		max_lines = 3,
		multiline_threshold = 1,
		trim_scope = "outer",
		mode = "cursor",
	},
	keys = {
		{ "[x", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Jump to context" },
		{ "<leader>uc", function() require("treesitter-context").toggle() end, desc = "Toggle code context" },
	},
}
