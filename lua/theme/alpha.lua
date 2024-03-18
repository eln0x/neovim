--
-- Alpha configuration
--
-- https://github.com/goolord/alpha-nvim

local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
    return
end

local path_ok, path = pcall(require, "plenary.path")
if not path_ok then
    return
end

local fortune = require "alpha.fortune"
local dashboard = require "alpha.themes.dashboard"
local devicons = require "nvim-web-devicons"
local cdir = vim.fn.getcwd()

local function get_extension(fn)
    local match = fn:match("^.+(%..+)$")
    local ext = ""
    if match ~= nil then
        ext = match:sub(2)
    end
    return ext
end

local function icon(fn)
    local ext = get_extension(fn)
    return devicons.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn)
    short_fn = short_fn or fn
    local ico_txt
    local fb_hl = {}

    local ico, hl = icon(fn)
    local hl_option_type = type(devicons.highlight)
    if hl_option_type == "boolean" then
        if hl and devicons.highlight then
            table.insert(fb_hl, { hl, 0, 1 })
        end
    end
    if hl_option_type == "string" then
        table.insert(fb_hl, { devicons.highlight, 0, 1 })
    end
    ico_txt = ico .. "  "

    local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <cr>")
    local fn_start = short_fn:match(".*/")
    if fn_start ~= nil then
        table.insert(fb_hl, { "Type", #ico_txt - 2, #fn_start + #ico_txt - 2 })
    end
    file_button_el.opts.hl = fb_hl
    return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
    ignore = function(path, ext)
        return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
    end,
}

local function mru(start, cwd, items_number, opts)
    opts = opts or mru_opts
    items_number = items_number or 9

    local oldfiles = {}
    for _, v in pairs(vim.v.oldfiles) do
        if #oldfiles == items_number then
            break
        end
        local cwd_cond
        if not cwd then
            cwd_cond = true
        else
            cwd_cond = vim.startswith(v, cwd)
        end
        local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
        if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
        end
    end

    local special_shortcuts = {}
    local target_width = 35

    local tbl = {}
    for i, fn in ipairs(oldfiles) do
        local short_fn
        if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
        else
            short_fn = vim.fn.fnamemodify(fn, ":~")
        end

        if(#short_fn > target_width) then
            short_fn = path.new(short_fn):shorten(1, {-2, -1})
            if(#short_fn > target_width) then
                short_fn = path.new(short_fn):shorten(1, {-1})
            end
        end

        local shortcut = ""
        if i <= #special_shortcuts then
            shortcut = special_shortcuts[i]
        else
            shortcut = tostring(i + start - 1 - #special_shortcuts)
        end

        local file_button_el = file_button(fn, " " .. shortcut, short_fn)
        tbl[i] = file_button_el
    end

    return {
        type = "group",
        val = tbl,
        opts = {},
    }
end

local logo = {
    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀ ⠀         ⠀ ]],
    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀ ⠀⠀⠀⠀⠀         ⠀ ]],
    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀ ⠀⠀⠀⠀         ⠀ ]],
    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀ ⠀⠀⠀         ⠀ ]],
    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀ ⠀⠀         ⠀ ]],
    [[         ⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀         ⠀ ]],
    [[         ⠀⠀⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀         ⠀ ]],
    [[          ⠀⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄         ⠀ ]],
    [[         ⠀ ⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿         ⠀ ]],
    [[         ⠀ ⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸         ⠀ ]],
    [[         ⠀ ⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈         ⠀ ]],
    [[         ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀          ⠀ ]],
    [[         ⠀⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀           ]],
    [[         ⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀           ]],
    [[            .__                                    ]],
    [[            |  | _____  ___________.__.            ]],
    [[            |  | \__  \ \___   <   |  |            ]],
    [[            |  |__/ __ \_/    / \___  |            ]],
    [[            |____(____  /_____ \/ ____|            ]],
    [[                      \/      \/\/                 ]],
}

local section_header = {
    type = "text",
    val = logo,
    opts = {
        hl = "Operator",
        shrink_margin = false,
        position = "center",
    }
}

local section_mru = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Recent files",
            opts = {
                hl = "Constant",
                shrink_margin = false,
                position = "center",
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return { mru(1, cdir, 5) }
            end,
            opts = { shrink_margin = false },
        },
    }
}

local section_buttons = {
    type = "group",
    val = {
        { type = "text", val = "Quick links", opts = { hl = "Constant", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
        dashboard.button("p", " " .. " Find project", "<cmd> Telescope projects <cr>"),
        dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
        dashboard.button("m", " " .. " Find modified file", "<cmd> Telescope git_status <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("h", " " .. " Check health", "<cmd> checkhealth <cr>"),
        dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    },
    position = "center",
}

local section_footer = {
    type = "group",
    val = {
        {
            type = "text",
            val = fortune(),
            opts = { hl = "Constant", position = "center" }
        },
    }
}

local opts = {
    layout = {
        { type = "padding", val = 1 }, section_header,
        { type = "padding", val = 1 }, section_mru,
        { type = "padding", val = 1 }, section_buttons,
        section_footer,
    },
    opts = {
        margin = 5,
    },
}

alpha.setup(opts)
