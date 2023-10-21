local M = {}

-- Create autocommand with auto augroup creation
function M.create_autocmd(event, opts)
    if opts.group and vim.fn.exists("#" .. opts.group) == 0 then
        vim.api.nvim_create_augroup(opts.group, { clear = true })
    end
    vim.api.nvim_create_autocmd(event, opts)
end

return M
