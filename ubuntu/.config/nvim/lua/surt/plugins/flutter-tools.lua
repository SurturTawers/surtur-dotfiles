return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		vim.keymap.set("n", "<leader>FS", ":FlutterRun <CR>", {})
		vim.keymap.set("n", "<leader>FQ", ":FlutterQuit <CR>", {})
		vim.keymap.set("n", "<leader>FR", ":FlutterRestart <CR>", {})
		vim.keymap.set("n", "<leader>FLR", ":FlutterLspRestart <CR>", {})
		vim.keymap.set("n", "<leader>FD", ":FlutterDevTools <CR>", {})
		require("flutter-tools").setup({
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			dev_tools = {
				autostart = true, -- autostart devtools server if not detected
				auto_open_browser = true, -- Automatically opens devtools in the browser
			},
			lsp = {
				on_attach = function(client, bufnr)
					-- Enable document colors for Neovim 0.12+
					vim.lsp.document_color.enable(bufnr)
				end,
				cmd = { "dart", "language-server", "--protocol=lsp" },
			},
		})
	end,
}
