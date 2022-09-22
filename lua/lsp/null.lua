--
-- Null ls configuration
--
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ok, null = pcall(require, "null-ls")
if not null_ok then
    return
end

local frmt = null.builtins.formatting
local diag = null.builtins.diagnostics
local comp = null.builtins.completion

null.setup({
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    notify_format = "[null-ls] %s",
    update_in_insert = false,
    sources = {
        -- formatter
        frmt.shfmt.with({
            extra_args = { "--indent", 4 },
        }),
        frmt.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
        frmt.prettier,

        -- linter
        diag.flake8,
        diag.shellcheck,

        -- completion
        comp.spell,
    },
})
