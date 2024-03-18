--
-- Persistence configuration
--
-- https://github.com/folke/persistence.nvim

local persist_ok, persist = pcall(require, "persistence")
if not persist_ok then
    return
end

persist.setup {
    dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/session/"),
    options = { "buffers", "curdir", "tabpages", "winsize" },
}
