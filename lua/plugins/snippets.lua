-- Snippets
-- stylua: ignore
--if true then return {} end

return {
    -- Luasnip users
    -- https://github.com/L3MON4D3/LuaSnip
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp"
    },
    -- Luasnip completion source
    {
        "saadparwaiz1/cmp_luasnip",
    },
    -- Snippets collection
    {
        "rafamadriz/friendly-snippets",
    },
}
