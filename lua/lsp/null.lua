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

null.setup {
    debug = false,
    sources = {
        format.prettier.with {
            extra_filetypes = { "toml" },
            extra_args = {
                "--no-semi",
                "--single-quote",
                "--jsx-single-quote"
            },
        },
        format.black.with { extra_args = { "--fast" } },
        format.stylua,
        format.google_java_format,
        diag.flake8,
    },
}
