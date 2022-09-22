--
-- Null ls configuration
--
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ok, null = pcall(require, "null-ls")
if not null_ok then
    return
end

local format = null.builtins.formatting
local diag = null.builtins.diagnostics

null.setup({
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    notify_format = "[null-ls] %s",
    update_in_insert = false,
    sources = {
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.completion.spell,
        format.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
        format.shfmt.with({
            extra_args = { "--indent", 4 },
        }),
    },
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            if vim.fn.has("nvim-0.8") == 1 then
                vim.cmd("nnoremap <silent><buffer> gf :lua vim.lsp.buf.format({async = true})<CR>")
            else
                vim.cmd("nnoremap <silent><buffer> gf :lua vim.lsp.buf.formatting()<CR>")
            end
        end

        if client.server_capabilities.documentRangeFormattingProvider then
            if vim.fn.has("nvim-0.8") == 1 then
                vim.cmd("nnoremap <silent><buffer> gF :lua vim.lsp.buf.range_format({async = true})<CR>")
            else
                vim.cmd("nnoremap <silent><buffer> gF :lua vim.lsp.buf.range_formatting()<CR>")
            end
        end
    end,
})
