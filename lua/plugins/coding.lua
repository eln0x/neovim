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
            'hrsh7th/cmp-cmdline',                           -- Nvim's commandline
            'hrsh7th/cmp-calc',                              -- Math calculation
            'hrsh7th/cmp-nvim-lua',                          -- Complete lua api
            'onsails/lspkind-nvim',                          -- Add pictograms to builtin lsp
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
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
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
                    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = auto_select }),
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expandable() then
                                luasnip.expand()
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { "i", "s" }
                    ),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }
                    ),
                }),
                sources = cmp.config.sources(
                    {
                        { name = "lazydev" },
                        { name = "nvim_lsp" },
                        { name = "nvim_lua" },
                        { name = "treesitter" },
                        { name = "path" },
                    }, {
                        { name = 'buffer' },
                    }, {
                        { name = 'nvim_lsp_signature_help' },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, item)
                        local kind = lspkind.cmp_format(
                            {
                                preset = 'default',
                                mode = 'symbol_text',
                                maxwidth = 50,
                                menu = ({
                                    buffer = "[Buff]",
                                    path = "[Path]",
                                    look = "[Look]",
                                    nvim_lsp = "[LSP]",
                                    nvim_lua = "[Lua]",
                                    luasnip = "[Snip]",
                                    latex_symbols = "[Latx]",
                                    treesitter = "[Tree]",
                                    spell = "[Spel]",
                                    zsh = "[Zsh]",
                                    calc = "[Calc]",
                                    nvim_lsp_signature_help = "[Sig]",
                                    cmdline = "[Cmd]",
                                }),
                            })(entry, item)
                        local icons = LazyVim.config.icons.kinds

                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                experimental = {
                    ghost_text = true,
                },
                sorting = defaults.sorting,
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' },
                }, {
                        { name = 'buffer' },
                    })
            })

            -- Use buffer source for `/`
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'cmdline' },
                })
            })
        end,
    },

    -- Luasnip
    -- https://github.com/L3MON4D3/LuaSnip
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        build = "make install_jsregexp",
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

    -- Golang
    -- https://github.com/ray-x/go.nvim
    {
        'ray-x/go.nvim',
        opts = {},
        config = function(_, opts)
            require("go").setup()

            -- Run gofmt + goimport on save
            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require('go.format').goimport()
                end,
                group = format_sync_grp,
            })
        end,
    },
}

-- vim: ts=4 sts=4 sw=4 et
