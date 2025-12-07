return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	-- Remove 'ft = "markdown"' if you want commands available immediately upon startup
	-- Or keep it, but add the 'cmd' list so the plugin loads when you type these commands:
	event = { "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md" },
	cmd = { "ObsidianNew", "ObsidianQuickSwitch", "ObsidianToday" },

	dependencies = {
		"nvim-lua/plenary.nvim", -- STRICTLY REQUIRED for obsidian.nvim to work
	},

	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Obsidian Vault/",
			},
		},
		-- Add other options here
	},

	-- This is the explicit setup call you asked for
	config = function(_, opts)
		require("obsidian").setup(opts)
	end,
}
