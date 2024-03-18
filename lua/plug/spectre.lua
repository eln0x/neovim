--
-- Nvim spectre configuration
--
-- https://github.com/nvim-pack/nvim-spectre

local spectre_ok, spectre = pcall(require, "spectre")
if not spectre_ok then
    return
end

-- default setup
spectre.setup({
    color_devicons = true,
    open_cmd = 'vnew',
    live_update = false, -- auto execute search again when you write to any file in vim
    lnum_for_results = true, -- show line number for search/replace results
    line_sep_start = '┌-----------------------------------------',
    result_padding = '¦  ',
    line_sep       = '└-----------------------------------------',
    highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete"
    },
})
