require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'lua', 'vim', 'help', 'python', 'markdown', 'markdown_inline', 'dockerfile', 'html', 'css', 'sql', 'solidity', 'terraform', 'yaml' },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,

        autopairs = {
            enable = true
        },

        indent = { enable = true },

        context_commentstring = {
            enable = true,
            enable_autocmd = false
        }
    }
}
