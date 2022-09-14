--
-- NeoVim colorscheme
--
-- https://github.com/nanotech/jellybeans.vim

local colorscheme = "jellybeans"    -- Preferred color scheme

local scheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not scheme_ok then
    return
end

-- options
local opt = vim.opt
opt.termguicolors = true            -- Set term gui colors
opt.background = "dark"             -- Select dark background

-- telescope
vim.cmd([[
    hi TelescopePromptBorder guifg=#f2594b guibg=#161616
    hi TelescopePromptNormal  guifg=#f2594b guibg=#161616
    hi TelescopePromptTitle  guifg=#f2594b guibg=#161616
    hi TelescopePromptPrefix  guifg=#f2594b guibg=#161616
    hi TelescopePromptCounter  guifg=#f2594b guibg=#161616
    hi TelescopePreviewTitle  guifg=#8bba7f guibg=#161616
    hi TelescopePreviewBorder guifg=#8bba7f guibg=#161616
    hi TelescopeResultsTitle  guifg=#8bba7f guibg=#161616
    hi TelescopeResultsBorder guifg=#8bba7f guibg=#161616
    hi TelescopeMatching guifg=#e9b143 guibg=#161616
    hi TelescopeSelection guifg=#ffffff guibg=#32302f
]])

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
