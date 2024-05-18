-- Treesitter
-- stylua: ignore
--if true then return {} end

return {
    -- Syntax highlightings
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
        --keys = {
        --    { "<c-space>", desc = "Increment Selection" },
        --    { "<bs>", desc = "Decrement Selection", mode = "x" },
        --},
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = { enable = true, disable = {} },
            indent = { enable = true, disable = {} },
            sync_install = false,
            auto_install = false,
            ensure_installed = {
                "bash",
                "c",
                "comment",
                "dockerfile",
                "go",
                "gomod",
                "json",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "perl",
                "python",
                "regex",
                "rust",
                "sql",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
        },
        --incremental_selection = {
        --    enable = true,
        --    keymaps = {
        --        init_selection = "<C-space>",
        --        node_incremental = "<C-space>",
        --        scope_incremental = false,
        --        node_decremental = "<bs>",
        --    },
        --},
        --textobjects = {
        --    move = {
        --        enable = true,
        --        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        --        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        --        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        --        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        --    },
        --},
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- Treesitter for textobjects
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,
    },

    -- Treesitter for context
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        --keys = {
        --    {
        --        "<leader>ut",
        --        function()
        --            local tsc = require("treesitter-context")
        --            tsc.toggle()
        --            if LazyVim.inject.get_upvalue(tsc.toggle, "enabled") then
        --                LazyVim.info("Enabled Treesitter Context", { title = "Option" })
        --            else
        --                LazyVim.warn("Disabled Treesitter Context", { title = "Option" })
        --            end
        --        end,
        --        desc = "Toggle Treesitter Context",
        --    },
        --},
        enabled = true,
        opts = {
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',
            separator = nil,
            zindex = 20,
            on_attach = nil,
        },
    },

}

-- vim: ts=4 sts=4 sw=4 et
