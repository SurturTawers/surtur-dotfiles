-- Start screen: gradient header, project + branch, quick actions, recent files in this
-- project, and startup stats. Shown only when nvim starts without a file.
return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local p = require("catppuccin.palettes").get_palette("mocha")

		-- Highlights (Catppuccin Mocha)
		local gradient = { p.mauve, p.mauve, p.lavender, p.blue, p.sapphire, p.sky }
		for i, color in ipairs(gradient) do
			vim.api.nvim_set_hl(0, "AlphaHeader" .. i, { fg = color, bold = true })
		end
		vim.api.nvim_set_hl(0, "AlphaInfo", { fg = p.subtext0, italic = true })
		vim.api.nvim_set_hl(0, "AlphaSection", { fg = p.overlay1, bold = true })
		vim.api.nvim_set_hl(0, "AlphaButtons", { fg = p.text })
		vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = p.peach, bold = true })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = p.overlay0, italic = true })

		-- Header
		local header_lines = {
			"  ██████╗ ██╗  ████╗  ██╗  ██████╗  ██╗   ██╗██╗███╗   ███╗ ",
			" ██╔═══██╗██║  ████║  ██║ ██╔═══██╗ ██║   ██║██║████╗ ████║ ",
			" ██║   ██║██║  ████║  ██║ ██║   ██║ ██║   ██║██║██╔████╔██║ ",
			" ██║   ██║╚██╗██╔╗██╗██╔╝ ██║   ██║ ╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			" ╚██████╔╝ ╚███╔╝  ███╔╝  ╚██████╔╝  ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═════╝   ╚══╝   ╚══╝    ╚═════╝    ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		}
		local header_hl = {}
		for i = 1, #header_lines do
			header_hl[i] = { { "AlphaHeader" .. i, 0, -1 } }
		end
		local header = {
			type = "text",
			val = header_lines,
			opts = { position = "center", hl = header_hl },
		}

		-- Project + git branch (computed when the screen is drawn)
		local info = {
			type = "text",
			val = function()
				local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
				local branch = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]
				if vim.v.shell_error == 0 and branch and branch ~= "" then
					return "  " .. cwd .. "     " .. branch
				end
				return "  " .. cwd
			end,
			opts = { position = "center", hl = "AlphaInfo" },
		}

		-- Quick actions
		local function button(sc, icon, label, cmd, keybind_opts)
			local b = dashboard.button(sc, icon .. "  " .. label, cmd, keybind_opts)
			b.opts.hl = "AlphaButtons"
			b.opts.hl_shortcut = "AlphaShortcut"
			return b
		end
		local actions = {
			type = "group",
			val = {
				button("f", "󰈞", "Find file", "<cmd>Telescope find_files<CR>"),
				button("r", "󰄉", "Recent files", "<cmd>Telescope oldfiles cwd_only=true<CR>"),
				button("g", "󰊄", "Find text", "<cmd>Telescope live_grep<CR>"),
				button("e", "", "File explorer", "<cmd>NvimTreeToggle<CR>"),
				button("s", "󰁯", "Restore session", "<cmd>SessionRestore<CR>"),
				button("l", "", "LazyGit", "<cmd>LazyGit<CR>"),
				button("d", "", "Review uncommitted changes", "<cmd>DiffviewOpen<CR>"),
				-- reuses the <leader>gvm mapping from git-diffview.lua (remap so it triggers)
				button("m", "", "Review branch vs default", "<leader>gvm", { noremap = false, silent = true, nowait = true }),
				button("p", "󰒲", "Plugins", "<cmd>Lazy<CR>"),
				button("q", "󰅚", "Quit", "<cmd>qa<CR>"),
			},
			opts = { spacing = 1 },
		}

		-- Recent files in this project (1-5)
		local function recent_files()
			local cwd = vim.fn.getcwd() .. "/"
			local devicons = require("nvim-web-devicons")
			local items, n = {}, 0
			for _, file in ipairs(vim.v.oldfiles) do
				if n >= 5 then
					break
				end
				if vim.startswith(file, cwd) and vim.fn.filereadable(file) == 1 and not file:find("/%.git/") then
					n = n + 1
					-- "parent/file.ext", truncated so it fits the 50-column button next to its key
					local rel = file:sub(#cwd + 1)
					local parent = vim.fn.fnamemodify(rel, ":h:t")
					rel = (parent ~= "." and (parent .. "/") or "") .. vim.fn.fnamemodify(rel, ":t")
					if #rel > 38 then
						rel = "…" .. rel:sub(-37)
					end
					local icon = devicons.get_icon(file, vim.fn.fnamemodify(file, ":e"), { default = true })
					items[#items + 1] = button(tostring(n), icon, rel, "<cmd>e " .. vim.fn.fnameescape(file) .. "<CR>")
				end
			end
			if n == 0 then
				return { { type = "text", val = "No recent files in this project", opts = { position = "center", hl = "AlphaInfo" } } }
			end
			return items
		end
		local recent = {
			type = "group",
			val = function()
				return {
					{ type = "text", val = "Recent in this project", opts = { position = "center", hl = "AlphaSection" } },
					{ type = "padding", val = 1 },
					{ type = "group", val = recent_files(), opts = { spacing = 0 } },
				}
			end,
		}

		-- Footer: startup stats, filled in once lazy.nvim finishes starting
		local footer = { type = "text", val = "", opts = { position = "center", hl = "AlphaFooter" } }
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local s = require("lazy").stats()
				footer.val = string.format(
					"⚡ %d/%d plugins loaded in %.0f ms  ·  %s",
					s.loaded,
					s.count,
					s.startuptime,
					os.date("%a %d %b")
				)
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		alpha.setup({
			layout = {
				{ type = "padding", val = math.max(2, math.floor(vim.o.lines * 0.08)) },
				header,
				{ type = "padding", val = 1 },
				info,
				{ type = "padding", val = 2 },
				actions,
				{ type = "padding", val = 1 },
				recent,
				{ type = "padding", val = 2 },
				footer,
			},
			opts = { margin = 5 },
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				vim.opt_local.foldenable = false
			end,
		})
	end,
}
