return {
    {
        "rose-pine/neovim",
        lazy = false,
        prority = 1000,
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            vim.treesitter.language.register('gotmpl', 'template')
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "go",
                    "gotmpl",
                    "html",
                    "css",
                    "zig",
                    "python",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "gitignore"
                },
                highlight = {
                    enable = true,
                }
            })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    section_separators = {
                        left = "",
                        right = "",
                    },
                    component_separators = {
                        left = "",
                        right = "",
                    }
                }
            })
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        config = function()
            require('gitsigns').setup({
                sign_priority = 10,
            })
        end,
        keys = {
            { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>",      desc = "Git stage hunk" },
            { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Git unstage hunk" },
            { "]h",         "<cmd>Gitsigns nav_hunk next<cr>",   desc = "Git next hunk" },
            { "[h",         "<cmd>Gitsigns nav_hunk prev<cr>",   desc = "Git prev hunk" },
        }
    },
    {
        'saghen/blink.cmp',
        version = '1.*',
        event = "InsertEnter",
        opts = {
            keymap = { preset = "super-tab" },
            completion = { documentation = { auto_show = true } },
        }

    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            winopts = {
                preview = { default = "bat_native" }
            },
        },
        keys = {
            { "<leader>ff", "<cmd>FzfLua files<cr>",               desc = "Files" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>",             desc = "Buffers" },
            { "<leader>lg", "<cmd>FzfLua live_grep<cr>",           desc = "Live grep" },
            { "<leader>gf", "<cmd>FzfLua git_files<cr>",           desc = "Git files" },
            { "<leader>gh", "<cmd>FzfLua git_hunks<cr>",           desc = "Git hunks" },
            { "<leader>gs", "<cmd>FzfLua git_status<cr>",          desc = "Git status" },
            { "<leader>gL", "<cmd>FzfLua git_commits<cr>",         desc = "Git log for project" },
            { "<leader>gl", "<cmd>FzfLua git_bcommits<cr>",        desc = "Git log for current file" },
            { "gA",         "<cmd>FzfLua lsp_references<cr>",      desc = "LSP references" },
            { "gI",         "<cmd>FzfLua lsp_implementations<cr>", desc = "LSP implementations" },
            { "g.",         "<cmd>FzfLua lsp_code_actions<cr>",    desc = "LSP code actions" },
        },
        cmd = "FzfLua"
    }
}
