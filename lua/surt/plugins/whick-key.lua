return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			["<leader>s"] = { name = "[S]plit", _ = "which_key_ignore" },
			["<leader>f"] = { name = "[F]ile", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]", _ = "which_key_ignore" },
			["<leader>nt"] = { name = "[N]vim[T]ree", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]ab", _ = "which_key_ignore" },
			["<leader>b"] = { name = "Debugger [B]reakpoint", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
		})
	end,
}
