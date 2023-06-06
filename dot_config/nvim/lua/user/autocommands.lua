local git_commit_message_group = vim.api.nvim_create_augroup('gitCommitMessage', { clear = true })
local plaintext = vim.api.nvim_create_augroup('plaintext', { clear = true })
local markdown = vim.api.nvim_create_augroup('markdown', { clear = true })
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})

vim.api.nvim_create_autocmd({'Filetype'}, {pattern = 'gitcommit', group = git_commit_message_group, command = 'setlocal spell textwidth=72 colorcolumn=51,73'} )
vim.api.nvim_create_autocmd({'Filetype'}, {pattern = 'text', group = plaintext, command = 'setlocal spell foldmethod=marker foldcolumn=2'} )
vim.api.nvim_create_autocmd({'Filetype'}, {pattern = 'markdown', group = markdown, command = 'setlocal spell conceallevel=2'} )
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 500,
        })
    end,
})

-- https://github.com/romgrk/barbar.nvim#integration-with-filetree-plugins
vim.api.nvim_create_autocmd('FileType', {
  callback = function(tbl)
    local set_offset = require('bufferline.api').set_offset

    local bufwinid
    local last_width
    local autocmd = vim.api.nvim_create_autocmd('WinScrolled', {
      callback = function()
        bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

        local width = vim.api.nvim_win_get_width(bufwinid)
        if width ~= last_width then
          set_offset(width, 'FileTree')
          last_width = width
        end
      end,
    })

    vim.api.nvim_create_autocmd('BufWipeout', {
      buffer = tbl.buf,
      callback = function()
        vim.api.nvim_del_autocmd(autocmd)
        set_offset(0)
      end,
      once = true,
    })
  end,
  pattern = 'NvimTree', -- or any other filetree's `ft`
})
