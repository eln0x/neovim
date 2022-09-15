--
-- Nvim Tree configuration
--
-- https://github.com/kyazdani42/nvim-tree.lua

local nvtree_ok, nvtree = pcall(require, "nvim-tree")
if not nvtree_ok then
    return
end

-- disable netrw
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- setup
nvtree.setup({
    filters = {
        dotfiles = true,
        custom = {},
        exclude = {},
    },
    renderer = {
        group_empty = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        adaptive_size = false,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
})
