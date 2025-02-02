--
-- LSP configuration
--
-- https://github.com/neovim/nvim-lspconfig

local vim = vim

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

-- signature extension
local signature_ok, signature = pcall(require, 'lsp_signature')

-- notify extension
local notify_ok, notify = pcall(require, 'notify')

-- define capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then
    capabilities = cmp.default_capabilities(capabilities)
end

-- define lsp defaults
local LSP_DEFAULTS = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Info keymaps
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "?", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, bufopts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)

        -- Workspaces keymaps
        vim.keymap.set("n", "wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "wl", vim.lsp.buf.list_workspace_folders, bufopts)

        -- Action keymaps
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('x', 'ga', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)

        -- Diagnostics keymaps
        vim.keymap.set('n', 'do', vim.diagnostic.open_float, bufopts)
        vim.keymap.set('n', 'dp', vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set('n', 'dn', vim.diagnostic.goto_next, bufopts)
        vim.keymap.set('n', 'dl', "<cmd>Telescope diagnostics<cr>", bufopts)

        -- Format keymaps
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd("nnoremap <silent><buffer> gf :lua vim.lsp.buf.formatting()<CR>")
        end

        if client.server_capabilities.documentRangeFormattingProvider then
            vim.cmd("nnoremap <silent><buffer> gF :lua vim.lsp.buf.range_formatting()<CR>")
        end

        -- Highlight symbols
        if client.server_capabilities.documentHighlightProvider then
            vim.cmd [[
                hi! LspReferenceRead cterm=bold ctermbg=000 guibg=#282828
                hi! LspReferenceText cterm=bold ctermbg=000 guibg=#282828
                hi! LspReferenceWrite cterm=bold ctermbg=000 guibg=#282828
            ]]
            vim.api.nvim_create_augroup('lsp_document_highlight', {})
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = 'lsp_document_highlight',
                buffer = 0,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                group = 'lsp_document_highlight',
                buffer = 0,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Signature setup
        if signature_ok then
            signature.on_attach({
                bind = true,
                handlers_opts = {
                    border = "rounded"
                }
            }, bufnr)
        end

        -- Notify setup
        if notify_ok then
            notify(
                string.format("%s", client.name),
                "info",
                { title = "[lsp] active" },
                true
            )
        end
    end
}

-- Merge lsp defaults with global configuration
lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    LSP_DEFAULTS
)

-- Hover customization
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

-- Signature help customization
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- Diagnostic customization
local sign = function(opts)
    vim.fn.sign_define(
        opts.name, { texthl = opts.name, text = opts.text, numhl = '' }
    )
end
sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = {
        source = 'always',
        prefix = '●', -- Could be '■', '▎', 'x'
    },
    float = {
        border = 'rounded',
        source = 'always',
    },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        signs = true,
        underline = false,
        severity_sort = true,
    }
)

-- vim: ts=4 sts=4 sw=4 et
