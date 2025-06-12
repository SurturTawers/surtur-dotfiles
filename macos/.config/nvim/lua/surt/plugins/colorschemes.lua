local colorschemes = {
	--CATPPUCCIN
	catppuccin = {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				dim_inactive = {
					enabled = true,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
				integrations = {
					alpha = true,
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	-- KANAGAWA
	kanagawa = {
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				commentStyle = { italic = true },
				keywordStyle = { italic = true },
				dimInactive = true,
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	-- KANAGAWA PAPER
	kanagawa_paper = {
		"sho-87/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("kanagawa-paper").setup({})
			vim.cmd.colorscheme("kanagawa-paper")
		end,
	},
	-- MATERIAL
	material = {
		"marko-cerovac/material.nvim",
		config = function()
			require("material").setup({
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
				},
			})
			vim.cmd.colorscheme("material-darker")
			vim.g.material_style = "darker"
		end,
	},
	-- NORDIC
	nordic = {
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").setup({
				after_palette = function(palette)
					local U = require("nordic.utils")
					palette.bg_visual = U.blend(palette.orange.base, palette.bg, 0.35)
				end,
				on_highlight = function(highlights, palette)
					local U = require("nordic.utils")
					highlights.TelescopePreviewLine = {
						bg = U.blend(palette.orange.base, palette.bg, 0.35),
						sp = palette.yellow.dim,
						undercurl = false,
					}
				end,
				bold_keywords = true,
				italic_comments = true,
				cursorline = {
					blend = 0.9,
				},
			})
			require("nordic").load()
			vim.cmd.colorscheme("nordic")
		end,
	},
	-- EVERFOREST
	everforest = {
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				background = "hard",
				--transparent_background_level = 2,
				italics = true,
				colours_override = function(palette)
					palette.bg0 = "#1A1A22" -- Override background color
				end,
			})
			vim.cmd.colorscheme("everforest")
		end,
	},
	-- ROSE PINE
	rosepine = {
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	--EDGE
	edge = {
		"sainnhe/edge",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.edge_enable_italic = true
			vim.cmd.colorscheme("edge")
		end,
	},
	--SONOKAI
	sonokai = {
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.sonokai_enable_italic = true
			vim.cmd.colorscheme("sonokai")
		end,
	},
	-- TOKYONIGHT
	tokyonight = {
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({})
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	-- NIGHTFOX
	nightfox = {
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					dim_inactive = true,
					terminal_colors = true,
					styles = {
						comments = "italic",
						constants = "bold",
						keywords = "italic",
					},
				},
			})
			vim.cmd.colorscheme("duskfox")
		end,
	},
}

return colorschemes["nordic"]
