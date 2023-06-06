vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guicursor = ''

vim.opt.expandtab = true
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.opt.softtabstop=4

vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.linebreak = true
-- vim.opt.textwidth=79
vim.opt.colorcolumn= {80, 140}

vim.opt.backup = false
vim.opt.writebackup = true
vim.opt.swapfile = true
vim.opt.undofile = true

vim.opt.wildmode = 'list:longest'
vim.opt.wildignorecase = true
vim.opt.wildignore:append({'*~', '*.pyc'})
vim.opt.wildignore:append('.git')
vim.opt.wildignore:append({'*.jpg', '*.jpeg', '*.png', '*.gif'})

vim.opt.spelllang = { 'de_20', 'en_us', 'cjk' }

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.list = true
vim.opt.listchars = { tab = '»·', eol = '¬', extends = '›', precedes = '‹', nbsp = '␣', trail = '·'}
vim.opt.showbreak='↪'

vim.opt.clipboard:append('unnamedplus')
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.fileformat = 'unix'
vim.opt.modelines = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.gdefault = true
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

vim.opt.number = true
vim.opt.scrolloff = 0
vim.opt.shiftround = true
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.lazyredraw = true
vim.opt.diffopt:append('vertical')
vim.opt.iskeyword:append("-")
