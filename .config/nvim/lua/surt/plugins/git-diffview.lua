return {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("diffview").setup({})
		vim.keymap.set("n", "<leader>gvo", "<cmd>DiffviewOpen<CR>", { desc = "[G]it[D]iff [O]pen" })
		vim.keymap.set("n", "<leader>gvc", "<cmd>DiffviewClose<CR>", { desc = "[G]it[D]iff [C]lose" })
		vim.keymap.set("n", "<leader>gvt", "<cmd>DiffviewToggleFiles<CR>", { desc = "[G]it[D]iff [T]oggleFiles" })

		vim.cmd("highlight DiffviewDiffAdd guibg=#2f8a1a")
		vim.cmd("highlight DiffviewDiffDelete guibg=#911f1f")
		vim.cmd("highlight DiffviewDiffText guibg=#9e5a11")
	end,
}

--[[
cmd: highlight HighlightColor guibg=#hex guifg=#hex ctermfg=number ctermbg=number

DiffViewFilePanelPath -> Help color
DiffViewFilePanelRootPath -> git root path
DiffViewFilePanelTitle -> file panel titles color
DiffViewFilePanelCounter -> file panel number of modified files color
DiffViewFilePanelFileName -> file panel non selected file name color
DiffViewFilePanelSelected -> file panel selected file color
DiffViewFilePanelInsertions -> insertions counter color
DiffViewFilePanelDeletions -> deletions counter color

DiffViewFolderSign -> folder icon color
DiffViewFolderName -> folder name color

DiffViewStatusUntracked -> untracked file icon color
DiffViewStatusModified -> modified file icon color 
DiffViewStatusLineNC -> color of status line from original buffer
DiffViewStatusLine -> status line color of the file list panel

DiffViewWindSeparator -> color of separator line between files and file list
DiffViewNormal -> color of the file panel
DiffViewEndOfBuffer -> File panel color below the file list
DiffViewCursorLine -> color of cursorline on file panel

DiffViewDiffAdd -> color of added line on modified file
DiffViewDiffDelete -> color of the original file "delete lines"
DiffViewNonText -> color of changes folder icon
DiffViewDiffText -> color of diff highlight between original and modified files
DiffViewDiffChange -> color of diff between original and modified

DiffViewDim1 -> ??
DiffViewSecondary -> ??
DiffViewPrimary -> ??
DiffViewSignColumn -> ??
DiffViewStatusIgnored -> ??
DiffViewStatusBroken ->  ??
DiffViewStatusDeleted -> ??
DiffViewStatusUnknown -> ??
DiffViewStatusTypeChange -> ??
DiffViewStatusCopied -> ??
DiffViewStatusRenamed -> ??
DiffViewStatusAdded -> ??
DiffViewReflogSelector -> ??
DiffViewHash -> ??
DiffViewFilePanelConflicts -> ??
DiffViewReference -> ??
DiffViewStatusUnmerged -> ??
DiffViewDiffAddAsDelete -> ??
DiffViewDiffDeleteDim -> ??
--]]
