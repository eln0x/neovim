--
-- NeoVim colorscheme
--
-- https://github.com/nanotech/jellybeans.vim

local colorscheme = "jellybeans-nvim"    -- Preferred color scheme

local scheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not scheme_ok then
    return
    end

local clz_ok, clz = pcall(require, "colorizer")
if clz_ok then
    clz.setup()
end

-- options
local opt = vim.opt
opt.termguicolors = true            -- Set term gui colors
opt.background = "dark"             -- Select dark background

-- vim: ts=4 sts=4 sw=4 et
