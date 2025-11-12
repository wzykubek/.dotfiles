vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.neovide_scale_factor = 1.4
vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 5
vim.g.neovide_refresh_rate = 165

vim.o.shiftwidth = 4             -- Indent size
vim.o.tabstop = 4                -- Tab character size
vim.o.expandtab = true           -- Use spaces instead of tabs
vim.o.smarttab = true            -- Use spaces for indentation and \t in the middle of lines
vim.o.ignorecase = true;         -- Ignore case on search
vim.o.autoindent = true;         -- Copy indent from previous line
vim.o.smartindent = true;        -- Add extra indentation when needed (e.g. opening brackets)
vim.o.relativenumber = true;     -- Show relative line numbers
vim.o.undofile = true;           -- Keep undo beetween sessions
vim.o.swapfile = true;           -- Prevent data loss when editor crashes
vim.o.cursorline = true;         -- Highlight current line
vim.o.termguicolors = true;      -- Enable true colors in terminal
vim.o.signcolumn = "auto:4";     -- Expand signcolumn when needed (e.g. display both diagnostics and gitsigns)
vim.o.clipboard = "unnamedplus"; -- Use system clipboard
vim.o.mouse = "nv";              -- Only use mouse in specified modes

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
                globals = { 'vim' }
            }
        }
    }
}

vim.lsp.enable('lua_ls')
