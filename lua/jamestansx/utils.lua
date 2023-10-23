local M = {}

-- Create autocommand with auto augroup creation
function M.create_autocmd(event, opts)
    if opts.group and vim.fn.exists("#" .. opts.group) == 0 then
        vim.api.nvim_create_augroup(opts.group, { clear = true })
    end
    vim.api.nvim_create_autocmd(event, opts)
end

-- Guard callback of autocmd for filetypes
function M.ft_guard(callback, opts)
    if not vim.tbl_contains(opts.ignore_ft or {}, opts.ft or "") then
        callback()
    end
end

-- Remove documentation from lsp request result (for signature help)
function M.lsp_remove_docs(docs)
    if docs == nil then
        return
    end

    for i = 1, #docs.signatures do
        if docs.signatures[i] and docs.signatures[i].documentation then
            if docs.signatures[i].documentation.value then
                docs.signatures[i].documentation.value = nil
            else
                docs.signatures[i].documentation = nil
            end
        end
    end
    return docs
end

return M
