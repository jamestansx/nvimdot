return {
    {
        "neovim/nvim-lspconfig",
        event = {
            "BufReadPre",
            "BufNewFile",
            -- "FileType",
        },
        config = function()
            require("plugins.lsp.servers")
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            text = { spinner = "dots" },
            window = {
                blend = 0,
                relative = "editor",
            },
            timer = {
                fidget_decay = 300,
                task_decay = 300,
            },
        },
    },
    {
        "akinsho/flutter-tools.nvim",
        ft = { "dart" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            fvm = true,
        },
    },
}
