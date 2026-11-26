-- Languages in use: TS/JS, PHP, Python, SQL, Lua (config), plus Docker/YAML/JSON/Markdown/Bash
local lsp_servers = {
	"bashls",
	"cssls",
	"docker_compose_language_service",
	"dockerls",
	"eslint",
	"html",
	"intelephense", -- PHP (premium features unlock with a licence in ~/intelephense/licence.txt)
	"jsonls",
	"lua_ls",
	"marksman", -- Markdown
	"pyright", -- Python
	"sqlls",
	"ts_ls",
	"yamlls",
}

local tools = {
	-- formatters (used by conform.nvim)
	"prettier",
	"stylua",
	"isort",
	"black",
	"php-cs-fixer",
	-- linters (used by nvim-lint)
	"pylint",
	"eslint_d",
	"markdownlint",
	"yamllint",
	-- debug adapters (used by nvim-dap)
	"bash-debug-adapter",
	"js-debug-adapter",
	"debugpy",
	"php-debug-adapter",
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "Mason", "LspInfo", "LspInstall", "LspStart" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
			},
		})

		-- Settings shared by every server (nvim 0.11+ native LSP config)
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		vim.lsp.config("intelephense", {
			settings = {
				intelephense = {
					environment = { phpVersion = "8.5.0" }, -- matches the projects' composer.json
					files = { maxSize = 5000000 },
				},
			},
		})

		-- Installs the servers and enables them with vim.lsp.enable()
		require("mason-lspconfig").setup({
			ensure_installed = lsp_servers,
			-- stylua is installed as a formatter for conform; don't also start it as an LSP
			automatic_enable = { exclude = { "stylua" } },
		})
		require("mason-tool-installer").setup({ ensure_installed = tools })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
				end
				map("n", "gR", "<cmd>Telescope lsp_references<CR>", "LSP references")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "LSP definitions")
				map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "LSP implementations")
				map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "LSP type definitions")
				map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
				map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace symbols")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics")
				map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
				map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
				map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Documentation under cursor")
				map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
			end,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			virtual_text = { prefix = "●" },
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})
	end,
}
