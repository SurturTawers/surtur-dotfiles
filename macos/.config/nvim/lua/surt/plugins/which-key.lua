return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function()
		require("which-key").add({
			{ "<leader>q", desc = "[Q]uit to explorer" },

			{ "<leader>f", group = "[F]ile" },
			{ "<leader>fs", desc = "[F]ile [S]earch" },
			{ "<leader>fg", desc = "[F]ile [G]rep" },
			{ "<leader><leader>", desc = "Find open buffers" },

			{ "<leader>a", group = "[A]erial" },
			{ "<leader>at", desc = "[A]erial [T]oggle" },
			{ "<leader>{", desc = "[A]erial Previous" },
			{ "<leader>}", desc = "[A]erial Next" },

			{ "<leader>nt", group = "[N]vim[T]ree" },
			{ "<leader>ntt", desc = "[N]vim[T]ree [T]oggle" },
			{ "<leader>ntr", desc = "[N]vim[T]ree [R]efresh" },

			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>ws", desc = "[W]orkspace [S]ave" },
			{ "<leader>wr", desc = "[W]orkspace [R]estore" },

			{ "<leader>cs", group = "[C]ode[S]nap" },
			{ "<leader>csh", desc = "[C]ode[S]nap save [H]ighlight" },

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

			{ "<leader>s", group = "[S]plit" },
			{ "<leader>sv", desc = "[S]plit [V]ertically" },
			{ "<leader>sh", desc = "[S]plit [H]orizontally" },
			{ "<leader>se", desc = "[S]plit [E]qual" },
			{ "<leader>sq", desc = "[S]plit [Q]uit" },

			{ "<leader>t", group = "[T]ab" },
			{ "<leader>to", desc = "[T]ab [O]pen" },
			{ "<leader>tq", desc = "[T]ab [Q]uit" },
			{ "<leader>tn", desc = "[T]ab [N]ext" },
			{ "<leader>tp", desc = "[T]ab [P]revious" },
			{ "<leader>tb", desc = "[T]ab [B]uffer" },

			{ "<leader>mp", desc = "Format file or range" },

			{ "<leader>lg", desc = "[L]azy [G]it" },

			{ "<leader>lf", desc = "[L]int [F]ile" },

			{ "<leader>gf", desc = "Format file" },

			{ "<leader>[t", desc = "Previous todo comment" },
			{ "<leader>]t", desc = "Next todo comment" },

			{ "gR", desc = "References" },
			{ "gD", desc = "Declaration" },
			{ "gd", desc = "LSD definition" },
			{ "gi", desc = "Implementation" },
			{ "gt", desc = "Type definition" },

			{ "<leader>ca", desc = "[C]ode [A]ctions" },
			{ "<leader>D", desc = "Buffer [D]iagnostics" },
			{ "<leader>rn", desc = "[R]e[N]ame" },

			{ "<leader>[d", desc = "Previous diagnostic" },
			{ "<leader>]d", desc = "Next diagnostic" },

			{ "K", desc = "Documentation under cursor" },
			{ "<leader>rs", desc = "[R]e[S]tart LSP" },
		})
	end,
}
