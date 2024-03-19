-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
--if true then return {} end

return {
    -- add jellybeans
    {
        "metalelf0/jellybeans-nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    -- configure LazyVim to load jellybeans
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "jellybeans-nvim",
        },
    },
}
