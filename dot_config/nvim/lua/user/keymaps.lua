vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- shortcuts to change buffers the same way as tabs
-- vim.keymap.set('n', 'gb', ':bn<CR>', {})
-- vim.keymap.set('n', 'gB', ':bp<CR>', {})

-- Fast save
vim.keymap.set('n', '<leader>w', ':w!<cr>', {})

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>', {})

vim.keymap.set('n', '<leader><space>', ':noh<cr>', {})

vim.keymap.set('n', '<tab>', '%', {})

vim.keymap.set('n', '<leader>s', ':%s//<left>', {})
vim.keymap.set('v', '<leader>s', ':s//<left>', {})

-- use enter/backspace to add/remove lines in normal mode
-- New line without entering insert mode
vim.keymap.set('n', '<CR>', 'o<Esc>k', {})
vim.keymap.set('n', '<S-CR>', 'ko<Esc>j', {})
vim.keymap.set('n', '<Backspace>', 'ddk', {})

-- Do not fill the yank register with single chars
vim.keymap.set('n', 'x', '"_x', {})
vim.keymap.set('n', 'X', '"_X', {})

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', {})

vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', {})
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', {})

vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', {})
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', {})

vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', {})
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', {})
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', {})
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', {})
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', {})
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', {})
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', {})
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', {})
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', {})
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', {})

vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', {})

vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', {})
