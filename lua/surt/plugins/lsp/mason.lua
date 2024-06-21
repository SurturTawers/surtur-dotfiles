local lsp_langs = {
	"bashls",
	"clangd",
	"cssls",
	"cssmodules_ls",
	"css_variables",
	"docker_compose_language_service",
	"dockerls",
	"eslint",
	"html",
	"intelephense",
	"jedi_language_server",
	"jsonls",
	"lua_ls",
	"marksman",
	"pest_ls",
	"phpactor",
	"pyright",
	"sqlls",
	"svelte",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

local lsp_formatters_linters_debuggers = {
	--formatters
	"prettier", --Angular, JS, TS, CSS, FLow, GraphQL, JSON, HTML, JSX, MD, SCSS, VUUE, YAML
	"stylua", -- Lua, Luau
	"isort", -- Python, sorts imports alphabetically
	"black", -- Python
	"blade-formatter", --Laravel Blade
	--linters
	"pylint", --Python
	"eslint_d", -- TS, JS
	"markdownlint", -- MD
	"yamllint", --yaml
	"jsonlint", --JSON
	"quick-lint-js", --JS, TS "Faster" than eslint
	--debuggers
	"bash-debug-adapter", --Bash
	"chrome-debug-adapter", --JS, TS with chrome
	"debugpy", --python
	"delve", --Go debugger
	--"js-debug-adapter", -- VSCode debugger for JS and TS
	"php-debug-adapter", --PHP
}

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = lsp_langs,
		})
		mason_tool_installer.setup({
			ensure_installed = lsp_formatters_linters_debuggers,
		})
	end,
}
