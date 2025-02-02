--
-- Nvim-lint configuration
--
-- https://github.com/mfussenegger/nvim-lint

local lint_ok, lint = pcall(require, "lint")
if not lint_ok then
    return
end

-- vim: ts=4 sts=4 sw=4 et
