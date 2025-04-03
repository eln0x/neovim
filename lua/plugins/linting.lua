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
                fish = { "fish" },
                -- ['*'] = { 'global linter' },
                -- ['_'] = { 'fallback linter' },
                -- ["*"] = { "typos" },
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            linters = {
                -- -- Example of using selene only when a selene.toml file is present
                -- selene = {
                --   -- `condition` is another LazyVim extension that allows you to
                --   -- dynamically enable/disable linters based on the context.
                --   condition = function(ctx)
                --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
                --   end,
                -- },
            },
        },
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
