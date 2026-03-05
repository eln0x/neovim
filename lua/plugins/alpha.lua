-- Neovim Alpha
-- stylua: ignore
--if true then return {} end

return {

    -- INFO: LazyVim extra --

    -- 🚀 Startup screen/dashboard
    -- https://github.com/goolord/alpha-nvim
    {
        'goolord/alpha-nvim',
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local devicons  = require("nvim-web-devicons")
            local cdir      = vim.fn.getcwd()
            local path      = require("plenary.path")

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
                ignore = function(_path, ext)
                    return (string.find(_path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
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

                    if #short_fn > target_width then
                        short_fn = path.new(short_fn):shorten(1, { -2, -1 })
                        if #short_fn > target_width then
                            short_fn = path.new(short_fn):shorten(1, { -1 })
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

            local recents = {
                type = "group",
                val = {
                    {
                        type = "text",
                        val = " Recent files ",
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
                },
            }

            local function get_config_git_branch()
                local config_path = vim.fn.stdpath("config")
                local branch = vim.fn.system("git -C " .. config_path .. " rev-parse --abbrev-ref HEAD")
                branch = branch:gsub("%s+$", "")
                if branch == "" then return nil end
                return branch
            end
            local function get_config_git_status()
                local config_path = vim.fn.stdpath("config")
                local status = vim.fn.system("git -C " .. config_path .. " status --porcelain | wc -l")
                status = tonumber(status) or 0
                return status
            end
            local function get_config_git_last_commit()
                local config_path = vim.fn.stdpath("config")
                local commit = vim.fn.system("git -C " .. config_path .. " log -1 --pretty=format:'%h'")
                commit = commit:gsub("\n", "")
                return commit ~= "" and commit or nil
            end
            local function get_config_git_last_author()
                local config_path = vim.fn.stdpath("config")
                local author = vim.fn.system("git -C " .. config_path .. " log -1 --pretty=format:'%an, %ar'")
                author = author:gsub("\n", "")
                local name, time = author:match("^([^,]+),%s*(.+)$")
                if name and time then
                    -- Normalize time: e.g., "7 hours ago" -> "7 h ago"
                    time = time:gsub("([0-9]+) years?", "%1 y")
                        :gsub("([0-9]+) months?", "%1 mo")
                        :gsub("([0-9]+) weeks?", "%1 w")
                        :gsub("([0-9]+) days?", "%1 d")
                        :gsub("([0-9]+) hours?", "%1 h")
                        :gsub("([0-9]+) minutes?", "%1 m")
                        :gsub("([0-9]+) seconds?", "%1 s")
                    return string.format("%s, %s", name, time)
                end
                return author ~= "" and author or nil
            end

            local function header()
                local header_text = {
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
                }

                -- Prepare git info
                local branch  = get_config_git_branch()   or ""
                local commit  = get_config_git_last_commit() or ""
                local author  = get_config_git_last_author() or ""
                local changes = get_config_git_status()   or 0

                -- Add a blank line after ASCII art
                table.insert(header_text, "")

                -- Truncate/pad fields for alignment
                branch  = string.format("%-8s", branch:sub(1, 8))
                commit  = string.format("%-8s", commit:sub(1, 8))
                changes = string.format("%-3d", changes)

                -- Compose left and right parts
                local left = string.format("  %s  %s   %s", branch, commit, changes)
                local total_width = 59
                local right = string.format("%" .. (total_width - #left) .. "s", " " .. author)
                local line = left .. right

                -- Append git info line
                if branch:match("%S") then
                    table.insert(header_text, line)
                end
                return {
                    type = "text",
                    val = header_text,
                    opts = {
                        hl = "Operator",
                        shrink_margin = false,
                        position = "center",
                    },
                }
            end

            local function footer()
                local fortune   = require("alpha.fortune")
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                local footer_text = fortune()

                table.insert(footer_text, "")
                table.insert(footer_text, "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms")

                return {
                    type = "group",
                    val = {
                        {
                            type = "text",
                            val = footer_text,
                            opts = { hl = "Constant", position = "center" },
                        },
                    },
                }
            end

            local buttons = {
                type = "group",
                val = {
                    { type = "text", val = " Quick links ", opts = { hl = "Constant", position = "center" } },
                    { type = "padding", val = 1 },
                    dashboard.button("n", "  New file", "<cmd> ene <BAR> startinsert <cr>"),
                    dashboard.button("f", "  Find file", "<cmd> lua Snacks.picker.files() <cr>"),
                    dashboard.button("p", "  Find project", "<cmd> lua Snacks.picker.projects() <cr>"),
                    dashboard.button("g", "  Grep text", "<cmd> lua Snacks.picker.grep() <cr>"),
                    dashboard.button("m", "  Git Files", "<cmd> lua Snacks.picker.git_files() <cr>"),
                    dashboard.button("b", "  Browse Repo", "<cmd> lua Snacks.gitbrowse() <cr>"),
                    dashboard.button("c", "  Config", "<cmd> lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) <cr>"),
                    dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
                    dashboard.button("u", "󱐥  Sync plugins", "<cmd>Lazy sync<CR>"),
                    dashboard.button("x", "  Lazy Extras", "<cmd> LazyExtras <cr>"),
                    dashboard.button("s", "  Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                    dashboard.button("h", "  Check health", "<cmd> checkhealth <cr>"),
                    dashboard.button("q", "  Quit", "<cmd> qa <cr>"),
                },
                position = "center",
            }
            dashboard.opts = {
                layout = {
                    { type = "padding", val = 1 }, header(),
                    { type = "padding", val = 1 }, recents,
                    { type = "padding", val = 1 }, buttons,
                    { type = "padding", val = 1 }, footer(),
                },
                opts = { margin = 5 },
            }
            return dashboard
        end,
    },
}

-- vim: ts=4 sts=4 sw=4 et
