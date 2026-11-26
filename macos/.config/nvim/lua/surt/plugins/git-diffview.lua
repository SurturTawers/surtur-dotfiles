-- Review changes: what Claude (or you) changed, a branch like a PR, or a file's history.
--   <leader>gvo  uncommitted changes (working tree + staged) vs HEAD
--   <leader>gvm  this branch vs the default branch (PR-style review, merge-base)
--   <leader>gvh  history of the current file      <leader>gvH  history of the repo
--   <leader>gvc  close                            <leader>gvt  toggle the file panel
-- Inside a diff: ]c / [c next/prev change, <tab>/<s-tab> next/prev file,
--   - stage/unstage file in the panel, gf open file in the previous tab.

-- origin's default branch (origin/main, origin/master, ...), falling back to "main"
local function default_branch()
	local ref = vim.fn.systemlist("git symbolic-ref --quiet --short refs/remotes/origin/HEAD")[1]
	if vim.v.shell_error == 0 and ref and ref ~= "" then
		return ref
	end
	return "main"
end

return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gvo", "<cmd>DiffviewOpen<CR>", desc = "Diff: uncommitted changes" },
		{
			"<leader>gvm",
			function()
				vim.cmd("DiffviewOpen " .. default_branch() .. "...HEAD")
			end,
			desc = "Diff: branch vs default branch (PR review)",
		},
		{ "<leader>gvh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff: current file history" },
		{ "<leader>gvH", "<cmd>DiffviewFileHistory<CR>", desc = "Diff: repo history" },
		{ "<leader>gvc", "<cmd>DiffviewClose<CR>", desc = "Diff: close" },
		{ "<leader>gvt", "<cmd>DiffviewToggleFiles<CR>", desc = "Diff: toggle file panel" },
		{
			"<leader>g?",
			function()
				vim.cmd("vsplit " .. vim.fn.fnameescape(vim.fn.stdpath("config") .. "/GIT-REVIEW.md"))
				vim.bo.modifiable = false
			end,
			desc = "Git review manual",
		},
	},
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true, -- word-level highlights inside changed lines
			view = {
				default = { winbar_info = true },
				merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
				file_history = { winbar_info = true },
			},
			file_panel = {
				listing_style = "tree",
				win_config = { position = "left", width = 35 },
			},
			hooks = {
				-- no relative numbers / folds noise while reviewing
				diff_buf_win_enter = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.foldenable = false
				end,
			},
		})
	end,
}
