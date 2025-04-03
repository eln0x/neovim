-- Coding
-- stylua: ignore
--if true then return {} end

return {
    -- Auto completion
    -- https://github.com/hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',                          -- Lsp completion
            'hrsh7th/cmp-buffer',                            -- Buffer words
            'hrsh7th/cmp-path',                              -- Filesystem path
            'hrsh7th/cmp-nvim-lua',                          -- Complete lua api
        },

        -- Not all LSP servers add brackets when completing a function.
        -- To better deal with this, LazyVim adds a custom option to cmp,
        -- that you can configure. For example:
        --
        -- ```lua
        -- opts = {
        --   auto_brackets = { "python" }
        -- }
        -- ```
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            local auto_select = true
            return {
                auto_brackets = {}, -- configure any filetype to auto add brackets
                completion = {
                    completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
                    keyword_length = 1,
                },
                matching = {
                    disallow_fuzzy_matching = false,
                },
                window = {
                    completion = {
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                        border = "rounded",
                        col_offset = -3,
                        side_padding = 0,
                    },
                    documentation = {
                        winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                        border = "rounded",
                    },
                },
                preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
                    ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
                    ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                    ["<tab>"] = function(fallback)
                        return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
                    end,
                }),
                sources = cmp.config.sources(
                    {
                        { name = "lazydev" },
                        { name = "nvim_lsp" },
                        { name = "nvim_lua" },
                        { name = 'treesitter' },
                        { name = "path" },
                    }, {
                        { name = 'buffer' },
                    }, {
                        { name = 'nvim_lsp_signature_help' },
                    }),
                formatting = {
                    format = function(entry, item)
                        local icons = LazyVim.config.icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        local widths = {
                            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                        }

                        for key, width in pairs(widths) do
                            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                            end
                        end

                        return item
                    end,
                },
                experimental = {
                    -- only show ghost text when we show ai completions
                    ghost_text = vim.g.ai_cmp and {
                        hl_group = "CmpGhostText",
                    } or false,
                },
                sorting = defaults.sorting,
            }
        end,
        main = "lazyvim.util.cmp",
    },

    -- Luasnip
    -- https://github.com/L3MON4D3/LuaSnip
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        build = (not LazyVim.is_win())
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
                end,
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },

    -- add snippet_forward action
    {
        "L3MON4D3/LuaSnip",
        opts = function()
            LazyVim.cmp.actions.snippet_forward = function()
                if require("luasnip").jumpable(1) then
                    vim.schedule(function()
                        require("luasnip").jump(1)
                    end)
                    return true
                end
            end
            LazyVim.cmp.actions.snippet_stop = function()
                if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
                    require("luasnip").unlink_current()
                    return true
                end
            end
        end,
    },
    -- nvim-cmp integration
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = { "saadparwaiz1/cmp_luasnip" },
        opts = function(_, opts)
            opts.snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            }
            table.insert(opts.sources, { name = "luasnip" })
        end,
        -- stylua: ignore
        keys = {
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
}

-- vim: ts=4 sts=4 sw=4 et
