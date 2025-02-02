--
-- Guihua configuration
--
-- https://github.com/ray-x/guihua.lua

local gui_ok, gui = pcall(require, "guihua.maps")
if not gui_ok then
    return
end

gui.setup({
    maps = {
        close_view = '<C-e>',
        send_qf = '<C-q>',
        save = '<C-s>',
        jump_to_list = '<C-w>k',
        jump_to_preview = '<C-w>j',
        prev = '<C-p>',
        next = '<C-n>',
        pageup = '<C-b>',
        pagedown = '<C-f>',
        confirm = '<C-o>',
        split = '<C-s>',
        vsplit = '<C-v>',
        tabnew = '<C-t>',
    }
})

-- vim: ts=4 sts=4 sw=4 et
