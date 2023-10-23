local M = {}
local utils = require("jamestansx.utils")

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.handlers = {
    ["textDocument/signatureHelp"] = vim.lsp.with(function(_, result, ctx, config)
        return vim.lsp.handlers.signature_help(_, utils.lsp_remove_docs(result), ctx, config)
    end, { anchor_bias = "above" }),
}

return M
