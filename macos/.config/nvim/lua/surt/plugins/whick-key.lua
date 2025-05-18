return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function()
		require("which-key").add({
			{ "<leader>f", group = "[F]ile" },
			{ "<leader>fs", desc = "[F]ile [S]earch" },
			{ "<leader>fg", desc = "[F]ile [G]rep" },
			{ "<leader><leader>", desc = "Find open buffers" },

			{ "<leader>a", group = "[A]erial" },
			{ "<leader>at", desc = "[A]erial [T]oggle" },

			{ "<leader>nt", group = "[N]vim[T]ree" },
			{ "<leader>ntt", desc = "[N]vim[T]ree [T]oggle" },
			{ "<leader>ntr", desc = "[N]vim[T]ree [R]efresh" },

			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>ws", desc = "[W]orkspace [S]ave" },
			{ "<leader>wr", desc = "[W]orkspace [R]estore" },

			{ "<leader>cs", group = "[C]ode[S]nap" },
			{ "<leader>csh", desc = "[C]ode[S]nap [H]ighlight" },

			{ "<leader>F", group = "[F]lutter" },
			{ "<leader>FS", desc = "[F]lutter [S]erve" },
			{ "<leader>FQ", desc = "[F]lutter [Q]uit" },
			{ "<leader>FR", desc = "[F]lutter [R]estart" },
			{ "<leader>FLR", desc = "[F]lutter [L]sp [R]estart" },
			{ "<leader>FD", desc = "[F]lutter [D]evtools" },

			{ "<leader>gv", group = "[G]it Diff[V]iew" },
			{ "<leader>gvo", desc = "[G]it Diff[V]iew [O]pen" },
			{ "<leader>gvc", desc = "[G]it Diff[V]iew [C]lose" },
			{ "<leader>gvt", desc = "[G]it Diff[V]iew [T]oggle" },
		})
	end,
	--config = function() -- This is the function that runs, AFTER loading
	--require("which-key").setup()
	-- Document existing key chains
	-- [[
	-- require("which-key").register({
	--	["<leader>s"] = { name = "[S]plit", _ = "which_key_ignore" },
	--	["<leader>f"] = { name = "[F]ile", _ = "which_key_ignore" },
	--	["<leader>g"] = { name = "[G]", _ = "which_key_ignore" },
	--	["<leader>nt"] = { name = "[N]vim[T]ree", _ = "which_key_ignore" },
	--	["<leader>t"] = { name = "[T]ab", _ = "which_key_ignore" },
	--	["<leader>b"] = { name = "Debugger [B]reakpoint", _ = "which_key_ignore" },
	--	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	--})
	--
	-- end,
	-- ]]
}
