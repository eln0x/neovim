-- Tools
-- stylua: ignore
if true then return {} end

return {
    -- Completion
    'ray-x/lsp_signature.nvim',                      -- Signature completion

    -- Language server protocol
    'williamboman/mason.nvim',                       -- Manage external editors
    'williamboman/mason-lspconfig.nvim',             -- Bridge mason with lspconfig
    'WhoIsSethDaniel/mason-tool-installer.nvim',     -- Install or upgrade 3rd party tools
    'neovim/nvim-lspconfig',                         -- Lsp configuration
    'jose-elias-alvarez/null-ls.nvim',               -- Diagnostic and code injection

    -- Dap
    'mfussenegger/nvim-dap',                         -- Debug adapter protocol
    'rcarriga/nvim-dap-ui',                          -- Dap ui
    'theHamsta/nvim-dap-virtual-text',               -- Virtual text support
    -- 'ravenxrz/DAPInstall.nvim',                   -- Dap installer

    -- Git
    'tpope/vim-fugitive',                            -- Github Wrapper
    'rhysd/git-messenger.vim',                       -- Show git hidden messages

    -- Tools
    'mfussenegger/nvim-lint',                        -- Nvim linter
    'Raimondi/delimitMate',                          -- Autoclose quotes, bracket etc...
    'roxma/vim-paste-easy',                          -- Automatic paste mode
    'terryma/vim-multiple-cursors',                  -- Multiple cursors
    'tpope/vim-eunuch',                              -- Common shell commands
    'troydm/zoomwintab.vim',                         -- Simple tab zoomer
    'mhinz/vim-rfc',                                 -- Download RFC

    -- Syntax
    'Joorem/vim-haproxy',                            -- HAProxy syntax
    'chr4/nginx.vim',                                -- Nginx syntax
    'saltstack/salt-vim',                            -- Saltstack syntax
    'glench/vim-jinja2-syntax',                      -- Jinja2 syntax
    'rodjek/vim-puppet',                             -- Puppet syntax
}
