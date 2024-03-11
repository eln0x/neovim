--
-- Nvim-lint configuration
--
-- https://github.com/mfussenegger/nvim-lint

local lint_ok, lint = pcall(require, "lint")
if not lint_ok then
    return
end

-- default setup
