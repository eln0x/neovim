--
-- Plugins installer
--

local vim = vim

-- Bootstrapper
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        })
        print "Installing packer close and reopen Neovim..."
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
packer.startup(function(use)

    -- packer
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use 'rktjmp/lush.nvim'                              -- Theme creation helper
    use 'rktjmp/shipwright.nvim'                        -- Build theme from lush
    use 'metalelf0/jellybeans-nvim'                     -- Jellybeans port to lua
    use 'folke/tokyonight.nvim'                         -- Tokyo theme
    use 'lunarvim/darkplus.nvim'                        -- Lunar theme
    use 'NvChad/nvim-colorizer.lua'                     -- Color highlighter

    -- ui
    use 'nvim-lua/plenary.nvim'                         -- Lua functions
    use 'goolord/alpha-nvim'                            -- Startup screen
    use 'akinsho/bufferline.nvim'                       -- Bufferline
    use 'nvim-lualine/lualine.nvim'                     -- Statusline
    use 'lukas-reineke/indent-blankline.nvim'           -- Show indentation when no tab
    use 'echasnovski/mini.indentscope'                  -- Visualize and work with indent scope
    use 'rcarriga/nvim-notify'                          -- Notification manager
    use 'folke/noice.nvim'                              -- Experimental UI replacement
    use 'stevearc/dressing.nvim'                        -- Ui improvements
    use 'MunifTanjim/nui.nvim'                          -- UI component library
    use 'ray-x/guihua.lua'                              -- Lua Gui and utils
    use 'kyazdani42/nvim-web-devicons'                  -- File icons
    use 'echasnovski/mini.icons'

    -- editor
    use 'folke/which-key.nvim'                          -- Key binding completion
    use 'kyazdani42/nvim-tree.lua'                      -- File explorer
    use 'nvim-telescope/telescope.nvim'                 -- Fuzzy finder
    use 'RRethy/vim-illuminate'                         -- Highlighting other uses of the word
    use 'folke/todo-comments.nvim'                      -- Highlight todo comments
    use 'lewis6991/gitsigns.nvim'                       -- Show modified lines for VCS files
    use 'nvim-pack/nvim-spectre'                        -- Search and replace panel
    use 'folke/flash.nvim'                              -- Navigate by search labels
    use 'stevearc/aerial.nvim'                          -- Code outline and nav helper
    use 'folke/trouble.nvim'                            -- List to show diag, ref, quickfix...
    use 'akinsho/toggleterm.nvim'                       -- Toggle terminal

    -- coding
    use 'hrsh7th/nvim-cmp'                              -- Nvim completion
    use 'hrsh7th/cmp-nvim-lsp'                          -- Lsp completion
    use 'hrsh7th/cmp-buffer'                            -- Buffer words
    use 'hrsh7th/cmp-path'                              -- Filesystem path
    use 'hrsh7th/cmp-cmdline'                           -- Nvim's commandline
    use 'hrsh7th/cmp-calc'                              -- Math calculation
    use 'hrsh7th/cmp-nvim-lua'                          -- Complete lua api
    use 'onsails/lspkind-nvim'                          -- Add pictograms to builtin lsp
    use 'L3MON4D3/LuaSnip'                              -- Luasnip users
    use 'saadparwaiz1/cmp_luasnip'                      -- Luasnip completion source
    use 'rafamadriz/friendly-snippets'                  -- Snippets collection
    use 'JoosepAlviste/nvim-ts-context-commentstring'   -- Comment string helper
    use 'numToStr/Comment.nvim'                         -- Comment helper
    use 'ray-x/go.nvim'                                 -- Golang neovim plugin

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'               -- Syntax highlightings
    use 'nvim-treesitter/nvim-treesitter-textobjects'   -- Treesitter for textobjects
    use 'nvim-treesitter/nvim-treesitter-context'       -- Treesitter for context

    -- lsp
    use 'neovim/nvim-lspconfig'                         -- Lsp configuration
    use 'williamboman/mason.nvim'                       -- Manage external editors
    use 'williamboman/mason-lspconfig.nvim'             -- Bridge mason with lspconfig
    use "ray-x/lsp_signature.nvim"                      -- Signature completion
    use 'WhoIsSethDaniel/mason-tool-installer.nvim'     -- Install or upgrade 3rd party tools
    use 'jose-elias-alvarez/null-ls.nvim'               -- Diagnostic and code injection
    use 'mfussenegger/nvim-dap'                         -- Debug adapter protocol
    use 'rcarriga/nvim-dap-ui'                          -- Dap ui
    use 'nvim-neotest/nvim-nio'
    use 'theHamsta/nvim-dap-virtual-text'               -- Virtual text support
    -- use 'ravenxrz/DAPInstall.nvim'                   -- Dap installer

    -- tags
    use 'preservim/tagbar'                              -- Tags browser
    use 'ludovicchabant/vim-gutentags'                  -- Tags management

    -- git
    use 'tpope/vim-fugitive'                            -- Github Wrapper
    use 'rhysd/git-messenger.vim'                       -- Show git hidden messages

    -- utils
    use 'ahmedkhalf/project.nvim'                       -- Project jumper
    use 'dstein64/vim-startuptime'                      -- Startup time bench
    use 'mfussenegger/nvim-lint'                        -- Nvim linter
    use 'folke/persistence.nvim'                        -- Automated session management
    use 'lewis6991/impatient.nvim'                      -- Speedup startup time
    use 'Raimondi/delimitMate'                          -- Autoclose quotes, bracket etc...
    use 'roxma/vim-paste-easy'                          -- Automatic paste mode
    use 'terryma/vim-multiple-cursors'                  -- Multiple cursors
    use 'tpope/vim-eunuch'                              -- Common shell commands
    use 'troydm/zoomwintab.vim'                         -- Simple tab zoomer
    use 'yuttie/comfortable-motion.vim'                 -- Vim Scroller
    use 'mhinz/vim-rfc'                                 -- Download RFC
    use 'm4xshen/hardtime.nvim'                         -- Best practice

    -- syntax
    use 'Joorem/vim-haproxy'                            -- HAProxy syntax
    use 'chr4/nginx.vim'                                -- Nginx syntax
    use 'saltstack/salt-vim'                            -- Saltstack syntax
    use 'glench/vim-jinja2-syntax'                      -- Jinja2 syntax
    use 'rodjek/vim-puppet'                             -- Puppet syntax

    -- sync configuration after cloning packer.nvim
    if packer_bootstrap then
        packer.sync()
    end
end)

-- vim: ts=4 sts=4 sw=4 et
