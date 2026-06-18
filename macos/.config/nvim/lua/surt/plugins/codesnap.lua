return {
	"mistricky/codesnap.nvim",
	build = "make",
	version = "*",
	cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
	keys = {
		{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Copy code snapshot to clipboard" },
		{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save code snapshot to file" },
	},
	opts = {
		mac_window_bar = true,
		title = "CodeSnap.nvim",
		watermark = "",
		bg_theme = "grape",
		save_path = "/Users/david/Documents/code_screenshots",
		has_line_number = true,
		has_border = true,
	},
}
