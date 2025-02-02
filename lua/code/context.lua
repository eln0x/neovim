--
-- Treesitter context configuration
--
-- https://github.com/nvim-treesitter/nvim-treesitter-context

local ctx_ok, context = pcall(require, "treesitter-context")
if not ctx_ok then
    return
end

-- default setup
context.setup({
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
})

-- vim: ts=4 sts=4 sw=4 et
