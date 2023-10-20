-- Global variables
vim.g.istty = os.getenv("DISPLAY") == nil and os.getenv("WAYLAND_DISPLAY") == nil

require("jamestansx.lazy")

if vim.g.istty then
	vim.cmd.colorscheme("industry")
else
	vim.cmd.colorscheme("catppuccin")
end
