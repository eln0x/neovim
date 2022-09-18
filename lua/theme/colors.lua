--
-- NeoVim colorscheme
--
-- https://github.com/nanotech/jellybeans.vim

local colorscheme = "jellybeans-nvim"    -- Preferred color scheme

local scheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not scheme_ok then
    return
end

-- options
local opt = vim.opt
opt.termguicolors = true            -- Set term gui colors
opt.background = "dark"             -- Select dark background

-- completion
vim.cmd([[
    hi! CmpPmenu guibg=NONE
    hi! CmpPmenuBorder guibg=NONE guifg=#30404f
    hi! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    hi! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    hi! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
    hi! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    hi! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
    hi! CmpItemKindText guibg=NONE guifg=#9CDCFE
    hi! CmpItemKindFunction guibg=NONE guifg=#C586C0
    hi! CmpItemKindMethod guibg=NONE guifg=#C586C0
    hi! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    hi! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
    hi! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
