--
-- Impatient configuration
--
-- https://github.com/lewis6991/impatient.nvim

local impatient_ok, impatient = pcall(require, "impatient")
if not impatient_ok then
    return
end

impatient.enable_profile()
