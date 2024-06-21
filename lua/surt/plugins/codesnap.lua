return {
	"mistricky/codesnap.nvim",
	build = "make",
	cmd = "CodeSnapPreviewOn",
	keys = {
		{ "<leader>csh", ":'<,'>CodeSnapSaveHighlight<CR>", mode = "x", desc = "Save selected code as image" },
	},
	config = function()
		require("codesnap").setup({
			mac_window_bar = false,
			save_path = "~/Documents/code_screenshots",
			bg_theme = "grape",
			watermark = "",
		})
	end,
}
