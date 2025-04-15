-- Neovim Linting
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- An asynchronous linter
    -- https://github.com/mfussenegger/nvim-lint
    {
        "mfussenegger/nvim-lint",
        enabled = true,
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                lua = { "luacheck" },       -- Lua files: use Luacheck
                sh = { "shellcheck" },      -- Shell scripts: use ShellCheck
                bash = { "shellcheck" },    -- Bash files: use ShellCheck
                ["_"] = { "codespell" },    -- Fallback: runs on filetypes without a specific linter
                ["*"] = { "typos" },        -- Global: runs on all filetypes
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            linters = {
            },
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
