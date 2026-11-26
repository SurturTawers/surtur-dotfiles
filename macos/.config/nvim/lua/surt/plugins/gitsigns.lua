-- Git changes in the gutter, plus hunk-level review and staging.
--   ]h / [h   next / previous hunk           ih  hunk text object (e.g. vih, dih)
--   <leader>hp  preview hunk inline           <leader>hb  blame line (full commit)
--   <leader>hs  stage hunk (visual: lines)    <leader>hr  reset hunk (visual: lines)
--   <leader>hS  stage buffer                  <leader>hR  reset buffer
--   <leader>hd  diff file vs index            <leader>hD  diff file vs last commit
--   <leader>hB  toggle inline blame           <leader>hw  toggle word diff
--   <leader>hq  all hunks in the repo -> quickfix list
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		current_line_blame_opts = { delay = 300, virt_text_pos = "eol" },
		preview_config = { border = "rounded" },
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- navigation (in diff mode, fall back to the built-in ]c/[c behaviour)
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, "Next hunk")
			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, "Previous hunk")

			-- review
			map("n", "<leader>hp", gs.preview_hunk_inline, "Preview hunk inline")
			map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
			map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle inline blame")
			map("n", "<leader>hw", gs.toggle_word_diff, "Toggle word diff")
			map("n", "<leader>hd", gs.diffthis, "Diff file vs index")
			map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff file vs last commit")
			map("n", "<leader>hq", function() gs.setqflist("all") end, "All hunks to quickfix")

			-- stage / reset
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage selected lines")
			map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset selected lines")
			map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

			-- text object
			map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
		end,
	},
}
