local M = {}

M.root = vim.fn.expand("~/sources/references")

M.sources = {
    apis = {
        path = "apis",
        pattern = "%.http$",
        title = "API Requests",
    },

    todos = {
        path = "todos",
        pattern = "%.md$",
        title = "Todo List",
    },

    runs = {
        path = "runs",
        pattern = "%.md$",
        title = "Run Requests",
    },

    notes = {
        path = "notes",
        pattern = "%.md$",
        title = "Notes",
    },
}

local function get_source(name)
    local source = M.sources[name]

    if not source then
        error("Unknown reference source: " .. name)
    end

    return source
end

local function get_path(name)
    local source = get_source(name)
    return vim.fs.joinpath(M.root, source.path)
end

-- Forward declaration because picker() can call create().
local create

local function picker(name)
    local source = get_source(name)
    local path = get_path(name)

    local files = vim.fs.find(function(filename)
        return filename:match(source.pattern)
    end, {
        path = path,
        type = "file",
        limit = math.huge,
    })

    if #files == 0 then
        create(name)
        return
    end

    local items = vim.tbl_map(function(file)
        return {
            text = vim.fs.relpath(path, file),
            file = file,
        }
    end, files)

    table.sort(items, function(a, b)
        return a.text < b.text
    end)

    Snacks.picker({
        title = source.title,
        items = items,

        format = function(item)
            return {
                { item.text, "SnacksPickerLabel" },
            }
        end,

        confirm = function(picker_instance, item)
            picker_instance:close()

            if item then
                vim.cmd.edit(vim.fn.fnameescape(item.file))
            end
        end,
    })
end

local function slugify(text)
    text = text:lower()
    text = text:gsub("%s+", "-")
    text = text:gsub("[^%w%-]", "")
    text = text:gsub("%-+", "-")
    text = text:gsub("^%-", "")
    text = text:gsub("%-$", "")

    return text
end

local function next_available_file(path, title)
    local date = os.date("%Y-%m-%d")
    local slug = slugify(title)

    if slug == "" then
        slug = "untitled"
    end

    local base = string.format("%s-%s", date, slug)
    local file = vim.fs.joinpath(path, base .. ".md")

    if not vim.uv.fs_stat(file) then
        return file
    end

    local i = 2

    while true do
        file = vim.fs.joinpath(
            path,
            string.format("%s-%d.md", base, i)
        )

        if not vim.uv.fs_stat(file) then
            return file
        end

        i = i + 1
    end
end

create = function(name)
    local path = get_path(name)

    vim.fn.mkdir(path, "p")

    vim.ui.input({
        prompt = "New " .. name .. ": ",
    }, function(title)
        if not title or title == "" then
            return
        end

        local file = next_available_file(path, title)
        local date = os.date("%Y-%m-%d")

        local content = string.format(
            "# %s\n\nCreated: %s\n\n",
            title,
            date
        )

        vim.fn.writefile(vim.split(content, "\n"), file)

        vim.cmd.edit(vim.fn.fnameescape(file))
    end)
end

function M.open(name)
    picker(name)
end

function M.new(name)
    create(name)
end

function M.apis()
    M.open("apis")
end

function M.todos()
    M.open("todos")
end

function M.runs()
    M.open("runs")
end

function M.notes()
    M.open("notes")
end

function M.new_todo()
    M.new("todos")
end

function M.new_run()
    M.new("runs")
end

function M.new_note()
    M.new("notes")
end

return M
