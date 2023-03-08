--
-- Golang configuration
--
-- https://github.com/ray-x/go.nvim

local golang_ok, golang = pcall(require, "go")
if not golang_ok then
    return
end

golang.setup()

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
