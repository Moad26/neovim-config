vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.tabstop = 2                -- Number of spaces per tab
vim.opt.softtabstop = 2            -- Editing feels like 2 spaces per tab
vim.opt.shiftwidth = 2             -- Indent by 2 spaces
vim.opt.smartindent = true         -- Smart indentation
vim.opt.wrap = false               -- Disable line wrapping
vim.opt.cursorline = true          -- Highlight the current line
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Show relative line numbers
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.termguicolors = true       -- Enable true colors
vim.opt.background = "light"       -- Light background for themes
vim.opt.list = true                -- Show whitespace characters
vim.opt.listchars = { tab = "▸ ", trail = "·", extends = "→", precedes = "←" }
