--
-- Trouble configuration
--
-- https://github.com/folke/trouble.nvim

local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
    return
end

-- default setup
trouble.setup()

-- vim: ts=4 sts=4 sw=4 et
