-- Shows pending keybinds. Mapping descriptions come from each plugin's `desc`;
-- this file only names the groups and labels the few maps that have no desc.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{ "<leader>a", group = "Aerial (symbols)" },
			{ "<leader>c", group = "Code / screenshots", mode = { "n", "x" } },
			{ "<leader>d", group = "Debug" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>gv", group = "Diffview (review)" },
			{ "<leader>h", group = "Git hunks", mode = { "n", "v" } },
			{ "<leader>l", group = "LSP / Lint / LazyGit" },
			{ "<leader>n", group = "NvimTree" },
			{ "<leader>s", group = "Split" },
			{ "<leader>t", group = "Tab" },
			{ "<leader>u", group = "Toggle" },
			{ "<leader>w", group = "Workspace session" },

			{ "<leader>q", desc = "Exit to explorer" },
			{ "<leader>mp", desc = "Format file or range" },
			{ "]t", desc = "Next todo comment" },
			{ "[t", desc = "Previous todo comment" },
		},
	},
}
