--
-- Neovim Completion
--
-- https://github.com/hrsh7th/nvim-cmp

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
    return
end

local snip_ok, luasnip = pcall(require, "luasnip")
if not snip_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menuone,noselect"

local select_opts = {behavior = cmp.SelectBehavior.Select}

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
    completion = {
        keyword_length = 1,
    },
    matching = {
        disallow_fuzzy_matching = false,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
            border = "rounded",
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
        { name = 'vsnip' },
        { name = "nvim_lua" },
        { name = 'treesitter' },
    }, {
        { name = 'buffer' },
    }, {
        { name = 'nvim_lsp_signature_help' },
    }),
    formatting = {
        format = lspkind.cmp_format({
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
            before = function(_, vim_item)
                vim_item.abbr = ' ' .. vim_item.abbr
                vim_item.menu = (vim_item.menu or '') .. ' '
                return vim_item
            end
        })
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    experimental = {
        ghost_text = true,
    },
})

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

