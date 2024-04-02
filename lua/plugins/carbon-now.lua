return {
	"ellisonleao/carbon-now.nvim",
  cmd = "CarbonNow",
	config = function()
		require("carbon-now").setup()
	end,
  vim.keymap.set("v", "<leader>cs", ":CarbonNow<CR>", {desc = "[C]ode [S]creenshot", silent = true })
}
