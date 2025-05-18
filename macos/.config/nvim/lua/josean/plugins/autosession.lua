return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = {"~/","~/Dev/","~/Downloads","~/Documents","~/Desktop"}
    })

    local kmp = vim.keymap

    kmp.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", {desc = "Restore session for current working directory"})
    kmp.set("n", "<leader>ws", "<cmd>SessionSave<CR>", {desc = "Save session for current root dir"})
  end,
}
