vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = true,
    virtual_lines = false
})

-- Settings {{{
-- Many default options are defined by 'nvim-lspconfig' plugin
-- Lua {{{
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
-- }}}

vim.lsp.config('tinymist', {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
    },
})

vim.lsp.config('html', {
    filetypes = { 'html', 'gotmpl' },
})
-- }}}

-- Enabled
vim.lsp.enable('lua_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('cssls')
vim.lsp.enable('html')
vim.lsp.enable('tinymist')
vim.lsp.enable('gopls')
vim.lsp.enable('ruff')
vim.lsp.enable('oxlint')
