-- Neovim Treesitter
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim default --

    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<BS>", desc = "Decrement Selection", mode = "x" },
                { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
            },
        },
    },

    -- Syntax highlightings
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "LazyFile", "VeryLazy" },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        keys = {
            { "<c-space>", desc = "Increment Selection" },
            { "<bs>", desc = "Decrement Selection", mode = "x" },
        },
        opts_extend = { "ensure_installed" },
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "awk",
                "bash",
                "c",
                "comment",
                "diff",
                "dockerfile",
                "go",
                "gomod",
                "gowork",
                "gosum",
                "gotmpl",
                "helm",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "latex",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "perl",
                "printf",
                "puppet",
                "python",
                "regex",
                "rust",
                "sql",
                "terraform",
                "tmux",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
        },
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
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        enabled = true,
        config = function()
            -- If treesitter is already loaded, we need to run config again for textobjects
            if LazyVim.is_loaded("nvim-treesitter") then
                local opts = LazyVim.opts("nvim-treesitter")
                require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
            end

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

    -- Automatically add closing tags for HTML and JSX
    -- https://github.com/windwp/nvim-ts-autotag
    {
        "windwp/nvim-ts-autotag",
        event = "LazyFile",
        opts = {},
    },

    -- INFO: LazyVim extra --

    -- Show context of the current function
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "LazyFile",
        opts = function()
            local tsc = require("treesitter-context")
            Snacks.toggle({
                name = "Treesitter Context",
                get = tsc.enabled,
                set = function(state)
                    if state then
                        tsc.enable()
                    else
                        tsc.disable()
                    end
                end,
            }):map("<leader>ut")
            return { mode = "cursor", max_lines = 3 }
        end,
    },

    -- TEST: External plugins --
}

-- vim: ts=4 sts=4 sw=4 et
