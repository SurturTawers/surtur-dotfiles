local colorschemes = {
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
          nvimtree = true,
          treesitter = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
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
  material = {
    "marko-cerovac/material.nvim",
    config = function() 
      require('material').setup({
        styles = {
          comments = {italic = true},
          keywords = {italic = true},
        }
      })
      vim.cmd.colorscheme("material-palenight")
    end,
  },
}

return colorschemes["kanagawa"]
