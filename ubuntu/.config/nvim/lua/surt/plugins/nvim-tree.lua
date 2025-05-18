return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
				relativenumber = true,
			},
			sort = {
				sorter = "case_sensitive",
			},
			renderer = {
				group_empty = true,
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
		})

		local kmp = vim.keymap
		kmp.set("n", "<leader>ntt", "<cmd>NvimTreeToggle<CR>", { desc = "[N]vim[T]ree [T]oggle" })
		kmp.set("n", "<leader>ntf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "[N]vim[T]ree [F]ile toggle" })
		kmp.set("n", "<leader>ntc", "<cmd>NvimTreeCollapse<CR>", { desc = "[N]vim[T]ree [C]ollapse" })
		kmp.set("n", "<leader>ntr", "<cmd>NvimTreeRefresh<CR>", { desc = "[N]vim[T]ree [R]efresh" })
	end,
}
