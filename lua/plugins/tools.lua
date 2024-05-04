-- Tools
-- stylua: ignore
--if true then return {} end

return {
    -- Snippets
    -- Luasnip users
    -- https://github.com/L3MON4D3/LuaSnip
    {
        'L3MON4D3/LuaSnip',
        build = "make install_jsregexp"
    },
    'saadparwaiz1/cmp_luasnip',                     -- Luasnip completion source
    'rafamadriz/friendly-snippets',                 -- Snippets collection

    -- Completion
    'hrsh7th/nvim-cmp',                              -- Nvim completion
    'hrsh7th/cmp-nvim-lsp',                          -- Lsp completion
    'hrsh7th/cmp-buffer',                            -- Buffer words
    'hrsh7th/cmp-path',                              -- Filesystem path
    'hrsh7th/cmp-cmdline',                           -- Nvim's commandline
    'hrsh7th/cmp-calc',                              -- Math calculation
    'hrsh7th/cmp-nvim-lua',                          -- Complete lua api
    'ray-x/lsp_signature.nvim',                      -- Signature completion

    -- Language server protocol
    'williamboman/mason.nvim',                       -- Manage external editors
    'williamboman/mason-lspconfig.nvim',             -- Bridge mason with lspconfig
    'WhoIsSethDaniel/mason-tool-installer.nvim',     -- Install or upgrade 3rd party tools
    'neovim/nvim-lspconfig',                         -- Lsp configuration
    'jose-elias-alvarez/null-ls.nvim',               -- Diagnostic and code injection
    'onsails/lspkind-nvim',                          -- Add pictograms to builtin lsp
    'stevearc/aerial.nvim',                          -- Code outline and nav helper

    -- Dap
    'mfussenegger/nvim-dap',                         -- Debug adapter protocol
    'rcarriga/nvim-dap-ui',                          -- Dap ui
    'theHamsta/nvim-dap-virtual-text',               -- Virtual text support
    -- 'ravenxrz/DAPInstall.nvim',                   -- Dap installer

    -- Tags
    'preservim/tagbar',                              -- Tags browser
    'ludovicchabant/vim-gutentags',                  -- Tags management

    -- Git
    'tpope/vim-fugitive',                            -- Github Wrapper
    'rhysd/git-messenger.vim',                       -- Show git hidden messages

    -- Tools
    'mfussenegger/nvim-lint',                        -- Nvim linter
    'lewis6991/impatient.nvim',                      -- Speedup startup time
    'akinsho/toggleterm.nvim',                       -- Toggle terminal
    'numToStr/Comment.nvim',                         -- Comment helper
    'JoosepAlviste/nvim-ts-context-commentstring',   -- Comment string helper
    'Raimondi/delimitMate',                          -- Autoclose quotes, bracket etc...
    'roxma/vim-paste-easy',                          -- Automatic paste mode
    'terryma/vim-multiple-cursors',                  -- Multiple cursors
    'tpope/vim-eunuch',                              -- Common shell commands
    'troydm/zoomwintab.vim',                         -- Simple tab zoomer
    'mhinz/vim-rfc',                                 -- Download RFC
    'm4xshen/hardtime.nvim',                         -- Best practice

    -- Syntax
    'ray-x/go.nvim',                                 -- Golang neovim plugin
    'Joorem/vim-haproxy',                            -- HAProxy syntax
    'chr4/nginx.vim',                                -- Nginx syntax
    'saltstack/salt-vim',                            -- Saltstack syntax
    'glench/vim-jinja2-syntax',                      -- Jinja2 syntax
    'rodjek/vim-puppet',                             -- Puppet syntax
}
