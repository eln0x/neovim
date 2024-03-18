--
-- Lazy Bootstrap
--
-- https://github.com/folke/lazy.nvim.git

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
    spec = {
        -- add LazyVim and import its plugins
        -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- { import = "lazyvim.plugins.extras.lang.typescript" },
        -- { import = "lazyvim.plugins.extras.lang.json" },
        -- { import = "lazyvim.plugins.extras.ui.mini-animate" },

        -- library
        'nvim-lua/plenary.nvim',                         -- Lua functions
        'ray-x/guihua.lua',                              -- Lua Gui and utils
        'MunifTanjim/nui.nvim',                          -- UI component library

        -- theme
        'goolord/alpha-nvim',                            -- Startup screen
        'nvim-lualine/lualine.nvim',                     -- Statusline
        'akinsho/bufferline.nvim',                       -- Bufferline
        'kyazdani42/nvim-web-devicons',
        'folke/noice.nvim',                              -- Experimental UI replacement
        'rcarriga/nvim-notify',                          -- Notification manager

        -- colorscheme
        'rktjmp/lush.nvim',                              -- Theme creation helper
        'rktjmp/shipwright.nvim',                        -- Build theme from lush
        'metalelf0/jellybeans-nvim',                     -- Jellybeans port to lua
        'folke/tokyonight.nvim',                         -- Tokyo theme
        'lunarvim/darkplus.nvim',                        -- Lunar theme
        'NvChad/nvim-colorizer.lua',                     -- Color highlighter

        -- tags
        'preservim/tagbar',                              -- Tags browser
        'ludovicchabant/vim-gutentags',                  -- Tags management

        -- telescope
        'nvim-telescope/telescope.nvim',                 -- Fuzzy finder
        'ahmedkhalf/project.nvim',                       -- Project jumper
        'nvim-treesitter/nvim-treesitter',               -- Syntax highlightings

        -- lsp
        'williamboman/mason.nvim',                       -- Manage external editors
        'williamboman/mason-lspconfig.nvim',             -- Bridge mason with lspconfig
        'WhoIsSethDaniel/mason-tool-installer.nvim',     -- Install or upgrade 3rd party tools
        'neovim/nvim-lspconfig',                         -- Lsp configuration
        'jose-elias-alvarez/null-ls.nvim',               -- Diagnostic and code injection
        'onsails/lspkind-nvim',                          -- Add pictograms to builtin lsp
        'stevearc/aerial.nvim',                          -- Code outline and nav helper

        -- completion
        'hrsh7th/nvim-cmp',                              -- Nvim completion
        'hrsh7th/cmp-nvim-lsp',                          -- Lsp completion
        'hrsh7th/cmp-buffer',                            -- Buffer words
        'hrsh7th/cmp-path',                              -- Filesystem path
        'hrsh7th/cmp-cmdline',                           -- Nvim's commandline
        'hrsh7th/cmp-calc',                              -- Math calculation
        'hrsh7th/cmp-nvim-lua',                          -- Complete lua api
        'ray-x/lsp_signature.nvim',                      -- Signature completion

        -- dap
        'mfussenegger/nvim-dap',                         -- Debug adapter protocol
        'rcarriga/nvim-dap-ui',                          -- Dap ui
        'theHamsta/nvim-dap-virtual-text',               -- Virtual text support
        -- 'ravenxrz/DAPInstall.nvim',                   -- Dap installer

        -- git
        'lewis6991/gitsigns.nvim',                       -- Show modified lines for VCS files
        'tpope/vim-fugitive',                            -- Github Wrapper
        'rhysd/git-messenger.vim',                       -- Show git hidden messages

        -- utils
        'lewis6991/impatient.nvim',                      -- Speedup startup time
        'kyazdani42/nvim-tree.lua',                      -- File explorer
        'folke/which-key.nvim',                          -- Key binding completion
        'akinsho/toggleterm.nvim',                       -- Toggle terminal
        'numToStr/Comment.nvim',                         -- Comment helper
        'lukas-reineke/indent-blankline.nvim',           -- Show indentation when no tab
        'JoosepAlviste/nvim-ts-context-commentstring',   -- Comment string helper
        'Raimondi/delimitMate',                          -- Autoclose quotes, bracket etc...
        'roxma/vim-paste-easy',                          -- Automatic paste mode
        'terryma/vim-multiple-cursors',                  -- Multiple cursors
        'tpope/vim-eunuch',                              -- Common shell commands
        'troydm/zoomwintab.vim',                         -- Simple tab zoomer
        'yuttie/comfortable-motion.vim',                 -- Vim Scroller
        'mhinz/vim-rfc',                                 -- Download RFC

        -- snippets
        'L3MON4D3/LuaSnip',                              -- Luasnip users
        'rafamadriz/friendly-snippets',                  -- Snippets collection

        -- syntax
        'ray-x/go.nvim',                                 -- Golang neovim plugin
        'Joorem/vim-haproxy',                            -- HAProxy syntax
        'chr4/nginx.vim',                                -- Nginx syntax
        'saltstack/salt-vim',                            -- Saltstack syntax
        'glench/vim-jinja2-syntax',                      -- Jinja2 syntax
        'rodjek/vim-puppet',                             -- Puppet syntax

        -- import/override with your plugins to `lua/plugins/*.lua`
        --{ import = "plugins" },
    },

    -- lazy config
    defaults = {
        lazy = false,
        version = false,
    },
    install = {
        colorscheme = {
            "jellybeans-nvim",
            "tokyonight",
            "habamax"
        }
    },
    checker = {
        enabled = true
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- vim: ts=4 sts=4 sw=4 et
