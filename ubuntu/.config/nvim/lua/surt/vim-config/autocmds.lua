vim.api.nvim_create_autocmd(
  {"BufEnter", "CursorHold", "CursorHoldI", "FocusGained"},
  {
    command = "if mode() != 'c' | checktime | endif",
    pattern = {"*"}
  }
)

vim.api.nvim_create_autocmd("TextYankPost", 
  {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)
