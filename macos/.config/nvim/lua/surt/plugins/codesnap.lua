-- Code screenshots (codesnap.nvim v2). Select code in visual mode, then:
--   <leader>cc  copy screenshot to clipboard
--   <leader>cs  save screenshot to ~/Documents/code_screenshots/<file>-<time>.png
--   <leader>ch  copy with the selected lines highlighted (prompts for the lines)
-- v2 needs the save path on each :CodeSnapSave call; the old `save_path` option is gone.

local save_dir = vim.fn.expand("~/Documents/code_screenshots")

local function save_snapshot()
	vim.fn.mkdir(save_dir, "p")
	local name = vim.fn.expand("%:t:r")
	if name == "" then
		name = "snippet"
	end
	local path = string.format("%s/%s-%s.png", save_dir, name, os.date("%Y%m%d-%H%M%S"))
	vim.cmd("'<,'>CodeSnapSave " .. vim.fn.fnameescape(path))
end

local font = "JetBrainsMono Nerd Font Mono"

return {
	"mistricky/codesnap.nvim",
	build = "make",
	version = "*",
	cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
	keys = {
		-- ":" (not <cmd>) so the '< '> marks of the selection are set before the command runs
		{ "<leader>cc", ":CodeSnap<CR>", mode = "x", silent = true, desc = "Code screenshot to clipboard" },
		{
			"<leader>cs",
			function()
				vim.cmd("normal! \27") -- leave visual mode so '< '> are set
				save_snapshot()
			end,
			mode = "x",
			desc = "Save code screenshot",
		},
		{ "<leader>ch", ":CodeSnapHighlight<CR>", mode = "x", silent = true, desc = "Code screenshot with highlights" },
	},
	opts = {
		show_line_number = true,
		show_workspace = true,
		snapshot_config = {
			theme = "candy",
			window = {
				mac_window_bar = true,
				title_config = { color = "#cdd6f4", font_family = font },
			},
			code_config = {
				font_family = font,
				breadcrumbs = { enable = true, separator = "/", color = "#9399b2", font_family = font },
			},
			watermark = { content = "", font_family = font, color = "#ffffff" },
			-- Catppuccin Mocha gradient (mauve -> blue)
			background = {
				start = { x = 0, y = 0 },
				["end"] = { x = "max", y = "max" },
				stops = {
					{ position = 0, color = "#cba6f7" },
					{ position = 1, color = "#89b4fa" },
				},
			},
		},
	},
}
