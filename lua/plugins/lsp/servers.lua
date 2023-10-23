local lspconfig = require("lspconfig")
local utils = require("jamestansx.utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local handlers = {
    ["textDocument/signatureHelp"] = vim.lsp.with(function(_, result, ctx, config)
        return vim.lsp.handlers.signature_help(_, utils.lsp_remove_docs(result), ctx, config)
    end, { anchor_bias = "above" }),
}

local on_attach = function(client, bufnr)
end

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
})
