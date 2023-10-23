local utils = require("jamestansx.utils")
local autocmd = utils.create_autocmd
local ft_guard = utils.ft_guard

autocmd({ "TextYankPost" }, {
    desc = "Highlight text on yank",
    group = "HiTextOnYank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    desc = "Create missing directories before saving files",
    group = "MkdirOnSave",
    pattern = "*",
    callback = function(args)
        -- Skip for URL
        if not args.match:match("^%w+://") then
            local file = vim.loop.fs_realpath(args.match) or args.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
    end,
})

autocmd({ "BufWritePre" }, {
    desc = "Trim trailing whitespace before saving file",
    group = "TrimTrailingWhitespace",
    pattern = "*",
    callback = function()
        if vim.tbl_isempty(vim.b.editorconfig) then
            local view = vim.fn.winsaveview()
            vim.api.nvim_command("silent! undojoin")
            vim.api.nvim_command("silent keepjumps keeppatterns %s/\\s\\+$//e")
            vim.fn.winrestview(view)
        end
    end,
})

autocmd({ "BufReadPost" }, {
    desc = "Restore last cursor when opening a buffer",
    group = "RestoreLastCursor",
    pattern = "*",
    callback = function(args)
        ft_guard(function()
            local mark = vim.api.nvim_buf_get_mark(0, '"')
            if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
        end, {
            ft = vim.bo[args.buf].ft,
            ignore_ft = { "gitcommit", "gitrebase" },
        })
    end,
})

autocmd({ "WinLeave" }, {
    desc = "Disable cursorline on leaving window",
    group = "ToggleCursorLine",
    pattern = "*",
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "_toggleCursorLine", cl)
            vim.wo.cursorline = false
        end
    end,
})

autocmd({ "WinEnter" }, {
    desc = "Enable cursorline on entering window",
    group = "ToggleCursorLine",
    pattern = "*",
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "_toggleCursorLine")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "_toggleCursorLine")
        end
    end,
})

autocmd({ "CmdLineEnter" }, {
    desc = "Disable relative number in cmdline mode",
    group = "ToggleRelativeNumber",
    pattern = "*",
    callback = function()
        local rnu = vim.wo.relativenumber

        if rnu then
            vim.api.nvim_win_set_var(0, "_toggleRelativeNumber", rnu)
            vim.wo.relativenumber = false
            vim.cmd.redraw()
        end
    end,
})

autocmd({ "CmdLineLeave" }, {
    desc = "Toggle back relative number on leaving cmdline",
    group = "ToggleRelativeNumber",
    pattern = "*",
    callback = function()
        local ok, rnu = pcall(vim.api.nvim_win_get_var, 0, "_toggleRelativeNumber")

        if ok and rnu then
            vim.wo.relativenumber = true
            vim.api.nvim_win_del_var(0, "_toggleRelativeNumber")
        end
    end,
})

autocmd({ "BufRead", "FileType" }, {
    desc = "Reset undo persistence on certain buffers",
    group = "NoUndoPersist",
    pattern = {
        -- Paths
        "/tmp/*",
        "*.tmp",
        "*.bak",

        -- Filetype
        "gitcommit",
        "gitrebase",
    },
    command = [[setlocal noundofile]],
})

autocmd({ "BufRead", "FileType" }, {
    desc = "Prevent accidental write to buffers that shouldn't be edited",
    group = "NotModifiable",
    pattern = {
        -- Paths
        "*.orig",
        "*.pacnew",
    },

    command = [[setlocal nomodifiable]],
})

autocmd({ "FileType" }, {
    desc = "Press `q` to close the window",
    group = "KeymapQuit",
    pattern = {
        "checkhealth",
        "help",
        "man",
        "nofile",
        "qf", -- TODO: Use bqf.nvim
        "vim",
    },
    callback = function(args)
        vim.bo[args.buf].buflisted = false
        vim.api.nvim_buf_set_keymap(args.buf, "n", "q", "<CMD>close<CR>", { silent = true, noremap = true })
    end,
})

autocmd({ "LspAttach" }, {
    desc = "Setup LSP mappings",
    group = "LspConfig",
    callback = function(ev)
        vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
        require("plugins.lsp.keymaps").on_attach(ev.buf)
    end,
})
