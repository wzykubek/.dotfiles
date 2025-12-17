-- Options {{{
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

-- GUI {{{
-- Mainly for MacOS or Windows
if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_padding_top = 5
    vim.g.neovide_padding_bottom = 5
    vim.g.neovide_refresh_rate = 165
end
vim.o.guifont = "Iosevka NFP:h14"
-- }}}
-- }}}

-- Bindings {{{
-- Plugin specific bindings are defined in Lazy configs
vim.keymap.set('n', '<esc>', ':nohlsearch<cr>', { silent = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grt')
-- }}}

vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "zathura", pdf_path })
    end
end, {})
vim.keymap.set('n', '<leader>op', ':OpenPdf<cr>', { silent = true, desc = 'Open current file as PDF' })

vim.api.nvim_create_autocmd("Filetype", {
	pattern = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end
})

require("config.lazy")
require("config.lsp")
