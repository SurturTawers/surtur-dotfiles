return   { 
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false
      },
    }
    vim.keymap.set('n', '<leader>to', ':NvimTreeOpen<CR>',  {desc = "Nvim[T]ree [O]pen"})
    vim.keymap.set('n', '<leader>tc', ':NvimTreeClose<CR>',  {desc = "Nvim[T]ree [C]lose"})
  end,
}

