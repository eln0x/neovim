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

null.setup({
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    notify_format = "[null-ls] %s",
    update_in_insert = false,
    sources = {
        -- formatter
        frmt.shfmt.with({
            filetypes = { "sh" },
            extra_args = { "--indent", 4 },
        }),

        frmt.stylua.with({
            filetypes = { "lua" },
            extra_args = { "--indent-type", "Spaces" },
        }),

        frmt.prettier.with({
            filetypes = { "json", "yaml", "markdown" },
        }),

        -- linter
        diag.flake8.with({
            filetypes = { "python" },
        }),

        diag.shellcheck.with({
            filetypes = { "sh" },
            diagnostic_config = { underline = false },
        }),
    },
})
