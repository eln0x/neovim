-- Neovim Linting
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    -- 🩺 Code linting
    -- https://github.com/mfussenegger/nvim-lint
    {
        "mfussenegger/nvim-lint",
        enabled = true,
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                ["_"] = { "codespell" },    -- Fallback: runs on filetypes without a specific linter
                ["*"] = { "typos" },        -- Global: runs on all filetypes
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            linters = {},
        },
        config = function(_, opts)
            local lint = require("lint")
            lint.linters_by_ft = opts.linters_by_ft

            for name, linter in pairs(opts.linters or {}) do
                lint.linters[name] = linter
            end

            vim.api.nvim_create_autocmd(opts.events, {
                callback = function()
                    if vim.bo.filetype == "alpha" then
                        return
                    end
                    lint.try_lint()
                end,
            })
        end,
    },

    -- INFO: LazyVim extra --

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
