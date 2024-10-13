-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.lazyredraw = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.list = true
vim.opt.listchars:append 'space:⋅'
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>te', '<cmd>below split | resize 18% | term<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>tv', '<cmd>rightbelow vsplit | term<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Tab>', '<C-d>')

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    -- other plugins
    { import = 'lsp' },
    { import = 'plugins' },
  },
  change_detection = {
    notify = false,
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'github_dark_default' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
