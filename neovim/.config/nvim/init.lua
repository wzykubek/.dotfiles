vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_padding_top = 5
    vim.g.neovide_padding_bottom = 5
    vim.g.neovide_refresh_rate = 165
end
vim.o.guifont = "Iosevka NFP:h14"

vim.o.shiftwidth = 4                    -- Indent size
vim.o.tabstop = 4                       -- Tab character size
vim.o.expandtab = true                  -- Use spaces instead of tabs
vim.o.smarttab = true                   -- Use spaces for indentation and \t in the middle of lines
vim.o.ignorecase = true;                -- Ignore case on search
vim.o.autoindent = true;                -- Copy indent from previous line
vim.o.smartindent = true;               -- Add extra indentation when needed (e.g. opening brackets)
vim.o.relativenumber = true;            -- Show relative line numbers
vim.o.undofile = true;                  -- Keep undo beetween sessions
vim.o.swapfile = true;                  -- Prevent data loss when editor crashes
vim.o.cursorline = true;                -- Highlight current line
vim.o.termguicolors = true;             -- Enable true colors in terminal
vim.o.signcolumn = "auto:4";            -- Expand signcolumn when needed (e.g. display both diagnostics and gitsigns)
vim.o.mouse = "nv";                     -- Only use mouse in specified modes
vim.o.foldmethod = "marker";            -- Fold on special comments
vim.opt.clipboard:append "unnamedplus"; -- Use system clipboard

require("config.lazy")

-- LSP {{{
vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = true,
    virtual_lines = false
})

-- Source: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library'
                    -- '${3rd}/busted/library'
                }
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
            }
        })
    end,
    settings = {
        Lua = {}
    }
})

vim.lsp.config('tinymist', {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
    },
})

vim.lsp.config('harper_ls', {
    filetypes = {
        'markdown',
        'typst',
    },
    settings = {
        ["harper-ls"] = {
            linters = {
                SentenceCapitalization = false,
                SpellCheck = false,
            },
        },
    },
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('tinymist')
vim.lsp.enable('bashls')
vim.lsp.enable('gopls')
vim.lsp.enable('harper_ls')
--- }}}

vim.keymap.set('n', '<esc>', ':nohlsearch<cr>', { silent = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grt')

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})

vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "zathura", pdf_path })
    end
end, {})
vim.keymap.set('n', '<leader>op', ':OpenPdf<cr>', { silent = true, desc = 'Open current file as PDF' })
