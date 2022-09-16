--
-- LSP configuration
--
-- https://github.com/neovim/nvim-lspconfig

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp = pcall(require, 'cmp_nvim_lsp')
if ok then
    capabilities = cmp.update_capabilities(capabilities)
end

local LSP_DEFAULTS = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Keymaps bindings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "?", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    end
}
lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    LSP_DEFAULTS
)

--
-- Mason configuration
--
-- https://github.com/williamboman/mason.nvim

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

local MASON_DEFAULTS = {
    ui = {
        check_outdated_packages_on_open = true,
        border = "none",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
    max_concurrent_installers = 4,
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
}
mason.setup(MASON_DEFAULTS)

--
-- Mason Lsp configuration
--
-- https://github.com/williamboman/mason-lspconfig.nvim

local lspmason_ok, lspmason = pcall(require, "mason-lspconfig")
if not lspmason_ok then
    return
end

local LSPMASON_DEFAULTS = {
    ensure_installed = {
        "ansible-language-server",
        "bash-language-server",
        "clangd",
        "dockerfile-language-server",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "perlnavigator",
        "puppet-editor-services",
        "python-lsp-server",
        "rust-analyzer",
        "salt-lsp",
        "terraform-ls",
        "texlab",
        "typescript-language-server",
        "vim-language-server",
        "yaml-language-server",
    },
    automatic_installation = true,
}
lspmason.setup(LSPMASON_DEFAULTS)

lspmason.setup_handlers({
    function (server_name)
        lspconfig[server_name].setup{}
    end,
    ["sumneko_lua"] = function ()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
})
