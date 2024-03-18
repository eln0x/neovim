--
-- Hardtime configuration
--
-- https://github.com/m4xshen/hardtime.nvim

local hard_ok, hard = pcall(require, "hardtime")
if not hard_ok then
    return
end

-- default setup
hard.setup({
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
    disabled_keys = {
        ["<Up>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
        ["<Down>"] = {},
    },
})
