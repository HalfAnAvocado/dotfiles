local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package Manager
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    use 'nvim-tree/nvim-web-devicons' -- Terminal icons, requires patched Nerd Font
    use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
    use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }, tag = 'nightly', config = function() require("nvim-tree").setup() end }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { 'nvim-lua/plenary.nvim' } }
    use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }

    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { "rafamadriz/friendly-snippets" }

    use { 'NvChad/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
    use 'karb94/neoscroll.nvim'

    use 'ellisonleao/gruvbox.nvim' -- Colorscheme
    use 'sainnhe/sonokai' -- Colorscheme
    use {'srcery-colors/srcery-vim', as = 'srcery'}

    if packer_bootstrap then
        require('packer').sync()
    end
end)
