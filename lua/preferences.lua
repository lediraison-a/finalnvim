local o = vim.opt   -- editor options
local g = vim.g     -- Global editor variables
local cmd = vim.cmd -- exectue vimscript in lua
local fn = vim.fn   -- invoke vim-functions in lua
local go = vim.go

g.mapleader = ' '

vim.o.termguicolors = true

o.syntax = "on"
o.lazyredraw = true
o.cursorline = true
o.relativenumber = true
o.number = true
o.shiftwidth = 4
o.tabstop = 4
o.clipboard:append("unnamedplus")
o.laststatus = 3
o.expandtab = true
-- o.listchars = {tab = "••", trail = "•", space = "•", extends = "»", precedes = "«"}


vim.opt.list = true
vim.opt.listchars:append "space:⋅"

vim.api.nvim_set_keymap('n', '<Leader>te', '<cmd>below split | resize 18% | term<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tv', '<cmd>rightbelow vsplit | term<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
