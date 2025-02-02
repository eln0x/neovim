--
-- Notify configuration
--
-- https://github.com/rcarriga/nvim-notify

local vim = vim

local notify_ok, notify = pcall(require, "notify")
if not notify_ok then
    return
end

notify.setup({
    stages = 'slide',
    timeout = 3000,
    max_height = function()
        return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
        return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
})

local noice_ok, notify = pcall(require, "noice")
if not noice_ok then
    vim.notify = require("notify")
end

-- Lsp notification customization
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local level = ({
        'ERROR',
        'WARN',
        'INFO',
        'DEBUG',
    })[result.type]
    notify(
        { result.message },
        level,
        {
            title = '[lsp] | ' .. client.name,
            keep = function()
                return level == 'ERROR' or level == 'WARN'
            end,
        }
    )
end

vim.lsp.buf.rename = function()
    local position_params = vim.lsp.util.make_position_params()
    position_params.oldName = vim.fn.expand("<cword>")
    position_params.newName = vim.fn.input("Rename To> ", position_params.oldName)

    vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, result, ...)
        if not result or not result.changes then
            notify(
                string.format('could not perform rename'),
                'error',
                {
                    title = string.format(
                        '[lsp] rename: %s -> %s',
                        position_params.oldName,
                        position_params.newName
                    ),
                    timeout = 2500
                })
            return
        end

        vim.lsp.handlers["textDocument/rename"](err, result, ...)
        local notification, entries = '', {}
        local num_files, num_updates = 0, 0
        for uri, edits in pairs(result.changes) do
            num_files = num_files + 1
            local bufnr = vim.uri_to_bufnr(uri)
            for _, edit in ipairs(edits) do
                local start_line = edit.range.start.line + 1
                local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]
                num_updates = num_updates + 1
                table.insert(entries, {
                    bufnr = bufnr,
                    lnum = start_line,
                    col = edit.range.start.character + 1,
                    text = line
                })
            end
            local short_uri = string.sub(vim.uri_to_fname(uri), #vim.fn.getcwd() + 2)
            notification = notification .. string.format('made %d change(s) in %s', #edits, short_uri)
        end
        notify(
            notification,
            'info',
            {
                title = string.format(
                    '[lsp] rename: %s -> %s',
                    position_params.oldName,
                    position_params.newName
                ),
                timeout = 2000
            })
    end)
end

-- Lsp notification customization
--local plugin = "My Awesome Plugin"
--vim.notify("This is an error message.\nSomething went wrong!", "error", {
--  title = plugin,
--  on_open = function()
--    vim.notify("Attempting recovery.", vim.log.levels.WARN, {
--      title = plugin,
--    })
--    local timer = vim.loop.new_timer()
--    timer:start(2000, 0, function()
--      vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
--        title = plugin,
--        timeout = 3000,
--        on_close = function()
--          vim.notify("Problem solved", nil, { title = plugin })
--          vim.notify("Error code 0x0395AF", 1, { title = plugin })
--        end,
--      })
--    end)
--  end,
--})

-- vim: ts=4 sts=4 sw=4 et
