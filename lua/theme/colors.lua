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

-- completion
vim.cmd([[
    hi! Pmenu                       guibg=#22252A   guifg=#C5CDD9
    hi! PmenuSel                    guibg=#282C34   guifg=NONE
    hi! CmpPmenu                    guibg=NONE
    hi! CmpPmenuSel                 guibg=#282C34   guifg=NONE
    hi! CmpPmenuBorder              guibg=NONE      guifg=#30404F
    hi! CmpItemAbbrDeprecated       guibg=NONE      guifg=#808080   gui=strikethrough
    hi! CmpItemAbbrMatch            guibg=NONE      guifg=#569CD6   gui=bold
    hi! CmpItemAbbrMatchFuzzy       guibg=NONE      guifg=#569CD6   gui=bold
]])

vim.cmd([[
    hi! Pmenu                       guibg=#22252A   guifg=#C5CDD9
    hi! PmenuSel                    guibg=#282C34   guifg=NONE
    hi! CmpPmenu                    guibg=NONE      guifg=#C5CDD9
    hi! CmpPmenuBorder              guibg=NONE      guifg=#C5CDD9
    hi! CmpPmenuSel                 guibg=#282C34   guifg=NONE
    hi! CmpItemAbbrDeprecated       guibg=NONE      guifg=#7E8294   gui=strikethrough
    hi! CmpItemAbbrMatch            guibg=NONE      guifg=#82AAFF   gui=bold
    hi! CmpItemAbbrMatchFuzzy       guibg=NONE      guifg=#82AAFF   gui=bold
]])

vim.cmd([[
    hi! CmpItemMenu                 guibg=NONE      guifg=#C792EA   gui=italic
    hi! CmpItemKindField            guibg=#B5585F   guifg=#EED8DA
    hi! CmpItemKindVariable         guibg=#7E8294   guifg=#C5CDD9
    hi! CmpItemKindInterface        guibg=#58B5A8   guifg=#D8EEEB
    hi! CmpItemKindText             guibg=#9FBD73   guifg=#C3E88D
    hi! CmpItemKindFunction         guibg=#A377BF   guifg=#EADFF0
    hi! CmpItemKindMethod           guibg=#6C8ED4   guifg=#DDE5F5
    hi! CmpItemKindKeyword          guibg=#9FBD73   guifg=#C3E88D
    hi! CmpItemKindProperty         guibg=#B5585F   guifg=#EED8DA
    hi! CmpItemKindUnit             guibg=#D4A959   guifg=#F5EBD9
    hi! CmpItemKindEvent            guibg=#B5585F   guifg=#EED8DA
    hi! CmpItemKindEnum             guibg=#9FBD73   guifg=#C3E88D
    hi! CmpItemKindConstant         guibg=#D4BB6C   guifg=#FFE082
    hi! CmpItemKindConstructor      guibg=#D4BB6C   guifg=#FFE082
    hi! CmpItemKindReference        guibg=#D4BB6C   guifg=#FFE082
    hi! CmpItemKindStruct           guibg=#A377BF   guifg=#EADFF0
    hi! CmpItemKindClass            guibg=#A377BF   guifg=#EADFF0
    hi! CmpItemKindModule           guibg=#A377BF   guifg=#EADFF0
    hi! CmpItemKindOperator         guibg=#A377BF   guifg=#EADFF0
    hi! CmpItemKindFile             guibg=#7E8294   guifg=#C5CDD9
    hi! CmpItemKindSnippet          guibg=#D4A959   guifg=#F5EBD9
    hi! CmpItemKindFolder           guibg=#D4A959   guifg=#F5EBD9
    hi! CmpItemKindValue            guibg=#6C8ED4   guifg=#DDE5F5
    hi! CmpItemKindEnumMember       guibg=#6C8ED4   guifg=#DDE5F5
    hi! CmpItemKindColor            guibg=#58B5A8   guifg=#D8EEEB
    hi! CmpItemKindTypeParameter    guibg=#58B5A8   guifg=#D8EEEB
]])

-- telescope
vim.cmd([[
    hi TelescopePromptBorder        guifg=#f2594b   guibg=#161616
    hi TelescopePromptNormal        guifg=#f2594b   guibg=#161616
    hi TelescopePromptTitle         guifg=#f2594b   guibg=#161616
    hi TelescopePromptPrefix        guifg=#f2594b   guibg=#161616
    hi TelescopePromptCounter       guifg=#f2594b   guibg=#161616
    hi TelescopePreviewTitle        guifg=#8bba7f   guibg=#161616
    hi TelescopePreviewBorder       guifg=#8bba7f   guibg=#161616
    hi TelescopeResultsTitle        guifg=#8bba7f   guibg=#161616
    hi TelescopeResultsBorder       guifg=#8bba7f   guibg=#161616
    hi TelescopeMatching            guifg=#e9b143   guibg=#161616
    hi TelescopeSelection           guifg=#ffffff   guibg=#32302f
]])
