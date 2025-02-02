--
-- Mason tools configuration
--
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local install_ok, install = pcall(require, "mason-tool-installer")
if not install_ok then
    return
end

-- define wanted servers
local SERVERS = {
        -- language server protocol
        "ansible-language-server",
        "bash-language-server",
        "clangd",
        "dockerfile-language-server",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "perlnavigator",
        "python-lsp-server",
        "rust-analyzer",
        --"salt-lsp",
        "texlab",
        "vim-language-server",
        "yaml-language-server",
        "marksman",

        -- formatter
        "shfmt",
        "stylua",
        "black",
        "goimports",
        "prettier",

        -- linter
        "shellcheck",
        "selene",
        "flake8",
        "golangci-lint",
}

install.setup({
    ensure_installed = SERVERS,
    auto_update = false,
    run_on_start = true,
})

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
        border = "rounded",
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

local lspconf_ok, lspconf = pcall(require, "lspconfig")
if not lspconf_ok then
    return
end

lspmason.setup({
    ensure_installed = {},
    automatic_installation = true,
})

lspmason.setup_handlers({
    function(server_name)
        lspconf[server_name].setup {}
    end,
    ["lua_ls"] = function()
        lspconf.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    },
                }
            }
        }
    end,
    ["salt_ls"] = function()
        lspconf.salt_ls.setup {
            cmd = { "salt-lsp" }
        }
    end,
})

-- vim: ts=4 sts=4 sw=4 et
