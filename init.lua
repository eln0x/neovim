--
-- Neovim lua configuration
--

-- pynvim venv created by chezmoi when present
local venv_python = vim.fn.stdpath("data") .. "/venv/bin/python"
if vim.fn.executable(venv_python) == 1 then
    vim.g.python3_host_prog = venv_python
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

--- vim: ts=4 sts=4 sw=4 et
