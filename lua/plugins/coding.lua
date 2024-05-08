---- Coding
---- stylua: ignore
----if true then return {} end
--
return {
    -- Auto completion
    -- https://github.com/hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        version = false,                                     -- last release is way too old
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

        opts = function()
            vim.opt.completeopt = "menuone,noselect"
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
            local defaults = require("cmp.config.default")()
            local select_opts = {behavior = cmp.SelectBehavior.Select}
            local check_backspace = function()
                local col = vim.fn.col(".") - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
            end
            return {
                completion = {
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
                mapping = cmp.mapping.preset.insert({
                    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
                        elseif check_backspace() then
                            fallback()
                        else
                            fallback()
                        end
                    end, {
                            "i",
                            "s",
                        }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {
                            "i",
                            "s",
                        }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = "nvim_lua" },
                    { name = 'treesitter' },
                }, {
                        { name = 'buffer' },
                    }, {
                        { name = 'nvim_lsp_signature_help' },
                    }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
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
                            })(entry, vim_item)
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
        build = "make install_jsregexp",
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            {
                "nvim-cmp",
                dependencies = {
                    "saadparwaiz1/cmp_luasnip",
                },
                opts = function(_, opts)
                    opts.snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body)
                        end,
                    }
                    table.insert(opts.sources, { name = "luasnip" })
                end,
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
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

    -- Comment string helper
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },

    -- Comment line
    -- https://github.com/numToStr/Comment.nvim
    {
        "numToStr/Comment.nvim",
        opts = {
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = {
                line = 'gcc',
                block = 'gbc',
            },
            opleader = {
                line = 'gcl',
                block = 'gcb',
            },
            extra = {
                above = 'gcp',
                below = 'gco',
                eol = 'gcA',
            },
            mappings = {
                basic = true,
                extra = true,
                extended = false,
            },
            pre_hook = function(ctx)
                local U = require "Comment.utils"

                local location = nil
                if ctx.ctype == U.ctype.block then
                    location = require("ts_context_commentstring.utils").get_cursor_location()
                elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                    location = require("ts_context_commentstring.utils").get_visual_start_location()
                end

                return require("ts_context_commentstring.internal").calculate_commentstring {
                    key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
                    location = location,
                }
            end,
            post_hook = nil,
        },
        lazy = false,
    },

}
