return {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("diffview").setup({})
		vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "[G]it[D]iff [O]pen" })
		vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "[G]it[D]iff [C]lose" })
		vim.keymap.set("n", "<leader>gdt", "<cmd>DiffviewToggleFiles<CR>", { desc = "[G]it[D]iff [T]oggleFiles" })
	end,
}
