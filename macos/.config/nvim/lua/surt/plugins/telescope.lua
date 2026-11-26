return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	cmd = "Telescope",
	init = function()
		-- Load telescope (and its ui-select picker) the first time anything asks for vim.ui.select,
		-- e.g. code actions, so pickers keep the telescope look without loading it at startup
		---@diagnostic disable-next-line: duplicate-set-field
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "telescope.nvim" } })
			return vim.ui.select(...)
		end
	end,
	keys = {
		{ "<leader>fs", desc = "Fuzzy find files in cwd" },
		{ "<leader>fr", desc = "Fuzzy find recent files" },
		{ "<leader>fg", desc = "Find string in cwd" },
		{ "<leader>fc", desc = "Find string under cursor in cwd" },
		{ "<leader>ft", desc = "Find todos" },
		{ "<leader>fb", desc = "Git branches" },
		{ "<leader>fh", desc = "Git commits for current file" },
		{ "<leader><leader>", desc = "Find open buffers" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		-- set keymaps
		local keymap = vim.keymap
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>fs", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fb", builtin.git_branches, { desc = "Git branches" })
		keymap.set("n", "<leader>fh", builtin.git_bcommits, { desc = "Git commits for current file" })
		keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find open buffers" })
	end,
}
