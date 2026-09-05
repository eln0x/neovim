local M = {}

M.dir = vim.fn.expand("~/sources/kulala")

function M.open()
    local files = vim.fs.find(function(name)
        return name:match("%.http$")
    end, {
        path = M.dir,
        type = "file",
        limit = math.huge,
    })

    local items = vim.tbl_map(function(file)
        return {
            text = vim.fs.relpath(M.dir, file),
            file = file,
        }
    end, files)

    table.sort(items, function(a, b)
        return a.text < b.text
    end)

    Snacks.picker({
        title = "REST requests",
        items = items,

        format = function(item)
            return {
                { item.text, "SnacksPickerLabel" },
            }
        end,

        confirm = function(picker, item)
            picker:close()

            if item then
                vim.cmd("edit " .. vim.fn.fnameescape(item.file))
            end
        end,
    })
end

return M
