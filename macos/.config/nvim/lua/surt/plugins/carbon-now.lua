-- Share code via carbon.now.sh (opens the selection in the browser, for styled or shareable images).
--   <leader>cn  in visual mode
-- For offline screenshots straight to the clipboard or a file, use codesnap (<leader>cc / <leader>cs).
return {
	"ellisonleao/carbon-now.nvim",
	cmd = "CarbonNow",
	keys = {
		{ "<leader>cn", ":CarbonNow<CR>", mode = "x", silent = true, desc = "Open selection in carbon.now.sh" },
	},
	opts = {
		options = {
			theme = "night-owl",
			font_family = "JetBrains Mono",
			window_theme = "none",
			line_numbers = true,
			drop_shadow = true,
			padding_horizontal = "32px",
			padding_vertical = "32px",
		},
	},
}
