vim.g.catppuccin_flavour = "mocha"

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
	opts = {
		transparent_background = true,
		show_end_of_buffer = true,
	},
}
