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
            keymap = {
                preset = "enter",
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
            },
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
            { "<leader>fb", "<cmd>FzfLua buffers<cr>",      desc = "Buffers" },
            { "<leader>ff", "<cmd>FzfLua files<cr>",        desc = "Files" },
            { "<leader>fg", "<cmd>FzfLua git_files<cr>",    desc = "Git files" },
            { "<leader>fh", "<cmd>FzfLua git_hunks<cr>",    desc = "Git hunks" },
            { "<leader>fs", "<cmd>FzfLua git_status<cr>",   desc = "Git status" },
            { "<leader>fL", "<cmd>FzfLua git_commits<cr>",  desc = "Git log for project" },
            { "<leader>fl", "<cmd>FzfLua git_bcommits<cr>", desc = "Git log for current file" },
        },
        cmd = "FzfLua"
    }
}
