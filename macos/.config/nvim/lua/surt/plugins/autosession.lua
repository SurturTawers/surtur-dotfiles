return {
	"rmagatti/auto-session",
	-- after the UI is up, so it still auto-saves the session on exit
	event = "VeryLazy",
	cmd = { "SessionRestore", "SessionSave" },
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop" },
		})

		local kmp = vim.keymap

		kmp.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "[W]orkspace [R]estore session" })
		kmp.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "[W]orkspace [S]ave session" })
	end,
}
