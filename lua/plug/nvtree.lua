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
        root_folder_modifier = ":t",
        group_empty = true,
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
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
