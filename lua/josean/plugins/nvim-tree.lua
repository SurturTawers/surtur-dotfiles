return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = ""
            },
          },
        },
      },
      -- disable window picker on window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = {".DS_Store"},
      },
      -- show files ignored by git
      git = {
        ignore = false
      },
    })

    -- keymaps
    local kmp = vim.keymap
    kmp.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle file explorer"})
    kmp.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {desc = "Toggle file explorer on current file"})
    kmp.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", {desc = "Collapse file explorer"})
    kmp.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {desc = "Refresh file explorer"})
  end
}
