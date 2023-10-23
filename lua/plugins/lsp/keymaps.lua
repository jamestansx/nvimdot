local M = {}

function M.on_attach(bufnr)
    -- Resolve keymap capabilities over all buffer clients
    -- https://github.com/LazyVim/LazyVim/blob/566049aa4a26a86219dd1ad1624f9a1bf18831b6/lua/lazyvim/plugins/lsp/keymaps.lua#L69
    local function has(method)
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
        for _, c in ipairs(clients) do
            if c.supports_method(method) then
                return true
            end
        end
        return false
    end

    local function map(mode, lhs, rhs, opts)
        if opts.has and not has(opts.has) then
            return
        end

        opts.has = nil
        opts.silent = opts.silent ~= false
        opts.noremap = true
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- stylua: ignore start

    -- Goto xxx
    map("n", "gd", vim.lsp.buf.definition, { has = "textDocument/definition" })
    map("n", "gr", vim.lsp.buf.references, { has = "textDocument/references" })
    map("n", "gi", vim.lsp.buf.implementation, { has = "textDocument/implementation" })
    map("n", "gD", vim.lsp.buf.type_definition, { has = "textDocument/typeDefinition" })

    -- Help
    map("n", "K", vim.lsp.buf.hover, { has = "textDocument/hover" })
    map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { has = "textDocument/signatureHelp" })

    -- Action
    map("n", "<leader>a", vim.lsp.buf.code_action, { has = "textDocument/codeAction" })
    map("n", "<leader>f", vim.lsp.buf.format, { has = "textDocument/formatting" })
    map("n", "<leader>r", vim.lsp.buf.rename, { has = "textDocument/rename" })

    -- stylua: ignore end
end

return M
