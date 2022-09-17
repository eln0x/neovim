--
-- Which key configuration
--
-- https://github.com/folke/which-key.nvim

local key_ok, whichk = pcall(require, "whick-key")
if not key_ok then
    return
end

whichk.setup({
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
})
