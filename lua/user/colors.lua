--
-- NeoVim colorscheme
--
-- https://github.com/nanotech/jellybeans.vim

local opt = vim.opt
local colorscheme = "jellybeans"    -- Preferred color scheme

local scheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not scheme_ok then
    return
end

opt.termguicolors = true            -- Set term gui colors
opt.background = "dark"             -- Select dark background
