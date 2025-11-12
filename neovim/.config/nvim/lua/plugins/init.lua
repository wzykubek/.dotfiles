return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
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
        config = function()
            require('gitsigns').setup({
                sign_priority = 10,
            })
        end,
    },
    {
        'saghen/blink.cmp',
        version = '1.*',
        opts = {
            keymap = { preset = 'super-tab' },
            completion = { documentation = { auto_show = true } },
        }

    },
    "folke/which-key.nvim",
}
