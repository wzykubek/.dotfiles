return {
    {
        "rose-pine/neovim",
        lazy = false,
        prority = 1000,
        name = "rose-pine",
        init = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        event = "VeryLazy",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "go",
                "gotmpl",
                "html",
                "css",
                "typescript",
                "tsx",
                "zig",
                "python",
                "lua",
                "markdown",
                "markdown_inline",
                "gitignore",
                "comment", -- highlights fix
            },
            highlight = {
                enable = true,
            }
        },
        init = function()
            vim.filetype.add({
                pattern = {
                    [".*/template.?/.*%.html.*"] = "gotmpl",
                    [".*/layout.?/.*%.html.*"] = "gotmpl",
                }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({ async = true })
                end,
                desc = "Format buffer",
            },
        },
        opts = {
            formatters = {
                gotmplfmt = {
                    command = "gotmplfmt",
                },
            },
            formatters_by_ft = {
                gotmpl = { "gotmplfmt" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
        init = function()
            -- For regional formatting with 'gq' binding
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        opts = {
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
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        keys = {
            { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>",      desc = "Git stage hunk" },
            { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Git unstage hunk" },
            { "<leader>hr", "<cmd>Gitsigns hunk_reset<cr>",      desc = "Git reset hunk" },
            { "]h",         "<cmd>Gitsigns nav_hunk next<cr>",   desc = "Git next hunk" },
            { "[h",         "<cmd>Gitsigns nav_hunk prev<cr>",   desc = "Git prev hunk" },
        },
        opts = {
            sign_priority = 10,
        },
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        event = "InsertEnter",
        opts = {
            keymap = { preset = "super-tab" },
            completion = { documentation = { auto_show = true } },
            sources = {
                providers = {
                    snippets = {
                        override = {
                            -- Fix for snippets starting with '!', e.g. in HTML
                            get_trigger_characters = function(_) return { '!' } end,
                        },
                    },
                },
            },
        }
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "FzfLua",
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
        opts = {
            winopts = {
                preview = { default = "bat_native" }
            },
        },
    }
}
