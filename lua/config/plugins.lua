--
-- Lazy Bootstrap
--
-- https://github.com/folke/lazy.nvim.git

local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
    spec = {
        -- add LazyVim don't import its plugins
        { "LazyVim/LazyVim" },

        -- import plugins to `lua/plugins/*.lua`
        { import = "plugins" },
    },

    -- lazy config
    defaults = {
        lazy = false,
        version = false,
    },
    install = {
        colorscheme = { "jellybeans-nvim" }
    },
    checker = {
        enabled = true
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- vim: ts=4 sts=4 sw=4 et
