--
-- Aerial Completion
--
-- https://github.com/stevearc/aerial.nvim

local aerial_ok, aerial = pcall(require, "aerial")
if not aerial_ok then
    return
end

aerial.setup({
    backends = { "treesitter", "lsp" },
    layout = {
        max_width = { 40, 0.2 },
        width = 40,
        min_width = 20,
        default_direction = "prefer_right",
        placement = "edge",
    },
    default_bindings = true,
    disable_max_lines = 10000,
    disable_max_size = 2000000, -- Default 2MB
    highlight_mode = "split_width",
    highlight_closest = true,
    highlight_on_hover = false,
    highlight_on_jump = 300,
    ignore = {
        unlisted_buffers = true,
        filetypes = {},
        buftypes = "special",
        wintypes = "special",
    },
    link_folds_to_tree = false,
    link_tree_to_folds = true,
    manage_folds = false,
    nerd_font = "auto",
    open_automatic = false,
    show_guides = true,
    float = {
        border = "rounded",
        relative = "cursor",
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
        override = function(conf)
            return conf
        end,
    },
    lsp = {
        diagnostics_trigger_update = true,
        update_when_errors = true,
        update_delay = 300,
    },
    treesitter = {
        update_delay = 300,
    },
})
