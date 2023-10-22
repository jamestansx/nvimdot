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

return M
