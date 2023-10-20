-- Global variables
vim.g.istty = os.getenv("DISPLAY") == nil and os.getenv("WAYLAND_DISPLAY") == nil

-- Configurations
require("jamestansx.lazy")
