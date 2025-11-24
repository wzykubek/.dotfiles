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

vim.keymap.set('n', '<esc>', ':nohlsearch<cr>', { silent = true })

require("config.lazy")

vim.diagnostic.config({ update_in_insert = false, virtual_text = true, virtual_lines = true })

vim.lsp.config['lua_ls'] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, ".git" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'hs' }
            }
        }
    }
}

vim.lsp.config["tinymist"] = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType"
    },
}

vim.lsp.config["bash_ls"] = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" }
}

vim.lsp.config["gopls"] = {
    cmd = { "gopls" },
    filetypes = { "go" }
}

vim.lsp.enable('lua_ls')
vim.lsp.enable('tinymist')
vim.lsp.enable('bash_ls')
vim.lsp.enable('gopls')

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'gA', vim.lsp.buf.references, { desc = 'Find all references' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, { desc = 'Show code actions' })
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
