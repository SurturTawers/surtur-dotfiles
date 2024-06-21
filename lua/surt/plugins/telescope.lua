return {
	--[[
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  ]]
	--
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local kmp = vim.keymap
			kmp.set("n", "<leader>fs", builtin.find_files, { desc = "[F]ile [S]earch in parent directory" })
			kmp.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ile [G]rep in parent directory" })
			kmp.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
		end,
	},
}
