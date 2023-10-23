local lspconfig = require("lspconfig")
local d = require("plugins.lsp.defaults")

lspconfig.lua_ls.setup({
    capabilities = d.capabilities,
    handlers = d.handlers,
})
