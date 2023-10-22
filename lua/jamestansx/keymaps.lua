-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

map({ "n", "v" }, "<Space>", "<Nop>")

-- Smart j/k
-- Avoid gj/gk in operation pending mode
map({ "n", "v" }, "j", "v:count || mode(1)[0:1] == 'no' ? 'j': 'gj'", { expr = true })
map({ "n", "v" }, "k", "v:count || mode(1)[0:1] == 'no' ? 'k': 'gk'", { expr = true })

-- Center search result
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "*", "*zzzv")
map("n", "#", "#zzzv")
map("n", "g*", "g*zzzv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- From: https://github.com/mhinz/vim-galore#saner-command-line-history
map("c", "<C-n>", function()
    return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
end, { expr = true, silent = false })
map("c", "<C-p>", function()
    return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
end, { expr = true, silent = false })

-- Use the home row keys!!!!!
map("", "<Up>", "<Nop>")
map("", "<Down>", "<Nop>")
map("", "<Left>", "<Nop>")
map("", "<Right>", "<Nop>")

-- Select last pasted text
map("n", "gp", "`[v`]")

map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", [["_d]])
map("x", "<leader>p", [["_dP]])

-- XXX: Test keymaps
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })
-- Super duper magic :tada:
--map("n", "/", "/\\v", { silent = false })
--map("n", "?", "?\\v", { silent = false })
--map("c", "%s/", "%smagic/\\v", { silent = false })
